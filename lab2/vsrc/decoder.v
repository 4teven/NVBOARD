module decoder(input [7:0]in,input enable,output reg [2:0]out,output sign);

always @(*) begin
    if (enable) begin
        casez (in)
            8'b1???????: out = 3'b111;  // 优先级最高的输入是bit7
            8'b01??????: out = 3'b110;  // 优先级次之的输入是bit6
            8'b001?????: out = 3'b101;
            8'b0001????: out = 3'b100;
            8'b00001???: out = 3'b011;
            8'b000001??: out = 3'b010;
            8'b0000001?: out = 3'b001;
            8'b00000001: out = 3'b000;  // 优先级最低的输入是bit0
            default:     out = 3'bxxx;  // 如果输入全为0或存在多个高位，则输出未知
        endcase
    end else begin
        out = 3'b000;  // 如果使能信号为低，输出为0
    end
end
assign sign=in[7]|in[6]|in[5]|in[4]|in[3]|in[2]|in[1]|in[0];
endmodule
