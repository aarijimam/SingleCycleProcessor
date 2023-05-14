module sign_extend_16(sixteen_bit,thirtytwo_bit);
input [15:0] sixteen_bit;
output [31:0]thirtytwo_bit;
assign thirtytwo_bit[15:0]=sixteen_bit[15:0];
assign  thirtytwo_bit[31:16]=sixteen_bit[15]?16'b1111_1111_1111_1111:16'b0;


endmodule