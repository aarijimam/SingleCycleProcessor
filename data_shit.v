
    ROM[0] = 32'b 000000 00000 00001 00010 00000 100000;   //add r0 r1 r2
    ROM[1] = 32'b 000000 00011 00100 00101 00000 100010;  //sub r3 r4 r5
    ROM[2] = 32'b 100011 00110 00100 0000000000000001; // lw r4,1(r6)
    ROM[3] = 32'b 101011 00110 00100 0000000000000010;// sw r4,2(r6)
    ROM[4] = 32'b 001000 00010 00111 0000000000000000;// addi r7,r2,0
    ROM[5] = 32'b 000100 00111 00010 0000000000000001;// beq r7,r2,2
    ROM[6] = 32'b 000000 00110 00100 0000000000000000;
    ROM[7] = 32'b 000000 00111 00001 0000000000000101;//beq r7,r1,5
    ROM[8] = 32'b 000010 00000000000000000000000000;// j 0
    ROM[9] = 32'b 000001 00100 00101 00000 00000 000000;
    ROM[10] = 32'b 000001 00100 00101 00000 00000 000000;
    ROM[11] = 32'b 000100 00000 00101 00001 00110 000000;
    ROM[12] = 32'b 000001 00100 00101 00000 00000 000000;
    ROM[13] = 32'b 001100 00000 00101 00000 00001 000000;
    ROM[14] = 32'b 000000 00001 00110 00110 00111 000000;
    ROM[15] = 32'b 000001 00100 00101 00000 00000 000000;
//                 opcode  rs    rt    rs  shamt   funct
ROM[0] = 32'b 00000000000000010001000000100000;//add r0 r1 r2
ROM[1] = 32'b 00000000011001000010100000100010;//sub r3 r4 r5
ROM[2] = 32'b 10001100110001000000000000000001;// lw r4,1(r6)
ROM[3] = 32'b 10101100110001000000000000000010;// sw r4,2(r6)
ROM[4] = 32'b 00100000010001110000000000000000;// addi r7,r2,0
ROM[5] = 32'b 00010000111000100000000000000001;// beq r7,r2,1
ROM[6] = 32'b 00000000110001000000000000000000; //crap(getting skipped)
ROM[7] = 32'b 00000000111000010000000000000101;//beq r7,r1,5
ROM[8] = 32'b 00001000000000000000000000000000;// j 0