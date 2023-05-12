

 module datapath(clk,reset);
 
	reg [31:0] ROM [15:0];
 	reg [31:0] RegisterFile [7:0];
    reg [31:0] DataMemory [7:0];
	input clk,reset;
	reg [31:0]index;
	wire [31:0]indexout;
	wire[31:0]out;
	wire [5:0]opcode, funct;
	wire [4:0]rd,rs,rt,shamt;
	reg [31:0]a,b,InstrReg;
	wire [15:0]const;
	wire [25:0]address;
	wire RegWrite,MemWrite,MemRead,RegDst,ALUSrc,PCSrc,Branch,Jump,MemtoReg,Zero;
	wire [1:0] ALUOp;

initial
begin
	index=0;
end
	
	//Instruction Memory/ROM
initial
begin
	 ROM[0] = 32'b 00000000000000010001000000100000;   
	 ROM[1] = 32'b 00000000011001000010100000100010;
    ROM[2] = 32'b 00000000100001000001000111000000;
    ROM[3] = 32'b 00000000110001000001100000000000;
    ROM[4] = 32'b 00000000000000000010100001000000;
    ROM[5] = 32'b 00010000110001000001000001000000;
    ROM[6] = 32'b 00000000110001000001000000000000;
    ROM[7] = 32'b 00000000100000000000100001000000;
    ROM[8] = 32'b 00000100100001010000000000000000;
    ROM[9] = 32'b 00000100100001010000000000000000;
    ROM[10] = 32'b 00000100100001010000000000000000;
    ROM[11] = 32'b 00010000000001010000100110000000;
    ROM[12] = 32'b 00000100100001010000000000000000;
    ROM[13] = 32'b 00110000000001010000000001000000;
    ROM[14] = 32'b 00000000001001100011000111000000;
    ROM[15] = 32'b 00000100100001010000000000000000;
//                 funct  shamt  rd    rt    rs   opcode  
end

//Register Files
initial
begin
  RegisterFile[0] = 32'b 00000000000000000000000000000001;
  RegisterFile[1] = 32'b 00000000000000000000000000000010;
  RegisterFile[2] = 32'b 00000000000000000000000000000000;
  RegisterFile[3] = 32'b 00000000000000000000000000000101;
  RegisterFile[4] = 32'b 00000000000000000000000000000001;
  RegisterFile[5] = 32'b 00000000000000000000000000000001;
  RegisterFile[6] = 32'b 00000000000000000000000000000001;
  RegisterFile[7] = 32'b 00000000000000000000000000000001;
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
always@(posedge clk)
begin
	InstrReg = ROM[index][31:0];
end
	
decoder y (InstrReg,opcode[5:0],funct[5:0],rs[4:0],rt[4:0],rd[4:0],shamt[4:0],const[15:0],address[25:0],RegWrite,MemRead,MemWrite,RegDst,ALUSrc,PCSrc,Branch,Jump,MemtoReg,ALUOp[1:0]);
always @ (*)
begin
	a = RegisterFile[rs];
	if(ALUSrc == 0) // r type (rs op rt)
		b = RegisterFile[rt];
	else // i type (immidiate)
		b = const;
end

ALU z (a[15:0],b[15:0],shamt[4:0],funct[5:0],ALUOp[1:0],out[31:0],Zero);

always @ (*)
begin

if(RegWrite == 1) // r type reg writing
begin 
	if(MemtoReg == 0)
	begin
		if (RegDst == 1)
			RegisterFile[rd] = out;
		else
			RegisterFile[rs] = out; 
	end
	else if(MemRead == 1 && MemtoReg == 1) // lw
	begin 
		if(RegDst == 1)
			RegisterFile[rd] = DataMemory[out];
		else 
			RegisterFile[rt] = DataMemory[out];
	end
end

if(MemWrite == 1) // sw
	DataMemory[out] = RegisterFile[rt];

end

//PC
PC pc (clk, index, indexout[31:0], Jump, Branch, Zero, address, const);
always @ (*)
begin
	index = indexout;
end

endmodule 
  



