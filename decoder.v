	
	module decoder (InstrReg,opcode,rs,rt,rd,shamt,const,address,funct,RegWrite,MemWrite,MemRead,RegDst,ALUSrc,PCSrc,Branch,ALUOp);
	input [31:0]InstrReg;
	output reg [4:0]rd,rs,rt,shamt;
	output reg [25:0]address;
	output reg [5:0]opcode,funct;
	output reg [15:0]const;
	//Control Unit
	output reg RegWrite,MemWrite,MemRead,RegDst,ALUSrc,PCSrc,Branch;
	output reg [1:0]ALUOp;
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

	//			add						sub						mul					div						sll
	
	// 			srl						or						and					nor						xor
	if(opcode == 6'b 000000)
	begin
		MemWrite = 0;
		MemRead = 0;
		RegWrite = 1;
		RegDst = 1;
		ALUSrc = 0;
		Branch = 0;
		ALUOp = 2'b 10;
	end

	//I Type
	// 		addi				
	else if(opcode == 001000)
	begin
		MemWrite = 0;
		MemRead = 0;
		RegWrite = 1;
		RegDst = 0;
		ALUSrc = 1;
		Branch = 0;
		ALUOp = 2'b 00;
	end
	//		li(pseudo)
	else if(opcode == 100111)
	begin 
		MemWrite = 0;
		MemRead = 0;
		RegWrite = 1;
		RegDst = 0;
		ALUSrc = 1;
		Branch = 0;
		ALUOp = 2'b 00;
	end
	//		lw
	else if(opcode == 100011)
	begin 
		MemWrite = 0;
		MemRead = 1;
		RegWrite = 1;
		RegDst = 0;
		ALUSrc = 1;
		Branch = 0;
		ALUOp = 2'b 00;
	end
	//			sw
	else if(opcode == 101011)
	begin 
		MemWrite = 1;
		MemRead = 0;
		RegWrite = 0;
		RegDst = 1;
		ALUSrc = 1;
		Branch = 0;
		ALUOp = 2'b 00;
	end

	//			jump
	else if(opcode == 000010)
	begin 

	end
	//		beq
	else if(opcode == 000100)
	begin 
		MemWrite = 0;
		MemRead = 0;
		RegWrite = 0;
		RegDst = 1;
		ALUSrc = 0;
		Branch = 1;
		ALUOp = 2'b 01;
	end

	else
	begin
	 $display ("Error:  Incorrent Operand");
	end
end
	endmodule