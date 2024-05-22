module top(
input clk,clrn,ps2_clk,ps2_data,
output reg [7:0] seg1,seg2,seg3,seg4,seg5,seg6,
output reg [1:0] ledout);

reg [7:0]data,ascout_reg;
reg overflow,ready,nextdata_n;
wire ready_p1,ready_p2;
reg ready_d1,ready_d2;
reg [7:0] key_value;
reg [7:0] key_count;
reg [2:0] key_current,key_next;
reg [7:0] data_d1;
reg [7:0] seg_data_0;
reg [7:0] seg_data_2;
//three different state for the key: pressed, loosen and before the key was loosen
parameter [2:0] key_press = 3'b100,key_loosen = 3'b010,key_loosen_previous = 3'b001;

always @(*) begin //value assign
    seg_data_0 = key_value;
    seg_data_2 = key_count;
end

ps2 key (.clk(clk),.clrn(clrn),.ps2_clk(ps2_clk),.ps2_data(ps2_data),.data(data),.nextdata_n(nextdata_n),.ready(ready),.overflow(overflow));

assign ready_p1 = ready & !ready_d1;  //a record of the ready signal's transition state -phase 1
assign ready_p2 = ready_d1 & !ready_d2;// phase 2

always @(posedge clk or posedge clrn) begin //two stage flip flop to store the ready signal
    if(clrn) begin 
        ready_d1 <= 1'd0;
        ready_d2 <= 1'b0;
    end
    else begin
        ready_d1 <= ready;
        ready_d2 <= ready_d1;
    end
end

always @(posedge clk or posedge clrn) begin
    if(clrn) begin
        data_d1 <= 8'b0;
        nextdata_n <= 1'b1;
    end
    else if(ready_p1) begin 
        nextdata_n <= 1'b0;
        data_d1 <= data;
    end
    else begin
        data_d1 <= 8'b0;
        nextdata_n <= 1'b1;
    end
end

always @(posedge clk or posedge clrn) begin //state transition
    if(clrn) key_current <= key_loosen;
    else key_current <= key_next;
end 


always @(negedge clk or posedge clrn) begin
    if(clrn) begin
        key_count <= 8'b0;
        key_value <= 8'b0;
        key_next <= key_loosen;
    end
    else if(ready_p2) begin
        case(key_current)
            key_loosen: begin
                if(data_d1 == key_value) begin // remain	
                    key_value <= key_value;
                    key_next <= key_current;
                    key_count <= key_count;
                end
                else begin // press
                    key_value <= data_d1;
                    key_next <= key_press;
                    key_count <= key_count;
                end
            end
            key_press: begin 
                if(data_d1 == 8'hf0) begin // key pressed
                    key_value <= key_value;
                    key_next <= key_loosen_previous;
                    key_count <= key_count + 1'b1;
                end
                else if(data_d1 == key_value) begin
                    key_value <= key_value;
                    key_next <= key_press;
                    key_count <= key_count;
                end
                else begin
                    key_value <= 8'h00;
                    key_next <= key_loosen;
                    key_count <= 8'b0;
                end
            end
            key_loosen_previous: begin
                if(data_d1 == key_value) begin
                    key_value <= 8'h00;
                    key_next <= key_loosen;
                    key_count <= key_count;
                end
                else begin 
                    key_value <= 8'b0;
                    key_next <= key_loosen;
                    key_count <= key_count;
                end
            end
            default: begin
                key_value <= 8'b0;
                key_next <= key_current;
                key_count <= key_count;
            end
        endcase
    end
    else begin
        key_count <= key_count;
        key_value <= key_value;
        case(key_current)
            key_loosen: key_next <= key_loosen;
            key_press: key_next <= key_press;
            key_loosen_previous: key_next <= key_loosen_previous;
            default: key_next <= key_loosen;
        endcase
    end
end
//makecode
seg d1 (.in(seg_data_0[3:0]),.clk(clk),.segout(seg1));
seg d2 (.in(seg_data_0[7:4]),.clk(clk),.segout(seg2));

ps2_decoder decoder (.data(key_value),.clk(clk),.ascout(ascout_reg));

//ASCII
seg d3 (.in(ascout_reg[3:0]),.clk(clk),.segout(seg3));
seg d4 (.in(ascout_reg[7:4]),.clk(clk),.segout(seg4));
//Counter
seg d5 (.in(seg_data_2[3:0]),.clk(clk),.segout(seg5));
seg d6 (.in(seg_data_2[7:4]),.clk(clk),.segout(seg6));

assign ledout={ready,overflow};

endmodule

