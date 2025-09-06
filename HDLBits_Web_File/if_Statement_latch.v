// synthesis verilog_input_version verilog_2001
module top_module (
    input      cpu_overheated,
    output reg shut_off_computer,
    input      arrived,
    input      gas_tank_empty,
    output reg keep_driving  ); //

    always @(*) begin
        shut_off_computer = 0; // gán khi máy tính chưa tắt
        if (cpu_overheated) // nếu cpu nóng
           shut_off_computer = 1; // thì tắt máy
    end

    always @(*) begin
        keep_driving = 0; // không tiếp tục chạy nữa (arrived = 1)
        if (~arrived) // nếu chưa tới nơi
           keep_driving = ~gas_tank_empty; // vẫn tiếp tục chạy, còn xăng
    end

endmodule
