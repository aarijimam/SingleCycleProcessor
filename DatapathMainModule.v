

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


	wire [31:0] a_out;
	wire [31:0] b_out;
	wire [31:0] write_data_out;
	wire [31:0] rd_register;

//PC
PC pc (clk, reset, index, Jump, Branch, Zero, address, extended_const, out);

//Instruction Fetch
ROM rom (clk, index,InstrReg);
	
//Decoder
decoder y (clk, InstrReg,funct[5:0],rs[4:0],rt[4:0],rd[4:0],shamt[4:0],const[15:0],address[25:0],RegWrite,MemWrite,MemRead,RegDst,ALUSrc,Branch,Jump,MemtoReg,ALUOp[1:0]);

sign_extend_16 extender (const,extended_const);

mux write_selector(read_data,out,MemtoReg,write_data);

mux dest_selector(rd[4:0],rt,RegDst,write_reg);
//Register File
RegisterFile r (clk, reset, rs, rt, write_reg, RegWrite, write_data_out, a, b);

register reg_data(.clk(clk),.rst(reset),.a_in(write_data),.a_out(write_data_out));

//register rd_reg(.clk(clk),.rst(reset),.a_in(rd),.a_out(rd_register));


mux ALU_input_selector(extended_const,b,ALUSrc,alu_inp);

register a_reg (.clk(clk),.rst(reset),.a_in(a),.a_out(a_out));
register b_reg (.clk(clk),.rst(reset),.a_in(alu_inp),.a_out(b_out));


//ALU
ALU z (clk, a_out[31:0],b_out[31:0],shamt[4:0],funct[5:0],ALUOp[1:0],out[31:0],Zero);


//Data Memory
//DataMemory(address,write_data,MemRead,MemWrite,read_data);
DataMemory dm (clk, out,b,MemRead,MemWrite,read_data);

seven_seg seg (display_value[3:0],sseg_cathode,sseg_anode);

mux4_2 display_mux(out,a,b,0,display_control,display_value);

endmodule 
  



