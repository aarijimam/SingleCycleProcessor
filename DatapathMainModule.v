

 module datapath(clk,reset);
 
	input clk,reset;
	wire [31:0]index;
	wire [31:0]indexout;
	wire[31:0]out;
	wire [5:0]opcode, funct;
	wire [4:0]rd,rs,rt,shamt, write_reg;
	wire [31:0]a,b,write_data,read_data,InstrReg,alu_inp;
	wire [15:0]const;
	wire [25:0]address;
	wire RegWrite,MemWrite,MemRead,RegDst,ALUSrc,PCSrc,Branch,Jump,MemtoReg,Zero;
	wire [1:0] ALUOp;




//PC
PC pc (clk, reset, index, Jump, Branch, Zero, address, const);

//Instruction Fetch
ROM rom (index,InstrReg);
	
//Decoder
decoder y (InstrReg,opcode[5:0],funct[5:0],rs[4:0],rt[4:0],rd[4:0],shamt[4:0],const[15:0],address[25:0],RegWrite,MemWrite,MemRead,RegDst,ALUSrc,PCSrc,Branch,Jump,MemtoReg,ALUOp[1:0]);

mux write_selector(read_data,out,MemtoReg,write_data);

mux dest_selector(rd,rt,RegDst,write_reg);
//Register File
RegisterFile r (clk, rs, rt, write_reg, RegWrite, write_data, a, b);


mux ALU_input_selector(const,b,ALUSrc,alu_inp);
//ALU
ALU z (a[31:0],alu_inp[31:0],shamt[4:0],funct[5:0],ALUOp[1:0],out[31:0],Zero);


//Data Memory
//DataMemory(address,write_data,MemRead,MemWrite,read_data);
DataMemory dm (clk, out,b,MemRead,MemWrite,read_data);


endmodule 
  



