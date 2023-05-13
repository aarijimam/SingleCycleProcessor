module PC(clk, reset, index, Jump, Branch, Zero, address, const);
input clk,reset;
//input [31:0]index;
output reg [31:0]index;
input Jump,Branch, Zero;
input  [25:0]address;
input  [15:0]const;
reg [31:0]jump_address;
reg [31:0]branch_address;

always @ (posedge clk)
begin
	if(reset == 1)
	begin
		index = 0;
	end
	else
	begin
    index = index + 1;
    branch_address = index + (const << 2);
    jump_address = address << 2;
    jump_address[31:28] = index [31:28];

    if(Branch & Zero)
    begin
        index = branch_address;
    end
    else if (Jump == 1)
    begin
        index = jump_address;
    end
    else
        index = index;
	end
end

endmodule