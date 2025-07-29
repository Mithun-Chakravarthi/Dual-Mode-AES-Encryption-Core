module round(msg,key,round_out);

input [127:0]msg,key;
output  [127:0]round_out;


wire [127:0]data_out1,data_out2,data_out3;


subbytes dut(msg,data_out1);
shift_rows duta(data_out1,data_out2);
mix_columns1 dutb(data_out2,data_out3);

assign round_out=data_out3^key;
endmodule

