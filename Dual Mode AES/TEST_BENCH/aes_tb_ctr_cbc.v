/////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Bungatavala Mithun Chakravarthi
// 
// Create Date: 27.07.2025 14:01:06
// Design Name:  
// Module Name: aes_tb_ctr_cbc
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module aes_tb_ctr_cbc #(parameter data_width=512)();

  reg clk;
  reg rst;
  reg start;
  reg cntrl;                     // New control signal: 0=CTR, 1=CBC
  reg [127:0] key;
  reg [127:0] counter;
  reg [127:0] iv;                // New IV input for CBC mode
  reg [data_width-1:0] data;
  wire [data_width+15:0] out;
  wire done;

  // Instantiate DUT
  aes_wrapper_ctr_cbc dut (
    .clk(clk),
    .rst(rst),
    .start(start),
    .cntrl(cntrl),              // connect control
    .key(key),
    .counter(counter),
    .iv(iv),                    // connect IV
    .data(data),
    .out(out),
    .done(done)
  );

  initial begin
    clk = 0;
    rst = 1;
    start = 0;
    cntrl = 0;                  // Default CTR mode if cntrl=0 
//  cntrl=1;                    // CBC mode
    counter = 128'hf0f1f2f3f4f5f6f7f8f9fafbfcfdfeff;           // Starting counter value
    iv = 128'h000102030405060708090a0b0c0d0e0f;  // IV for CBC
   
    #3 rst = 0;
    // Common AES test vector key
    key  = 128'h2b7e151628aed2a6abf7158809cf4f3c;

    // Plaintext blocks (512 bits = 4 x 128 bits)
    data = 512'hf69f2445df4f9b17ad2b417be66c3710_30c81c46a35ce411e5fbc1191a0a52ef_ae2d8a571e03ac9c9eb76fac45af8e51_6bc1bee22e409f96e93d7e117393172a;
 // data = 512'h30c81c46a35ce411e5fbc1191a0a52ef_ae2d8a571e03ac9c9eb76fac45af8e51_6bc1bee22e409f96e93d7e117393172a_6bc1bee22e409f96e93d7e117393172a;
    #10 start = 1;
    #10 start = 0;
    
    #29 cntrl=1;
    
    #30 cntrl=0;

    wait(done);  // Wait until done is asserted

    #10;
    $display("\n==== AES Mode: %s ====", cntrl ? "CBC" : "CTR");
    $display("Key       = %h", key);
    $display("Counter   = %h", counter);
    $display("IV        = %h", iv);

    $display("Input1    = %h", data[127:0]);
    $display("Output1   = %h", out[131:0]);

    $display("Input2    = %h", data[255:128]);
    $display("Output2   = %h", out[263:132]);

    $display("Input3    = %h", data[383:256]);
    $display("Output3   = %h", out[395:264]);

    $display("Input4    = %h", data[511:384]);
    $display("Output4   = %h", out[527:396]);

    $finish;
  end

  always #5 clk = ~clk;

endmodule
