module shift_rows(din, dout);

input [127:0] din;
output [127:0] dout;

// ShiftRows mapping using assign statements
assign dout[127:120] = din[127:120];
assign dout[119:112] = din[87:80];
assign dout[111:104] = din[47:40];
assign dout[103:96]  = din[7:0];

assign dout[95:88]   = din[95:88];
assign dout[87:80]   = din[55:48];
assign dout[79:72]   = din[15:8];
assign dout[71:64]   = din[103:96];

assign dout[63:56]   = din[63:56];
assign dout[55:48]   = din[23:16];
assign dout[47:40]   = din[111:104];
assign dout[39:32]   = din[71:64];

assign dout[31:24]   = din[31:24];
assign dout[23:16]   = din[119:112];
assign dout[15:8]    = din[79:72];
assign dout[7:0]     = din[39:32];

endmodule

