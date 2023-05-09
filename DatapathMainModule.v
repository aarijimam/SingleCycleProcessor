

 module datapath(clk,reset);
 
	reg [31:0] ROM [15:0];
 	reg [31:0] RegisterFile [7:0];
    reg [31:0] DataMemory [7:0];
	input clk,reset;
	reg [3:0]index;
	reg [1:0]type;
	wire [5:0]opcode;
	wire [4:0]Dest,op1ad,op2ad,shamt;
	reg [31:0]a,b,memoryvalue,regdata,InstrReg;
	wire [15:0]const;
	wire [25:0]address;
	reg RegWrite,MemWrite,MemRead;
	wire [15:0] d,dataaddress;
	reg [3:0] ra;
initial
begin
	index=0;
end
	//Instruction Memory/ROM
initial
begin
	ROM[0] = 32'b 0000110100010000;
	ROM[1] = 16'b 0100110100010001;
	ROM[2] = 16'b 0000100100010111;
	ROM[3] = 16'b 0000110100011000;
	ROM[4] = 16'b 0000000000101001;
	ROM[5] = 16'b 0100110100010001;
	ROM[6] = 16'b 0000110100010000;
	ROM[7] = 16'b 0000100000001001;
	ROM[8] = 16'b 0001100101000000;
	ROM[9] = 16'b 0001100101000000;
	ROM[10] = 16'b 0001100101000000;
	ROM[11] = 16'b 0100000101001110;
	ROM[12] = 16'b 0001100101000000;
	ROM[13] = 16'b 1100000101000001;
	ROM[14] = 16'b 0000001110110111;
	ROM[15] = 16'b 0001100101000000;
end

//Register Files
initial
begin
  RegisterFile[0] = 16'b 0000000000000000;
  RegisterFile[1] = 16'b 0000000000000000;
  RegisterFile[2] = 16'b 0000000000000010;
  RegisterFile[3] = 16'b 0000000000000001;
  RegisterFile[4] = 16'b 0000000000000000;
  RegisterFile[5] = 16'b 0000000000000001;
  RegisterFile[6] = 16'b 0000000000000001;
  RegisterFile[7] = 16'b 0000000000000001;
  //RegisterFile[8] = 16'b 0000000000000000;
end

initial
begin
  DataMemory[0] = 16'b 0000000000000000;
  DataMemory[1] = 16'b 0000000000000000;
  DataMemory[2] = 16'b 0000000000000111;
  DataMemory[3] = 16'b 0000000000011011;
  DataMemory[4] = 16'b 0000001111111111;
  DataMemory[5] = 16'b 0000000000000000;
  DataMemory[6] = 16'b 0000000000000001;
  DataMemory[7] = 16'b 0000000000000001;
  //DataMemory[8] = 16'b 0000000000000000;
end

  
  //determining instruction type + decoding
always@(posedge clk, negedge reset)
  begin
    if (reset==1)
		index=0;
    else
	InstrReg = ROM[index][15:0];
	end
	
	decoder y (InstrReg,opcode[3:0],op1ad[2:0],op2ad[2:0],Dest[2:0],shamt[2:0],const[5:0],address[8:0]);
always @ (posedge clk)
begin
	if (opcode == 4'b 0000 || opcode == 4'b 0001 || opcode == 4'b 0010 || opcode == 4'b 0011 || opcode == 4'b 0100) 
	  begin
		   a=RegisterFile[op1ad][15:0];
		   b=RegisterFile[op2ad][15:0];
		end
	  else if (opcode == 4'b 0101 || opcode == 4'b 0110 || opcode == 4'b 0111 || opcode == 4'b 1000 || opcode == 4'b 1110)
	  begin
		a=RegisterFile[op1ad][15:0];
		end
		else
		begin
		a=RegisterFile[op1ad][15:0];
		end
//Control
	 //Assigning Signals
	begin
	if (opcode == 4'b 0000 || opcode == 4'b 0001 || opcode == 4'b 0010 || opcode == 4'b 0011 || opcode == 4'b 0100 || opcode == 4'b 1010 || opcode == 4'b 1011 || opcode == 4'b 1100 || opcode == 4'b 1101 || opcode== 4'b 0101 || opcode== 4'b 0110 || opcode== 4'b 0111 )
		//R-Type, Addi, Load Word,Load Immediate : RegWeite= 1
		begin
		RegWrite=1;
		MemRead=0;
		MemWrite=0;
		end
	else
	RegWrite = 0;
	if (opcode == 4'b 0111)
	MemRead = 1;
	end
	begin
	if (opcode == 4'b 1000)
	  begin
	MemWrite = 1;
	RegWrite = 0;
	MemRead = 0;
	end
	else
	MemWrite=0;
	end
	
	begin
 if (RegWrite == 1 && MemRead == 1)
    begin
  memoryvalue = DataMemory[dataaddress];
  RegisterFile[Dest]=memoryvalue;
  end
  else if (RegWrite == 0 && MemRead == 0 && MemWrite == 1)
    begin
  regdata = RegisterFile[Dest];
  DataMemory[dataaddress]=regdata;
  end
  if (opcode != 4'b 1001 && opcode != 4'b 1110 && opcode != 4'b 1111)
	index = index + 1;
	//j
	if (opcode == 4'b 1001)
	begin
	index=index+address;
	end
	
end
	end
ALUez z (a,b,shamt,index,const,address,opcode,d[15:0],dataaddress[15:0]);
always @ (*)
begin
	if (RegWrite == 1 && MemWrite==0 && MemRead==0)
  RegisterFile[Dest]=d;
  
  //beq
	if (opcode == 4'b 1110)
	begin
	 regdata=RegisterFile[Dest];
	   if (a==regdata)
	     begin
	     index=const; //constant acts as address 
	      end
	
	end
	 //bne
	if (opcode == 4'b 1111)
	begin
	 regdata=RegisterFile[Dest];
	   if (a!=regdata)
	     begin
	     index=const; //constant acts as address 
	      end
	
	end
	end

 
endmodule 
  



