`timescale 1ns / 1ps
module seven_seg(button,sseg_cathode,sseg_anode);
input wire [3:0]button;
output reg [6:0]sseg_cathode;
output wire [3:0]sseg_anode;

assign sseg_anode = 4'b 1110;

always @(button)
    case (button)
      4'h0: sseg_cathode = 7'b1000000;
      4'h1: sseg_cathode = 7'b1111001;
      4'h2: sseg_cathode = 7'b0100100;
      4'h3: sseg_cathode = 7'b0110000;
      4'h4: sseg_cathode = 7'b0011001;
      4'h5: sseg_cathode = 7'b0010010;
      4'h6: sseg_cathode = 7'b0000010;
      4'h7: sseg_cathode = 7'b1111000;
      4'h8: sseg_cathode = 7'b0000000;
      4'h9: sseg_cathode = 7'b0011000;
      default: sseg_cathode = 7'b1001001;
    endcase

endmodule

