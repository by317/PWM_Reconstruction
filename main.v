`timescale 1ns / 1ps
`define preset 10'd512
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:19:24 04/22/2012 
// Design Name: 
// Module Name:    main 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module counter_module (input clock, input reload, output reg overflow);

reg [9:0] count;

initial
begin
count = 10'd60;
overflow = 0;
end

always @ (posedge clock or posedge reload)
begin
if (reload) 
		begin
		count = 10'd60;
		overflow = 0;
		end
else if (count) count = count - 1;
else overflow = 1;
end
endmodule

module SR_FF (input S, input R, output reg Q);

always @ (posedge S or posedge R)
begin
	if (S) Q = 1;
	else Q = 0;
end
endmodule	

module main(
    input clk,
    input pwm,
    output myout,
	 output myout2
    );

wire Q1, Q2, Q3, X1, X2;

reg clock;
reg clock2;

always @ (posedge clk)
	clock = !clock;

always @ (posedge clock)
	clock2 = !clock2;

counter_module counterA(clock2, Q1, X1); 
counter_module counterB(clock2, Q2, X2); 

SR_FF SR_A(X1, pwm, Q1);
SR_FF SR_B(X2, !pwm, Q2);
SR_FF SR_O(X1, X2, Q3);

assign myout = Q3;
assign myout2 = Q3;
endmodule

