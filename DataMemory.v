module DataMemory(address,write_data,MemRead,MemWrite,read_data);

input [31:0]address,write_data;
input MemRead,MemWrite;
output reg [31:0]read_data;

reg [31:0] DataMemory [7:0];


initial
begin
  DataMemory[0] = 32'b 0000000000000000;
  DataMemory[1] = 32'b 0000000000011100;
  DataMemory[2] = 32'b 0000000000000111;
  DataMemory[3] = 32'b 0000000000011011;
  DataMemory[4] = 32'b 0000001111111111;
  DataMemory[5] = 32'b 0000000000000000;
  DataMemory[6] = 32'b 0000000000000001;
  DataMemory[7] = 32'b 0000000000000001;
  //DataMemory[8] = 16'b 0000000000000000;
end


always @(*)
begin 
    if(MemRead)
        read_data = DataMemory[address];    
    if(MemWrite)
        DataMemory[address] = write_data;

end

endmodule