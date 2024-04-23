module top(input [7:0]data,input enable, output reg [2:0] ledout, output reg [7:0] segout,output sign);

wire [7:0] seg0,seg1,seg2,seg3,seg4,seg5,seg6,seg7;
decoder dut1(.in(data),.enable(enable),.out(ledout),.sign(sign));
seg dut2(.in(ledout),.o_seg0(seg0),.o_seg1(seg1),.o_seg2(seg2),.o_seg3(seg3),.o_seg4(seg4),.o_seg5(seg5),.o_seg6(seg6),.o_seg7(seg7));

always@(*) begin
	if(enable)begin
	case(ledout) 
		3'b111:segout=seg7;
		3'b110:segout=seg6;
		3'b101:segout=seg5;
		3'b100:segout=seg4;
		3'b011:segout=seg3;
		3'b010:segout=seg2;
		3'b001:segout=seg1;
		3'b000:segout=seg0;
		default:segout=8'b00000000;
	endcase
	end
	else
		segout=8'b00000000;
end

endmodule

