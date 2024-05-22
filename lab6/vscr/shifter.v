module shifter(input clk, output reg [7:0]out);
reg [7:0]counter;
always@(posedge clk) begin
	if(out==8'b00000000) begin
		counter<=0;
		out<=1;
	end
	else begin 
		if (counter<8'b11111111)begin
			out[7] <= out[4]^out[3]^out[2]^out[0];
      			out[6] <= out[7];
      			out[5] <= out[6];
      			out[4] <= out[5];
      			out[3] <= out[4];
      			out[2] <= out[3];
      			out[1] <= out[2];
      			out[0] <= out[1];
			counter<=counter+1;
		end
		else begin
			counter<=0;
		end
	end
end
endmodule		
