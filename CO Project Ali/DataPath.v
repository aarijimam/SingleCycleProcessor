module DataPath (clk, reset, ALUselect, dst, src1, src2, shamt, iconst, regWrite, memtoReg, memWrite, ALUsrc, reg0, reg1, reg2, reg3, reg4, reg5, reg6, reg7, dataMemValue0, dataMemValue1, dataMemValue2, dataMemValue3, dataMemValue4, dataMemValue5, dataMemValue6, dataMemValue7, ALUout, ALUin1, ALUin2, regDataIn);

output		[15 : 0]	reg0, reg1, reg2, reg3, reg4, reg5, reg6, reg7, dataMemValue0, dataMemValue1, dataMemValue2, dataMemValue3, dataMemValue4, dataMemValue5, dataMemValue6, dataMemValue7, ALUout, ALUin1, regDataIn;

output reg	[15 : 0]	ALUin2;

input					clk, reset, regWrite, memtoReg, memWrite;
input		[1  : 0]	ALUsrc;
input		[2  : 0]	dst, src1, src2, shamt;
input  		[3  : 0]	ALUselect;
input		[5  : 0]	iconst;

reg			[15 : 0]	regDataIn;

reg			[15 : 0]	regFile[0  : 7];
reg			[3  : 0]	i;

reg			[15 : 0]	dataMem[31 : 0];

assign ALUin1	=	regFile[src1];

ALU		DP1	(ALUselect, ALUin1, ALUin2, ALUout);


assign	  reg0 = regFile[0];
assign	  reg1 = regFile[1];
assign    reg2 = regFile[2];
assign    reg3 = regFile[3];
assign    reg4 = regFile[4];
assign    reg5 = regFile[5];
assign    reg6 = regFile[6];
assign    reg7 = regFile[7];

assign	  dataMemValue0  = dataMem[0];
assign	  dataMemValue1  = dataMem[1];
assign    dataMemValue2  = dataMem[2];
assign    dataMemValue3  = dataMem[3];
assign    dataMemValue4  = dataMem[4];
assign    dataMemValue5  = dataMem[5];
assign    dataMemValue6  = dataMem[6];
assign    dataMemValue7  = dataMem[7];


always@(posedge clk, negedge reset)
begin
	if (reset == 0) begin
		for (i = 0; i < 9; i = i + 1) begin
		regFile[i] = 0;
		end //end of for()
	end //end of if()
	
	else begin
		if (memtoReg == 1)
			regDataIn 		=	dataMem[ALUout];
		else
			regDataIn		=	ALUout;
		if (regWrite == 1)
			regFile[dst]	=	regDataIn;
		if (memWrite == 1)
			dataMem[ALUout]	=	regFile[dst];
	end //end of else()
end //end of always@()

always@(*)
begin
	if (ALUsrc == 0)
		ALUin2	=	regFile[src2];
	else if (ALUsrc == 1)
		ALUin2 = iconst;
	else if (ALUsrc == 2)
		ALUin2 = shamt;
end

initial
begin
dataMem[0 ] = 16'b 0100;  
dataMem[1 ] = 16'b 0010;
dataMem[2 ] = 16'b 0001;
dataMem[3 ] = 16'b 0110;
dataMem[4 ] = 16'b 0011;
dataMem[5 ] = 16'b 1000;
dataMem[6 ] = 16'b 1100;
dataMem[7 ] = 16'b 0101;
dataMem[8 ] = 16'b 0101;
dataMem[9 ] = 16'b 0001;
dataMem[10] = 16'b 0010;
dataMem[11] = 16'b 0011;
dataMem[12] = 16'b 0100;
end
endmodule