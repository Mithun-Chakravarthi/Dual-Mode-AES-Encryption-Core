
module mix_columns1(
input [127:0] data_in,
output [127:0] data_out
    );
    
wire [31:0] W0,W1,W2,W3;
assign W0=data_in[127:96];//input assign
assign W1=data_in[95:64];
assign W2=data_in[63:32];
assign W3=data_in[31:0];

wire [7:0] W0R0,W0R1,W0R2,W0R3,W1R0,W1R1,W1R2,W1R3,W2R0,W2R1,W2R2,W2R3,W3R0,W3R1,W3R2,W3R3;
assign W0R0=W0[31:24];
assign W0R1=W0[23:16];
assign W0R2=W0[15:8];
assign W0R3=W0[7:0];

assign W1R0=W1[31:24];
assign W1R1=W1[23:16];
assign W1R2=W1[15:8];
assign W1R3=W1[7:0];

assign W2R0=W2[31:24];
assign W2R1=W2[23:16];
assign W2R2=W2[15:8];
assign W2R3=W2[7:0];

assign W3R0=W3[31:24];
assign W3R1=W3[23:16];
assign W3R2=W3[15:8];
assign W3R3=W3[7:0];

wire [7:0] s002, s003, s012, s013, s022, s023, s032, s033;
//word 0
mul2 b002(.data_in( W0R0  ),.data_out( s002   ));
mul3 b003(.data_in( W0R0  ),.data_out( s003   ));

mul2 b012(.data_in( W0R1 ),.data_out(  s012   ));
mul3 b013(.data_in( W0R1  ),.data_out(  s013  ));

mul2 b022(.data_in( W0R2 ),.data_out(  s022   ));
mul3 b023(.data_in( W0R2  ),.data_out(  s023  ));

mul2 b032(.data_in( W0R3 ),.data_out(  s032   ));
mul3 b033(.data_in( W0R3  ),.data_out(  s033  ));

///////word1
wire [7:0] s102, s103, s112, s113, s122, s123, s132, s133;

mul2 b102(.data_in( W1R0  ),.data_out( s102   ));
mul3 b103(.data_in( W1R0  ),.data_out( s103   ));

mul2 b112(.data_in( W1R1 ),.data_out(  s112   ));
mul3 b113(.data_in( W1R1  ),.data_out(  s113  ));

mul2 b122(.data_in( W1R2 ),.data_out(  s122   ));
mul3 b123(.data_in( W1R2  ),.data_out(  s123  ));

mul2 b132(.data_in( W1R3 ),.data_out(  s132   ));
mul3 b133(.data_in( W1R3  ),.data_out(  s133  ));

///////word2
wire [7:0] s202, s203, s212, s213, s222, s223, s232, s233;

mul2 b202(.data_in( W2R0  ),.data_out( s202   ));
mul3 b203(.data_in( W2R0  ),.data_out( s203   ));

mul2 b212(.data_in( W2R1 ),.data_out(  s212   ));
mul3 b213(.data_in( W2R1  ),.data_out( s213  ));

mul2 b222(.data_in( W2R2 ),.data_out(  s222   ));
mul3 b223(.data_in( W2R2  ),.data_out( s223  ));

mul2 b232(.data_in( W2R3 ),.data_out(  s232   ));
mul3 b233(.data_in( W2R3  ),.data_out( s233  ));

///////word3
wire [7:0] s302, s303, s312, s313, s322, s323, s332, s333;

mul2 b302(.data_in( W3R0  ),.data_out( s302   ));
mul3 b303(.data_in( W3R0  ),.data_out( s303   ));

mul2 b312(.data_in( W3R1 ),.data_out(  s312   ));
mul3 b313(.data_in( W3R1  ),.data_out( s313  ));

mul2 b322(.data_in( W3R2 ),.data_out(  s322   ));
mul3 b323(.data_in( W3R2  ),.data_out( s323  ));

mul2 b332(.data_in( W3R3 ),.data_out(  s332   ));
mul3 b333(.data_in( W3R3  ),.data_out( s333  ));

///////
//word 0
assign data_out[127:120]= s002^ s013 ^ W0R2 ^W0R3 ;
assign data_out[119:112]= W0R0 ^ s012^ s023 ^W0R3;
assign data_out[111:104]= W0R0^ W0R1 ^s022 ^s033;
assign data_out[103:96]= s003^ W0R1^ W0R2 ^ s032;
//word1
assign data_out[95:88]= s102^ s113 ^ W1R2 ^W1R3 ;
assign data_out[87:80]= W1R0 ^ s112^ s123 ^W1R3;
assign data_out[79:72]=W1R0^ W1R1 ^s122 ^s133;
assign data_out[71:64]=s103^ W1R1^ W1R2 ^ s132;
//wprd2
assign data_out[63:56]= s202^ s213 ^ W2R2 ^W2R3 ;
assign data_out[55:48]= W2R0 ^ s212^ s223 ^W2R3;
assign data_out[47:40]=W2R0^ W2R1 ^s222 ^s233;
assign data_out[39:32]=s203^ W2R1^ W2R2 ^ s232;
//word3
assign data_out[31:24]= s302^ s313 ^ W3R2 ^W3R3 ;
assign data_out[23:16]= W3R0 ^ s312^ s323 ^W3R3;
assign data_out[15:8]=W3R0^ W3R1 ^s322 ^s333;
assign data_out[7:0] =s303^ W3R1^ W3R2 ^ s332;


endmodule
