module top_module(
    input clk,
    input reset,
    input ena,
    output reg pm,
    output reg [7:0] hh,
    output reg [7:0] mm,
    output reg [7:0] ss
); 

    always @(posedge clk) begin
        if (reset) begin
            pm <= 0;         // AM
            hh <= 8'h12;     // 12:00:00 AM
            mm <= 8'h00;
            ss <= 8'h00;
        end
        else if (ena) begin
            // --- Tăng giây ---
            if (ss == 8'h59) begin
                ss <= 8'h00;

                // --- Tăng phút ---
                if (mm == 8'h59) begin
                    mm <= 8'h00;

                    // --- Tăng giờ ---
                    if (hh == 8'h11) begin
                        hh <= 8'h12;
                        pm <= ~pm;  // Chuyển AM <-> PM
                    end
                    else if (hh == 8'h12) begin
                        hh <= 8'h01;
                    end
                    else begin
                        // tăng BCD giờ
                        if (hh[3:0] == 4'h9)
                            hh <= {hh[7:4] + 4'h1, 4'h0};
                        else
                            hh <= hh + 8'h01;
                    end
                end
				
				
                else begin
                    // tăng BCD phút
                    if (mm[3:0] == 4'h9)
                        mm <= {mm[7:4] + 4'h1, 4'h0};
                    else
                        mm <= mm + 8'h01;
                end
            end
            else begin
                // tăng BCD giây
                if (ss[3:0] == 4'h9)
                    ss <= {ss[7:4] + 4'h1, 4'h0};
                else
                    ss <= ss + 8'h01;
            end
        end
    end
endmodule
