module main (
    input  wire        clock,          // Clock chính (27 MHz trên Tang Nano 20K)
    input  wire        reset,          // Nút reset (mức thấp)
    output reg  [1:0]  selection_port, // Chân chọn LED hàng chục / hàng đơn vị
    output reg  [6:0]  sseg             // Chân LED a->g
);

    // ==========================
    // Tham số chia clock
    // ==========================
    parameter CLK_FREQ   = 27000000; // tần số clock board
    parameter SCAN_FREQ  = 2000;     // tần số quét LED (Hz)
    parameter COUNT_FREQ = 1;        // tần số đếm (1 Hz = mỗi giây tăng)

    // ==========================
    // Biến nội bộ
    // ==========================
    reg [3:0] chuc   = 0;
    reg [3:0] donvi  = 0;
    reg [3:0] so_gma = 0;
    reg       seg_active = 0;

    // Counter chia clock quét LED
    localparam integer SCAN_MAX = CLK_FREQ / (SCAN_FREQ * 2);
    reg [$clog2(SCAN_MAX)-1:0] scan_cnt = 0;

    // Counter chia clock đếm giờ
    localparam integer COUNT_MAX = CLK_FREQ / (COUNT_FREQ * 2);
    reg [$clog2(COUNT_MAX)-1:0] count_cnt = 0;
    reg tick_1Hz = 0; // xung tăng 1 chu kỳ clock khi đủ 1 giây

    // ==========================
    // Chia tần số quét LED
    // ==========================
    always @(posedge clock or negedge reset) begin
        if (!reset) begin
            scan_cnt   <= 0;
            seg_active <= 0;
        end else begin
            if (scan_cnt >= SCAN_MAX - 1) begin
                scan_cnt   <= 0;
                seg_active <= ~seg_active; // đổi giữa chục / đơn vị
            end else begin
                scan_cnt <= scan_cnt + 1;
            end
        end
    end

    // ==========================
    // Chia tần số đếm giờ (1 Hz)
    // ==========================
    always @(posedge clock or negedge reset) begin
        if (!reset) begin
            count_cnt <= 0;
            tick_1Hz  <= 0;
        end else begin
            if (count_cnt >= COUNT_MAX - 1) begin
                count_cnt <= 0;
                tick_1Hz  <= 1;
            end else begin
                count_cnt <= count_cnt + 1;
                tick_1Hz  <= 0;
            end
        end
    end

    // ==========================
    // Bộ đếm giờ 00 → 23
    // ==========================
    always @(posedge clock or negedge reset) begin
        if (!reset) begin
            chuc  <= 0;
            donvi <= 0;
        end else if (tick_1Hz) begin
            if (chuc == 2 && donvi == 3) begin
                chuc  <= 0;
                donvi <= 0;
            end else if (donvi == 9) begin
                donvi <= 0;
                chuc  <= chuc + 1;
            end else begin
                donvi <= donvi + 1;
            end
        end
    end

    // ==========================
    // Chọn LED nào sáng
    // ==========================
    always @(*) begin
        if (seg_active == 0) begin
            selection_port = 2'b10; // LED hàng chục
            so_gma         = chuc;
        end else begin
            selection_port = 2'b01; // LED hàng đơn vị
            so_gma         = donvi;
        end
    end

    // ==========================
    // Giải mã số sang 7-seg (Common Anode)
    // ==========================
    always @(*) begin
        case (so_gma)
            4'd0: sseg = 7'b1000000;
            4'd1: sseg = 7'b1111001;
            4'd2: sseg = 7'b0100100;
            4'd3: sseg = 7'b0110000;
            4'd4: sseg = 7'b0011001;
            4'd5: sseg = 7'b0010010;
            4'd6: sseg = 7'b0000010;
            4'd7: sseg = 7'b1111000;
            4'd8: sseg = 7'b0000000;
            4'd9: sseg = 7'b0010000;
            default: sseg = 7'b1111111; // tắt
        endcase
    end

endmodule
