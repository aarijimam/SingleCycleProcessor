module mux4_2(input_1,input_2,input_3,input_4,selector,out);
input [31:0] input_1,input_2,input_3,input_4;
input [1:0]selector;
output reg [31:0]out;

always @(*)
begin
    case (selector)
        2'b00: out = input_1;
        2'b01: out = input_2;
        2'b10: out = input_3;
        2'b11: out = input_4;
		  default: out = 0;
		  
    endcase
end

endmodule