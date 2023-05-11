	
	module decoder (InstrReg,opcode,funct,rs,rt,rd,shamt,const,address,RegWrite,MemWrite,MemRead,RegDst,ALUSrc,PCSrc,Branch,Jump,MemtoReg,ALUOp);
	input [31:0]InstrReg;
	output reg [5:0]opcode,funct;
	output reg [4:0]rs,rt,rd,shamt;
	output reg [15:0]const;
	output reg [25:0]address;
	//Control Unit
	output reg RegWrite,MemWrite,MemRead,RegDst,ALUSrc,PCSrc,Branch,Jump,MemtoReg;
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

	//Control Unit
	//R Type
	if(opcode == 6'b 000000) 
	begin
		MemWrite = 0;
		MemRead = 0;
		RegWrite = 1;
		RegDst = 1;
		ALUSrc = 0;
		Branch = 0;
		Jump = 0;
		MemtoReg = 0;
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
		Jump = 0;
		MemtoReg = 0;
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
		Jump = 0;
		MemtoReg = 0;
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
		Jump = 0;
		MemtoReg = 1;
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
		Jump = 0;
		MemtoReg = 0;
		ALUOp = 2'b 00;
	end

	//			jump
	else if(opcode == 000010)
	begin 
		MemWrite = 0; //X
		MemRead = 0; //X
		RegWrite = 0; //X
		RegDst = 0; //X
		ALUSrc = 0; //X
		Branch = 0; //X
		Jump = 1;
		MemtoReg = 0; //X
		ALUOp = 2'b 00; //X
	end
	//		beq
	else if(opcode == 000100)
	begin 
		MemWrite = 0; //X
		MemRead = 0; //X
		RegWrite = 0; //X
		RegDst = 1;
		ALUSrc = 0;
		Branch = 1;
		Jump = 0;
		MemtoReg = 0; //X
		ALUOp = 2'b 01;
	end

	else
	begin
	 $display ("Error: Incorrent Operand");
	end
end
	endmodule