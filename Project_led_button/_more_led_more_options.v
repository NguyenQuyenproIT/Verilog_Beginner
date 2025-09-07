// cau 2: more led more option

module but_led(
    input clk, 
    input rst,
    input [3:0] button,
    output reg [3:0] led
);
    
reg [31:0] cnt;
reg active;
reg blink;

reg blink_en;
reg shift_en;

// để phát hiện cạnh xuống
reg button2_last;
reg button3_last;

    always @(posedge clk) begin
        if(!rst) begin
            cnt    <= 0;
            blink  <= 0;
            active <= 0;
        end else begin
            active <= 0;
            cnt <= cnt + 1;
            if(cnt >= 13_499_999) begin // ~0.5s
                cnt    <= 0;
                active <= 1;
                blink  <= ~blink;
            end
        end
    end

    always @(posedge clk) begin
        if(!rst) begin
            blink_en     <= 0;
            shift_en     <= 0;
            button2_last <= 1; // ban dau chưa nhấn
            button3_last <= 1;
        end else begin
            if(button2_last == 1 && button[2] == 0) begin // khi nhấn thì đổi trạng thái on/offs
                blink_en <= ~blink_en;
            end
            button2_last <= button[2]; // gán trạng thái cũ

            if(button3_last == 1 && button[3] == 0) begin // on-off
                shift_en <= ~shift_en;
            end
            button3_last <= button[3]; // old state
        end
    end



    // Điều khiển LED
    always @(posedge clk) begin
        if(!rst) begin 
            led <= 4'b1111; // reset => led off
        end else begin
            if(button[0] == 0) begin // ON
                led <= 4'b0000;
             end
             else if(button[1] == 0) begin // OFF
                led <= 4'b1111;
                end
             else if(blink_en && active) begin // BLINK
                if(blink) begin
                    led <= 4'b0000;
                    end
                else begin      
                    led <= 4'b1111;
                   end
            end
            else if(shift_en && active) begin // SHIFT
                led <= {~led[0], led[3:1]};
            end
        end
    end

endmodule