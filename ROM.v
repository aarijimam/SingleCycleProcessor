module ROM(index,InstrReg);

input [31:0]index;
output reg [31:0]InstrReg;


reg [31:0] ROM [15:0];


initial
begin
	ROM[0] = 32'b 00000000000000010001000000100000;//add r0 r1 r2
    ROM[1] = 32'b 00000000011001000010100000100010;//sub r3 r4 r5
    ROM[2] = 32'b 10001100110001000000000000000001;// lw r4,1(r6)   
    ROM[3] = 32'b 10101100110001000000000000000010;// sw r4,2(r6)
    ROM[4] = 32'b 00100000010001110000000000000000;// addi r7,r2,0
    ROM[5] = 32'b 00010000111000100000000000000001;// beq r7,r2,1
    ROM[6] = 32'b 00000000110001000000000000000000; //crap(getting skipped)
    ROM[7] = 32'b 00010000111000010000000000000101;//beq r7,r1,5
    ROM[8] = 32'b 00001000000000000000000000000000;// j 0
    ROM[9] = 32'b 00000100100001010000000000000000;
    ROM[10] = 32'b 00000100100001010000000000000000;
    ROM[11] = 32'b 00010000000001010000100110000000;
    ROM[12] = 32'b 00000100100001010000000000000000;
    ROM[13] = 32'b 00110000000001010000000001000000;
    ROM[14] = 32'b 00000000001001100011000111000000;
    ROM[15] = 32'b 00000100100001010000000000000000;
//                 funct  shamt  rd    rt    rs   opcode  
end

always @ (*)
begin
    InstrReg = ROM[index][31:0];
end

endmodule