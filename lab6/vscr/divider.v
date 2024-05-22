module divider(input clk, output reg clk_d);
reg [2:0]cnt_d;
always@(posedge clk) begin
	if(cnt_d == 'd7)
		cnt_d <= 3'b0;
        else
            cnt_d <= cnt_d + 1'b1;
end
always@(posedge clk)begin
   if(cnt_d < 3'd5)
            clk_d <= 1'b1;
        else
            clk_d <= 1'b0;
end
endmodule
