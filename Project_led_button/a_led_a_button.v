/* module led_button(
    input  wire       clk,
    input  wire       rst_n,
    input  wire [3:0] button,
    output reg  [3:0] led_out
);

    reg [3:0] syn_but;

    // Đồng bộ tín hiệu nút bấm với clock
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            syn_but <= 4'b0000;
            led_out <= 4'b1111; // Mặc định tất cả LED sáng
        end else begin
            syn_but <= button;   // Đồng bộ nút
            led_out <= syn_but;  // Xuất ra LED
        end
    end

endmodule

*/


module led_button #(
    parameter DEBOUNCE_LIMIT = 20_000  // số chu kỳ clock cần để ổn định (~20ms nếu clk = 1MHz)
)(
    input  wire       clk,
    input  wire       rst_n,
    input  wire [3:0] button,
    output reg  [3:0] led_out
);

    reg [3:0] syn_but;        // đồng bộ tín hiệu nút
    reg [3:0] stable_but;     // lưu giá trị ổn định
    reg [19:0] counter[3:0];  // bộ đếm debounce cho từng nút

    integer i;

    // Đồng bộ nút bấm với clock
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            syn_but    <= 4'b0000;
            stable_but <= 4'b0000;
            led_out    <= 4'b1111; // led off
            for (i = 0; i < 4; i = i + 1)
                counter[i] <= 0;
        end else begin
            syn_but <= button;

            for (i = 0; i < 4; i = i + 1) begin
                if (syn_but[i] != stable_but[i]) begin
                    // Nếu giá trị thay đổi thì bắt đầu đếm
                    counter[i] <= counter[i] + 1;
                    if (counter[i] >= DEBOUNCE_LIMIT) begin
                        stable_but[i] <= syn_but[i];
                        counter[i] <= 0;
                    end
                end else begin
                    counter[i] <= 0; // reset bộ đếm nếu không thay đổi
                end
            end

            led_out <= stable_but; // xuất giá trị ổn định ra LED
        end
    end
endmodule