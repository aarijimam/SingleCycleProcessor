module	CPU(clk, reset, reg0, reg1, reg2, reg3, reg4, reg5, reg6, reg7, dataMemValue0, dataMemValue1, dataMemValue2, dataMemValue3, dataMemValue4, dataMemValue5, dataMemValue6, dataMemValue13, ALUout, ALUin1, ALUin2, regDataIn);

output	[15 : 0]	reg0, reg1, reg2, reg3, reg4, reg5, reg6, reg7, dataMemValue0, dataMemValue1, dataMemValue2, dataMemValue3, dataMemValue4, dataMemValue5, dataMemValue6, dataMemValue7, ALUout, ALUin1, ALUin2, regDataIn;

input				clk, reset;
wire	[7  : 0]	prgm_cntr;

wire 				PCsrc, regWrite, memWrite, memtoReg;
wire	[1  : 0]	ALUsrc;
wire 	[3  : 0]	opCode;
wire	[2	: 0]	dst, src1, src2, shamt;
wire	[5  : 0]	iconst;
wire	[8  : 0]	jconst;
wire	[15 : 0]	instr;

reg		[15 : 0]	instrMem[14 : 0];



Prgm_Counter	C1	(clk, reset, PCsrc, jconst, prgm_cntr);
assign instr	=	instrMem[prgm_cntr];
Control_Unit	C2	(clk, reset, instr, opCode, dst, src1, src2, shamt, iconst, jconst, regWrite, memWrite, PCsrc, memtoReg, ALUsrc);
DataPath		C3	(clk, reset, opCode, dst, src1, src2, shamt, iconst, regWrite, memtoReg, memWrite, ALUsrc, reg0, reg1, reg2, reg3, reg4, reg5, reg6, reg7, dataMemValue0, dataMemValue1, dataMemValue2, dataMemValue3, dataMemValue4, dataMemValue5, dataMemValue6, dataMemValue7, ALUout, ALUin1, ALUin2, regDataIn);

initial
begin
	instrMem[0 ] = 16'b	0000000000000110;
	instrMem[1 ] = 16'b	0010100000010110;
	instrMem[2 ] = 16'b	0010010000100110;
	instrMem[3 ] = 16'b	0000000000110111;
	instrMem[4 ] = 16'b	0001000010010101;
	instrMem[5 ] = 16'b	0010000100010001;
	instrMem[6 ] = 16'b	0010000100010010;
	instrMem[7 ] = 16'b	0000100010110000;
	instrMem[8 ] = 16'b	0000000010111001;
	instrMem[9 ] = 16'b	0000100100010000;
	instrMem[10] = 16'b	0000000000000000;
	instrMem[11] = 16'b	0000010101000011;
	instrMem[12] = 16'b	0000010100100100;
	instrMem[13] = 16'b	0000110000011000;
end

endmodule