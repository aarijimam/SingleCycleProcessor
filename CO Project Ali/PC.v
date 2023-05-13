module    Prgm_Counter(clk, reset, PCsrc, address, PCreg);

input                 PCsrc, clk, reset;
input         [8 : 0] address;
output    reg [7 : 0] PCreg;
wire          [7 : 0] temp;

assign    temp = PCreg + 1;

always@(posedge clk, negedge reset)
begin

    if (reset == 0) begin
        PCreg = 0;
	end
    else begin
        if (PCsrc == 1)
            PCreg = temp + address;
        else
            PCreg = temp;
    end
end

endmodule