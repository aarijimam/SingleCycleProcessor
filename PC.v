module PC(clk, reset,PCWriteCond, index, Jump, Branch, Zero, address, const, out);
input clk,reset, PCWriteCond;
//input [31:0]index;
output reg [31:0]index;
input Jump,Branch, Zero;
input  [25:0]address;
input  [31:0]const;
input [31:0] out;

always @ (posedge clk && PCWriteCond)
begin
	if(reset == 1)
	begin
		index = 0;
	end
	else
	begin
    if(Branch & Zero)
    begin
        index = index + const;
    end
    else if (Jump == 1)
    begin
        index = address;
    end
    
	index = index +1;
	end
end

endmodule