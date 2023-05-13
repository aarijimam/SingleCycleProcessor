module ALU (ALUselect, ALUin1, ALUin2, ALUout);
	
    input		[3  : 0]	ALUselect;
    input		[15 : 0]	ALUin1, ALUin2;
    output	reg	[15 : 0]	ALUout;
    
    always@(*) 
    begin 
		if  (ALUselect == 0)
			ALUout = ALUin1 + ALUin2;
		  
		else if (ALUselect == 1) 
			ALUout = ALUin1 << ALUin2;
		  
		else if  (ALUselect == 2) 
			ALUout = ALUin1 >> ALUin2;
		  
		else if (ALUselect == 3)
			ALUout = ALUin1 | ALUin2;
		  
		else  if (ALUselect == 4)
			ALUout = ALUin1 & ALUin2;
			
		else if (ALUselect == 5 || ALUselect == 7 || ALUselect == 8) 
			ALUout = ALUin1 + ALUin2;
			
		else if (ALUselect == 6)
			ALUout = ALUin2;
			
		else
			ALUout = 0;
		  
    end
endmodule