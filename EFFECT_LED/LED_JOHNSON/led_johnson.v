module johnson(
    input clk,
    input rst,
    output reg [7:0] led_j
    );
    
    reg [31:0] cnt;
    reg shift;

    always @(posedge clk) begin
        if(!rst) begin
            cnt <= 32'b0;
        end
       else begin
            cnt <= cnt + 1'b1;
            shift <= 1'b0;
            if(cnt >= 31'd13_499_999) begin
                    shift <= 1'b1;
                    cnt <= 1'b0;
                end
         end
    end

    always @(posedge clk) begin
        if(!rst) begin
           led_j <= 8'b11111111;
            end
        else begin
            if(shift) begin
                led_j <= {~led_j[0], led_j[7:1]};
            end
     end
    end

endmodule