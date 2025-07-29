module aes_ebc(data_in,key,data_out);
input [127:0]data_in,key;
output [127:0]data_out;

wire [127:0]subkey1,subkey2,subkey3,subkey4,subkey5,subkey6,subkey7,subkey8,subkey9,subkey10;
wire [127:0]round_out1,round_out2,round_out3,round_out4,round_out5,round_out6,round_out7,round_out8,round_out9,round_out10;
wire [127:0]msg_xor;

assign msg_xor=data_in^key;


key_expansion subkeys1(.input_key(key),.roundcount(32'h01_00_00_00),.subkey(subkey1));
round a1(msg_xor,subkey1,round_out1);

key_expansion subkeys2(.input_key(subkey1),.roundcount(32'h02_00_00_00),.subkey(subkey2));
round a2(round_out1,subkey2,round_out2);

key_expansion subkeys3(.input_key(subkey2),.roundcount(32'h04_00_00_00),.subkey(subkey3));
round a3(round_out2,subkey3,round_out3);

key_expansion subkeys4(.input_key(subkey3),.roundcount(32'h08_00_00_00),.subkey(subkey4));
round a4(round_out3,subkey4,round_out4);

key_expansion subkeys5(.input_key(subkey4),.roundcount(32'h10_00_00_00),.subkey(subkey5));
round a5(round_out4,subkey5,round_out5);

key_expansion subkeys6(.input_key(subkey5),.roundcount(32'h20_00_00_00),.subkey(subkey6));
round a6(round_out5,subkey6,round_out6);

key_expansion subkeys7(.input_key(subkey6),.roundcount(32'h40_00_00_00),.subkey(subkey7));
round a7(round_out6,subkey7,round_out7);

key_expansion subkeys8(.input_key(subkey7),.roundcount(32'h80_00_00_00),.subkey(subkey8));
round a8(round_out7,subkey8,round_out8);

key_expansion subkeys9(.input_key(subkey8),.roundcount(32'h1B_00_00_00),.subkey(subkey9));
round a9(round_out8,subkey9,round_out9);


key_expansion subkeys10(.input_key(subkey9),.roundcount(32'h36_00_00_00),.subkey(subkey10));
last_round a10(round_out9,subkey10,round_out10);

assign data_out=round_out10;

endmodule
