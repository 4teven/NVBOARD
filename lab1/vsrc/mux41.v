module mux41(input [1:0]x0,x1,x2,x3,
	input [1:0]y,
	output [1:0]f);
	assign f=(y==2'b11)?x3:(y==2'b10)?x2:(y==2'b01)?x1:(y==2'b00)?x0:2'b00;
endmodule
