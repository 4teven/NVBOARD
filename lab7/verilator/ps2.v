module ps2(clk,clrn,ps2_clk,ps2_data,data,nextdata_n,
                    ready,overflow);
    input clk,clrn,ps2_clk,ps2_data,nextdata_n;
    output [7:0] data;
    output reg ready;
    output reg overflow;     // fifo overflow
    // internal signal, for test
    reg [9:0] buffer;        // ps2_data bits
    reg [7:0] fifo[7:0];     // data fifo
    reg [2:0] w_ptr,r_ptr;   // fifo write and read pointers
    reg [3:0] count;  // count ps2_data bits
    // detect falling edge of ps2_clk
    reg [2:0] ps2_clk_sync;

    always @(posedge clk) begin
        ps2_clk_sync <=  {ps2_clk_sync[1:0],ps2_clk};
    end

    wire sampling = ps2_clk_sync[2] & ~ps2_clk_sync[1];//falling edge 

    always @(posedge clk or posedge clrn) begin
        if (clrn == 0) begin // reset
            count <= 0; 
            w_ptr <= 0; 
            r_ptr <= 0; 
            overflow <= 0;
            ready<= 0;
        end
        else begin
        //如果 ready 为高电平且 nextdata_n 为低电平，表示需要读取下一数据。此时更新读指针r_ptr，并检查 FIFO 是否为空
            if ( ready ) begin // read to output next data
                if(nextdata_n == 1'b0) //read next data
                begin
                    r_ptr <= r_ptr + 3'b1;
                    if(w_ptr==(r_ptr+1'b1)) //empty
                        ready <= 1'b0;
                end
            end
            if (sampling) begin//falling edge 
              if (count == 4'd10) begin // 11 bits has already read
                if ((buffer[0] == 0) &&  // start bit
                    (ps2_data)       &&  // stop bit
                    (^buffer[9:1])) begin      // odd  parity
                    fifo[w_ptr] <= buffer[8:1];  // kbd scan code ----data
                    w_ptr <= w_ptr+3'b1;
                    ready <= 1'b1;
                    overflow <= overflow | (r_ptr == (w_ptr + 3'b1));
                end
                count <= 0;     // for next data
              end else begin // during the process 
                buffer[count] <= ps2_data;  // store ps2_data
                count <= count + 3'b1;
              end
            end
        end
    end
    assign data = fifo[r_ptr]; //always set output data

endmodule
