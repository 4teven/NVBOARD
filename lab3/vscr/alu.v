module alu(
input [3:0]A,B, 
input [2:0]aluop, 
output reg [3:0] out, 
output reg overflow,cout,zero
);
always @(*) begin
    zero = 0;    // 默认结果不为零
    carry = 0;   // 默认没有进位或借位
    overflow = 0; // 默认没有溢出

    case (aluop)
        3'b000: begin // 加法
            {cout, out} = A + B;  // 计算结果和进位/溢出
            overflow = (A[3] == B[3]) && (out[3] != A[3]); // 溢出发生在符号相同的数相加，但结果符号不同
        end
        3'b001: begin // 减法
            {cout, out} = A - B;  // carry这里实际上是借位，但在减法完成后变成进位
            overflow = (A[3] != B[3]) && (out[3] != A[3]); // 溢出发生在符号不同的数相减，但结果符号与A不同
        end
        3'b110: begin // 比较小于
            out =($signed(A) < $signed(B)) ? 4'b0001 : 4'b0000;
        end
        3'b111: begin // 比较等于
            out = ($signed(A) < $signed(B)) ? 4'b0001 : 4'b0000;
        end
        default: begin
            out = 4'bx; // 操作码无效时结果未知
            overflow = 1'bx; // 溢出状态未知
            cout = 1'bx; // 进位状态未知
        end
    endcase

    // 检查结果是否为零
    zero = (out == 4'b0000);
end

endmodule
