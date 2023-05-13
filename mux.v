module mux(input_1,input_2,selector,out);
input [31:0] input_1,input_2;
input selector;
output reg [31:0]out;

always @(*)
begin
    if(selector)
        out = input_1;
    else
        out = input_2;

end

endmodule