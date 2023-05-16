module RegisterFile(clk,reset, rs,rt,write_reg,RegWrite,write_data,a,b);
input clk,reset;
input [4:0]rs,rt,write_reg;
input RegWrite;
input [31:0]write_data;
output [31:0]a,b;
reg [31:0] RegisterFile [7:0];

//Register Files
/*initial
begin
  RegisterFile[0] = 32'b 00000000000000000000000000000001;
  RegisterFile[1] = 32'b 00000000000000000000000000000010;
  RegisterFile[2] = 32'b 00000000000000000000000000000000;
  RegisterFile[3] = 32'b 00000000000000000000000000000101;
  RegisterFile[4] = 32'b 00000000000000000000000000000001;
  RegisterFile[5] = 32'b 00000000000000000000000000000001;
  RegisterFile[6] = 32'b 00000000000000000000000000000000;
  RegisterFile[7] = 32'b 00000000000000000000000000000001;
  //RegisterFile[8] = 16'b 0000000000000000;
end*/

assign a = RegisterFile[rs];
assign b = RegisterFile[rt];


always @ (posedge clk)
begin
if(reset == 1)
begin
  RegisterFile[0] = 32'b 00000000000000000000000000000001;
  RegisterFile[1] = 32'b 00000000000000000000000000000010;
  RegisterFile[2] = 32'b 00000000000000000000000000000000;
  RegisterFile[3] = 32'b 00000000000000000000000000000101;
  RegisterFile[4] = 32'b 00000000000000000000000000000001;
  RegisterFile[5] = 32'b 00000000000000000000000000000001;
  RegisterFile[6] = 32'b 00000000000000000000000000000000;
  RegisterFile[7] = 32'b 00000000000000000000000000000001;
end
else
begin
    if(RegWrite)
        RegisterFile[write_reg] = write_data;
    else
        RegisterFile[write_reg] = RegisterFile[write_reg];
end
end
endmodule
