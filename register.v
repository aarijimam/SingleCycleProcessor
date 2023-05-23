module register(
    input clk,
    input rst,
    input [31:0]a_in,
    output reg [31:0]a_out);

    always @ (posedge clk)
    begin 
        a_out = a_in;
    end

endmodule


