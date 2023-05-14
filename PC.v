module PC(clk, reset, index, Jump, Branch, Zero, address, const);
input clk,reset;
//input [31:0]index;
output reg [31:0]index;
input Jump,Branch, Zero;
input  [25:0]address;
input  [15:0]const;

always @ (posedge clk)
begin
	if(reset == 1)
	begin
		index = 0;
	end
	else
	begin
    index = index + 1;

    if(Branch & Zero)
    begin
        index = index + const;
    end
    else if (Jump == 1)
    begin
        index = address;
    end
    else
        index = index;
	end
end

endmodule