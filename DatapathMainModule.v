

 module datapath(clk,reset);
 
	reg [31:0] ROM [15:0];
 	reg [31:0] RegisterFile [7:0];
    reg [31:0] DataMemory [7:0];
	input clk,reset;
	reg [3:0]index;
	reg [1:0]type;
	wire [5:0]opcode, funct;
	wire [4:0]rd,rs,rt,shamt;
	reg [31:0]a,b,memoryvalue,regdata,InstrReg;
	wire [15:0]const;
	wire [25:0]address;
	reg RegWrite,MemWrite,MemRead,RegDst,ALUSrc,PCSrc,Branch,zero;
	reg [1:0] ALUOp;
	wire [15:0] d,dataaddress;
	reg [3:0] ra;
initial
begin
	index=0;
end
	//Instruction Memory/ROM
initial
begin
	ROM[0] = 32'b 0000110100010000;
	ROM[1] = 32'b 0100110100010001;
	ROM[2] = 32'b 0000100100010111;
	ROM[3] = 32'b 0000110100011000;
	ROM[4] = 32'b 0000000000101001;
	ROM[5] = 32'b 0100110100010001;
	ROM[6] = 32'b 0000110100010000;
	ROM[7] = 32'b 0000100000001001;
	ROM[8] = 32'b 0001100101000000;
	ROM[9] = 32'b 0001100101000000;
	ROM[10] = 32'b 0001100101000000;
	ROM[11] = 32'b 0100000101001110;
	ROM[12] = 32'b 0001100101000000;
	ROM[13] = 32'b 1100000101000001;
	ROM[14] = 32'b 0000001110110111;
	ROM[15] = 32'b 0001100101000000;
end

//Register Files
initial
begin
  RegisterFile[0] = 32'b 0000000000000000;
  RegisterFile[1] = 32'b 0000000000000000;
  RegisterFile[2] = 32'b 0000000000000010;
  RegisterFile[3] = 32'b 0000000000000001;
  RegisterFile[4] = 32'b 0000000000000000;
  RegisterFile[5] = 32'b 0000000000000001;
  RegisterFile[6] = 32'b 0000000000000001;
  RegisterFile[7] = 32'b 0000000000000001;
  //RegisterFile[8] = 16'b 0000000000000000;
end

initial
begin
  DataMemory[0] = 32'b 0000000000000000;
  DataMemory[1] = 32'b 0000000000000000;
  DataMemory[2] = 32'b 0000000000000111;
  DataMemory[3] = 32'b 0000000000011011;
  DataMemory[4] = 32'b 0000001111111111;
  DataMemory[5] = 32'b 0000000000000000;
  DataMemory[6] = 32'b 0000000000000001;
  DataMemory[7] = 32'b 0000000000000001;
  //DataMemory[8] = 16'b 0000000000000000;
end

  
  //determining instruction type + decoding
always@(posedge clk, negedge reset)
begin
    if (reset==1)
		index=0;
    else
	InstrReg = ROM[index][31:0];
end
	
	decoder y (InstrReg,opcode,rs,rt,rd,shamt,const,address,funct,RegWrite,MemRead,MemWrite,RegDst,ALUSrc,PCSrc,Branch,MemtoReg,ALUOp);
always @ (posedge clk)
begin
	a = RegisterFile[rs];
	if(ALUSrc == 0)
		b = RegisterFile[rt];
	else
		b = const;
end

ALU z (a,b,shamt,out,zero);

always @ (*)
begin
if(RegWrite == 1)
	RegisterFile[rd] = out;
if(MemRead == 1 && MemtoReg == 1)
begin
if(RegDst = 1)
RegisterFile[rd] = DataMemory[out];
else 
RegisterFile[rt] = DataMemory[out];
end
if(MemWrite == 1)
DataMemory[out] = RegisterFile[rt];

end

 
endmodule 
  



