module seg(
  input [3:0]in,
  input clk,
  output reg [7:0] segout
);


always@(posedge clk)begin
	case(in)
		4'b1111:segout<=8'b01110000;
		4'b1110:segout<=8'b01100000;
		4'b1101:segout<=8'b10000100;
		4'b1100:segout<=8'b01100010;
		4'b1011:segout<=8'b11000000;
		4'b1010:segout<=8'b00010000;
		4'b1001:segout<=8'b00011000;
		4'b1000:segout<=8'b00000000;
		4'b0111:segout<=8'b00011110;
		4'b0110:segout<=8'b01000000;
		4'b0101:segout<=8'b01001000;
		4'b0100:segout<=8'b10011000;
		4'b0011:segout<=8'b00001100;
		4'b0010:segout<=8'b00100100;
		4'b0001:segout<=8'b10011110;
		4'b0000:segout<=8'b00000010;
		default:segout<=8'b00000000;
	endcase
end
endmodule
