

 module datapath(clk,reset);
 
	input clk,reset;
	wire [31:0]index;
	wire [31:0]indexout;
	wire[31:0]out;
	wire [5:0]opcode, funct;
	wire [4:0]rd,rs,rt,shamt;
	wire [31:0]a,b,InstrReg;
	wire [15:0]const;
	wire [25:0]address;
	wire RegWrite,MemWrite,MemRead,RegDst,ALUSrc,PCSrc,Branch,Jump,MemtoReg,Zero;
	wire [1:0] ALUOp;




//PC
PC pc (clk, reset, index, Jump, Branch, Zero, address, const);

//Instruction Fetch
ROM(index,InstrReg);
	
//Decoder
decoder y (InstrReg,opcode[5:0],funct[5:0],rs[4:0],rt[4:0],rd[4:0],shamt[4:0],const[15:0],address[25:0],RegWrite,MemWrite,MemRead,RegDst,ALUSrc,PCSrc,Branch,Jump,MemtoReg,ALUOp[1:0]);

//Register File
RegisterFile(rs,rt,)
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
			RegisterFile[rt] = out; 
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



endmodule 
  



