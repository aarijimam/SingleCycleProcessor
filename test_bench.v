`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   17:42:35 05/13/2023
// Design Name:   datapath
// Module Name:   /home/aarijimam/NUST Material/CSA/Assignment2/ASS2/Ass2/test_bench.v
// Project Name:  Ass2
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: datapath
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test_bench;

	// Inputs
	reg clk;
	reg reset;

	// Instantiate the Unit Under Test (UUT)
	datapath uut (
		.clk(clk), 
		.reset(reset)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 1;

		// Wait 100 ns for global reset to finish
		#1000;
		clk = 0;
		reset = 0;
        
		// Add stimulus here

	end
	always # 500
	clk = ~clk;
      
endmodule

