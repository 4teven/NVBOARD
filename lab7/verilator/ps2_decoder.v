module ps2_decoder(
	input [7:0] data,
	input clk,
	output reg [7:0] ascout);
	always@(posedge clk)begin
		case(data)
			8'b00001110:ascout<=8'b01100000; // ` in ascii
			8'b00010110:ascout<=8'b00110001; // 1 in ascii
			8'b00011110:ascout<=8'b00110010; // 2 in ascii
			8'b00100110:ascout<=8'b00110011; // 3
			8'b00100101:ascout<=8'b00110100; //4
			8'b00101110:ascout<=8'b00110101; //5
			8'b00110110:ascout<=8'b00110110; //6
			8'b00111101:ascout<=8'b00110111; //7
			8'b00111110:ascout<=8'b00111000; //8
			8'b01000110:ascout<=8'b00111001; //9
			8'b01000101:ascout<=8'b00110000; //0
			8'b01001110:ascout<=8'b00101101; //-
			8'b01010101:ascout<=8'b00111101; //<=
			8'b01011101:ascout<=8'b01011100; // 5D 
			8'b01100110:ascout<=8'b00001000; // back
			8'b00001101:ascout<=8'b00001001; //tab
			8'b00010101:ascout<=8'b01110001; //q
			8'b00011101:ascout<=8'b01110111;	//w
			8'b00100100:ascout<=8'b01100101;	//e
			8'b00101101:ascout<=8'b01110010;	//r
			8'b00101100:ascout<=8'b01110100;	//t
			8'b00110101:ascout<=8'b01111001;	//y
			8'b00111100:ascout<=8'b01110101;	//u
			8'b01000011:ascout<=8'b01101001;	//i
			8'b01000100:ascout<=8'b01101111;	//o
			8'b01001101:ascout<=8'b01110000;	//p
			8'b01010100:ascout<=8'b01011011;	//[
			8'b01011011:ascout<=8'b01011101;	//]
			8'b01011000:ascout<=8'b00001111;	//CAPs
			8'b00011100:ascout<=8'b01100001;	//a
			8'b00011011:ascout<=8'b01110011;	//s
			8'b00100011:ascout<=8'b01100100;	//d
			8'b00101011:ascout<=8'b01100110;	//f
			8'b00110100:ascout<=8'b01100111;	//g
			8'b00110011:ascout<=8'b01101000;	//h
			8'b00111011:ascout<=8'b01101010;	//j
			8'b01000010:ascout<=8'b01101011;	//k
			8'b01001011:ascout<=8'b01101100;	//l
			8'b01001100:ascout<=8'b00111011;	//;
			8'b01010010:ascout<=8'b00100111;	//'
			8'b01011010:ascout<=8'b00001101;	//enter
			8'b00010010:ascout<=8'b00001111;	//shift
			8'b00011010:ascout<=8'b01111010;	//z
			8'b00100010:ascout<=8'b01111000;	//x
			8'b00100001:ascout<=8'b01100011;	//c
			8'b00101010:ascout<=8'b01110110;	//v
			8'b00110010:ascout<=8'b01100010;	//b
			8'b00110001:ascout<=8'b01101110;	//n
			8'b00111010:ascout<=8'b01101101;	//m
			8'b01000001:ascout<=8'b00101100;	//,
			8'b01001001:ascout<=8'b00101110;	//.
			8'b01001010:ascout<=8'b00101111;	// /
			8'b00010100:ascout<=8'b00010001;	//ctrl
			8'b00101001:ascout<=8'b00100000;	//space
			default:ascout<=8'bxxxxxxxx;
		endcase
	end
endmodule
