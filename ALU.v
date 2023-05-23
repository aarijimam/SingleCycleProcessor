	//ALU Block
	module ALU (clk, a,b,shamt,funct,ALUOp,out,zero);
	input clk;
	input  [31:0]a,b;
	input  [4:0]shamt;
	input [5:0]funct;
	input [1:0]ALUOp;
	output reg [31:0] out;
	output reg zero;

always @(posedge clk)
	begin
	if(ALUOp == 2'b 00)
	begin
		out = a+b;
	end
	else if(ALUOp == 2'b 01)
	begin
		out = a - b;
	end
	else
	begin 
		if(funct == 6'b 100000) //add
			out = a+b;
		else if(funct == 6'b 100010) //sub
			out = a-b;
		else if(funct == 6'b 011000) //mul
			out = a*b;
		else if(funct == 6'b 011010) //div
			out = a/b;
		else if(funct == 6'b 000000) //sll
			out = a<<shamt;
		else if(funct == 6'b 000010) //srl
			out = a>>shamt;
		else if(funct == 6'b 100101) //or
			out = a|b;
		else if(funct == 6'b 100100) //and
			out = a&b;
		else if(funct == 6'b 100111) //nor
			out = ~(a|b);
		else if(funct == 6'b 100110) //xor
			out = (a&~b) + (~a&b);
		else
		begin
	 	$display ("Error:  Incorrent funct");
		end
	end
	if(out == 0)
		zero = 1;
	else
		zero = 0;

		
	end
	  endmodule