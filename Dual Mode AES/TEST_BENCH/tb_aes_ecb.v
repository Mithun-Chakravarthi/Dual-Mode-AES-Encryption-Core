
// THIS TEST-BENCH IS FOR AES ECB CORE
module tb_aes_ecb;

reg [127:0] data_in, key;

wire [127:0] data_out;

// Instantiate DUT (Device Under Test)
aes_ebc dut(data_in, key, data_out);



initial begin
    // Initialize inputs
   
    data_in = 128'h6bc1bee22e409f96e93d7e117393172a;
    key = 128'h2b7e151628aed2a6abf7158809cf4f3c ;

   

  #200;
    $display("Input  = %h", data_in);
    $display("Key    = %h", key);
    $display("Output = %h", data_out);

    $finish;
end
endmodule