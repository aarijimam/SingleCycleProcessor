	//ALU Block
	module ALUez (a,b,shamt,index,const,address,opcode,out,dataaddress);
	input  [15:0]a,b;
	input  [2:0]shamt;
	input [3:0]index;
	input  [5:0]const;
	input [8:0]address;
	input [3:0]opcode;
	output reg [15:0] out;
	output reg [15:0] dataaddress;

always @(*)
	begin
	if (opcode == 4'b 0000)
	begin
	out = a + b;
	end
	else if (opcode == 4'b 1010)
	begin
	out = a - b;
	end
	else if (opcode == 4'b 1011)
	begin
	out = a * b;
	end
	else if (opcode == 4'b 0001)
	begin
	out = a << shamt;
	end
	else if (opcode == 4'b 0010)
	begin
	out = a >> shamt;
	end
	else if (opcode == 4'b 0011)
	begin
	out = a | b;
	end
	else if (opcode == 4'b 0100)
	begin
	out = a & b;
	end
	else if (opcode == 4'b 1100)
	begin
	out = ~a;
	end
	else if (opcode == 4'b 1101)
	begin
	out = a / b;
	end
	
	
	else if (opcode == 4'b 0101)
	begin
	out = a + const;
	end
	
	else if (opcode == 4'b 0110)
	begin
	out = const;
	end
	
	else if (opcode == 4'b 0111) //lw
	begin
	dataaddress=a+const;
	//memoryvalue = DataMemory[dataaddress];
	//out = memoryvalue;
	end
	
	//sw
	else if (opcode == 4'b 1000)
	begin
	dataaddress=a+const;
	//regdata=RegisterFile[Dest];
	//DataMemory[dataaddress]= regdata;
	end
	end
	  endmodule