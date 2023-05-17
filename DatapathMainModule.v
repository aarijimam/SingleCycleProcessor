

 module datapath(clk,reset,display_control,sseg_cathode,sseg_anode);
 
	input clk,reset;
	input [1:0]display_control;
	wire [31:0]index;
	wire [31:0]indexout;
	wire [31:0]out,display_value;
	wire [5:0]funct;
	wire [4:0]rd,rs,rt,shamt, write_reg;
	wire [31:0]a,b,write_data,read_data,InstrReg,alu_inp,extended_const;
	wire [15:0]const;
	wire [25:0]address;
	wire RegWrite,MemWrite,MemRead,RegDst,ALUSrc,Branch,Jump,MemtoReg,Zero;
	wire [1:0] ALUOp;
	output wire [6:0]sseg_cathode;
	output wire [3:0]sseg_anode;


//PC
PC pc (clk, reset, index, Jump, Branch, Zero, address, extended_const);

//Instruction Fetch
ROM rom (index,InstrReg);
	
//Decoder
decoder y (InstrReg,funct[5:0],rs[4:0],rt[4:0],rd[4:0],shamt[4:0],const[15:0],address[25:0],RegWrite,MemWrite,MemRead,RegDst,ALUSrc,Branch,Jump,MemtoReg,ALUOp[1:0]);

sign_extend_16 extender (const,extended_const);

mux write_selector(read_data,out,MemtoReg,write_data);

mux dest_selector(rd[4:0],rt,RegDst,write_reg);
//Register File
RegisterFile r (clk, reset, rs, rt, write_reg, RegWrite, write_data, a, b);


mux ALU_input_selector(extended_const,b,ALUSrc,alu_inp);
//ALU
ALU z (a[31:0],alu_inp[31:0],shamt[4:0],funct[5:0],ALUOp[1:0],out[31:0],Zero);


//Data Memory
//DataMemory(address,write_data,MemRead,MemWrite,read_data);
DataMemory dm (clk, out,b,MemRead,MemWrite,read_data);

seven_seg seg (display_value[3:0],sseg_cathode,sseg_anode);

mux4_2 display_mux(out,a,b,0,display_control,display_value);

endmodule 
  



