module PC(clk, index, indexOut, Jump, Branch, Zero, address, const);
input clk;
input [31:0]index;
output reg [31:0]indexOut;
input Jump,Branch, Zero;
input  [25:0]address;
input  [15:0]const;
reg [31:0]jump_address;
reg [31:0]branch_address;

always @ (posedge clk)
begin
    indexOut = index + 4;
    branch_address = indexOut + (const << 2);
    jump_address = address << 2;
    jump_address[31:28] = indexOut [31:28];

    if(Branch & Zero)
    begin
        indexOut = branch_address;
    end
    else if (Jump == 1)
    begin
        indexOut = jump_address;
    end
    else
        indexOut = indexOut;
end

endmodule