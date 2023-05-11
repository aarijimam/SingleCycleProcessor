	
	module decoder (InstrReg,opcode,op1ad,op2ad,Dest,shamt,const,address);
	input [15:0]InstrReg;
	output reg [2:0]Dest,op1ad,op2ad,shamt;
	output reg [8:0]address;
	output reg [3:0]opcode;
	output reg [5:0]const;
always @ (*)
begin
	opcode = InstrReg[3:0];
   	if (opcode == 4'b 0000 || opcode == 4'b 0001 || opcode == 4'b 0010 || opcode == 4'b 0011 || opcode == 4'b 0100) 
	  begin
		//type = 1; //type 1 refers to R type
		Dest =  InstrReg[6:4];
		op1ad =  InstrReg[9:7];
		   // a=RegisterFile[op1ad][15:0];
		op2ad = InstrReg[12:10];
		   // b=RegisterFile[op2ad][15:0];
		shamt=InstrReg[15:13];
		end
	  else if (opcode == 4'b 0101 || opcode == 4'b 0110 || opcode == 4'b 0111 || opcode == 4'b 1000 || opcode == 4'b 1110 || opcode == 4'b 1111)
	  begin
		//type = 2; //type 2 refers to I type
		Dest =  InstrReg[6:4];
		op1ad =  InstrReg[9:7];
		   // a=RegisterFile[op1ad][15:0];
		const =  InstrReg[15:10];
		//ALU Block
		end
		
	else if (opcode ==  4'b 1001)
	  begin
  //type = 3; //type 3 refers to I type
		address = InstrReg[12:4];
		end
	else 
	  begin
	 $display ("Error:  Incorrent Operand");
	end
end
	endmodule