	
	module decoder (InstrReg,opcode,rs,rt,rd,shamt,const,address,funct);
	input [31:0]InstrReg;
	output reg [4:0]rd,rs,rt,shamt;
	output reg [25:0]address;
	output reg [5:0]opcode,funct;
	output reg [15:0]const;
always @ (*)
begin
	opcode = InstrReg[31:26];
	rs = InstrReg[25:21];
	rt = InstrReg[20:16];
	rd = InstrReg[15:11];
	shamt = InstrReg[10:6];
	funct = InstrReg[5:0];
	const = InstrReg[15:0];
	address = InstrReg[25:0];

	//			add				sub					mul					div					sll
	if(opcode == 100000  || opcode == 100010 || opcode == 011000 || opcode == 011010 || opcode == 000000
	// 		srl					or					and					nor				xor
		opcode == 000010 || opcode == 100101 || opcode == 100100 || opcode == 100111 || opcode == 100110)
	begin
		MemWrite = 0;
		MemRead = 0;
		RegWrite = 1;
	end
	// 		addi					li					lw				sw
	else if(opcode == 001000 || opcode == xxxx || opcode == 100011 || opcode == 101011)
	begin

	end
	//			jump
	else if(opcode == 000010)
	else
	begin
	 $display ("Error:  Incorrent Operand");
	end
end
	endmodule