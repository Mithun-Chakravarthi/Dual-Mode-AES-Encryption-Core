module key_expansion(
input [127:0]input_key,
input [31:0]roundcount,
output [127:0]subkey
    );
 
wire [31:0] W0,W1,W2,W3;//words
wire [31:0] subword;
wire [31:0]g;
//reg [31:0]roundcount;

assign W0=input_key[127:96];//input assign
assign W1=input_key[95:64];
assign W2=input_key[63:32];
assign W3=input_key[31:0];

wire [31:0]rotword={W3[23:16],W3[15:8],W3[7:0],W3[31:24]};

sbox s1(.data(rotword[7:0] ),.dout(subword[7:0] ));
sbox s2(.data(rotword[15:8] ),.dout(subword[15:8]  ));
sbox s3(.data(rotword[23:16] ),.dout(subword[23:16]  ));
sbox s4(.data(rotword[31:24] ),.dout(subword[31:24]  ));

assign g=subword ^ roundcount;
//outputs
assign subkey[127:96]=g^W0;
assign subkey[95:64]=subkey[127:96]^W1;
assign subkey[63:32]=subkey[95:64]^W2;
assign subkey[31:0]=subkey[63:32]^W3;

endmodule
