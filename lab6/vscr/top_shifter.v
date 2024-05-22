module top(
input clk, 
output reg [7:0] seg1,seg2, 
output reg [7:0] ledout);


shifter dut1(.clk(clk),.out(ledout));
seg dut2(.in(ledout[3:0]),.clk(clk),.segout(seg1));
seg dut3(.in(ledout[7:4]),.clk(clk),.segout(seg2));
endmodule

