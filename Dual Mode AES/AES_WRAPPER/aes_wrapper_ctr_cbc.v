// AUTHOR : BUNGATAVALA MITHUN CHAKRAVARTHI

module aes_wrapper_ctr_cbc #(parameter data_width = 512)(
  input wire clk,
  input wire rst,
  input wire start,
  input wire cntrl,                      // 0: CTR mode, 1: CBC mode
  input wire [127:0] key,
  input wire [127:0] counter,           // Used in CTR mode
  input wire [127:0] iv,                // Used in CBC mode
  input wire [data_width-1:0] data,     // Plaintext input
  output reg [data_width+15:0] out,      // Ciphertext output
  output reg done
);

// FSM states
localparam IDLE  = 3'd0,
           LOAD  = 3'd1,
           ENC   = 3'd2,
           WRITE = 3'd3,
           DONE  = 3'd4;

reg [2:0] cs, ns;

// Block count
localparam NUM_BLOCKS = data_width / 128;
reg [$clog2(NUM_BLOCKS):0] block_index;

// Internal signals
reg [127:0] ctr_block;
reg [127:0] iv_reg;
reg [127:0] plaintext_block;
reg [127:0] aes_input;
reg [127:0] aes_out;
wire [127:0] aes_enc_out;
reg reg_cntrl,block_sign;
// Instantiate ECB AES core
aes_ebc aes_core (
  .data_in(aes_input),
  .key(key),
  .data_out(aes_enc_out)
);

// State register
always @(posedge clk or posedge rst) begin
  if (rst)
    cs <= IDLE;
  else
    cs <= ns;
end

// Next state logic
always @(*) begin
  case (cs)
    IDLE:  ns = start ? LOAD : IDLE;
    LOAD:  ns = ENC;
    ENC:   ns = WRITE;
    WRITE: ns = (block_index == NUM_BLOCKS - 1) ? DONE : LOAD;
    DONE:  ns = IDLE;
    default: ns = IDLE;
  endcase
end

// Data path + output logic
always @(posedge clk or posedge rst) begin
  if (rst) begin
    out             <= 0;
    done            <= 0;
    block_index     <= 0;
    ctr_block       <= 0;
    iv_reg          <= 0;
    plaintext_block <= 0;
    aes_input       <= 0;
    aes_out         <= 0;
    block_sign      <= cntrl;
    reg_cntrl       <= 0;
  end else begin
    case (cs)
      IDLE: begin
        done        <= 0;
        block_index <= 0;
        ctr_block   <= counter;
        iv_reg      <= iv;
      end

      LOAD: begin
      reg_cntrl=cntrl&block_sign;
      block_sign=0;
        plaintext_block = data[block_index * 128 +: 128];
        if (reg_cntrl == 0) begin
          aes_input <= ctr_block;  // CTR mode
        end else begin
         aes_input <= plaintext_block ^ iv_reg;  // CBC: (PT ^ IV)

        end
      end

      ENC: begin
        aes_out <= aes_enc_out;
        reg_cntrl<=cntrl;
      end

      WRITE: begin
        if (reg_cntrl == 0) begin
//          out[block_index * 128 +: 128] <={ 4'b0,plaintext_block ^ aes_out};
//          ctr_block <= ctr_block + 1;
//        end else begin
//           out[block_index * 128 +: 128] <= {4'b1,aes_out}; // CBC: output = AES(PT ^ IV)
//          iv_reg <= aes_out;                        // CBC: IV = C_i for next block
          out[block_index * 132 +: 132] <={ 4'b0,plaintext_block ^ aes_out};
          ctr_block <= ctr_block + 1;
          
        end else begin
           out[block_index * 132 +: 132] <= {4'b1111,aes_out}; // CBC: output = AES(PT ^ IV)
          iv_reg <= aes_out;                        // CBC: IV = C_i for next block
           
         
        end
        
        block_sign<=1;
        
        block_index <= block_index + 1;
      end

      DONE: begin
        done <= 1;
      end
    endcase
  end
end

endmodule
