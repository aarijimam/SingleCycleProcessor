module Control_Unit(clk, reset, inst_in, opCode, dst, src1, src2, shamt, iconst, jconst, regWrite, memWrite, PCsrc, memtoReg, ALUsrc);

input					clk, reset;
input		[15 : 0]	inst_in;
output		[3  : 0]	opCode;
output		[5  : 0]	iconst; 
output		[8  : 0]	jconst;

output		[2  : 0]	dst, src1, src2, shamt;
output	reg				regWrite, memWrite, PCsrc, memtoReg;  
output	reg	[1  : 0]	ALUsrc;  

// Bit Slicing / Decoding
assign	opCode	=	inst_in	[3  :  0];
assign	dst		=	inst_in	[6  :  4];
assign	src1	=	inst_in	[9  :  7];
assign	src2	=	inst_in	[12 : 10];
assign	shamt	=	inst_in	[15 : 13];
assign	iconst	=	inst_in	[15 : 10];
assign	jconst	=	inst_in	[12 :  4];

// Assigning of Values to Control Signals
always@(*) begin
    if (reset == 0) begin
        regWrite	= 0;
        memWrite	= 0;
        PCsrc		= 0;
        memtoReg	= 0;
		ALUsrc		= 0;
    end //end of if (reset == 0)
    else begin //main else
    //regWrite
        if (opCode < 4'b 1000)
            regWrite = 1'b 1;
        else
            regWrite = 1'b 0;
    //memWrite
        if (opCode == 4'b 1000)
            memWrite = 1'b 1;
        else
            memWrite = 1'b 0;
    //PCsrc
        if (opCode == 4'b 1001)
            PCsrc = 1'b 1;
        else
            PCsrc = 1'b 0;
    //memtoReg
        if (opCode == 4'b 0111)
            memtoReg = 1'b 1;
        else
            memtoReg = 1'b 0;   
	//ALUsrc
		if (opCode == 4'b 0101 || opCode == 4'b 0110 || opCode == 4'b 0111 || opCode == 4'b 1000)
			ALUsrc = 2'b 01;
		else if (opCode == 4'b 0001 || opCode == 4'b 0010)
			ALUsrc = 2'b 10;
		else
			ALUsrc = 2'b 00;
    end //end of main else()
end
endmodule