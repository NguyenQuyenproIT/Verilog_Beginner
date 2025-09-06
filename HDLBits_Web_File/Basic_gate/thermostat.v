module top_module (
    input too_cold, // bật máy sưởi khi trời quá lạnh
    input too_hot,  // bật máy lạnh khi trời quá nóng
    input mode, // mode = 1 - sưởi / mode = 0 - làm mát
    input fan_on, // khi máy sưởi hoặc máy lạnh đang hoạt động -> bật quạt (fan) để luân chuyển không khí 
	
					// có thể yêu cầu bật quạt riêng (fan_on = 1), ngay cả khi máy sưởi và máy lạnh đều tắt
	 
    output heater,
    output aircon,
    output fan
); 

	assign heater = mode & too_cold;
	assign aircon = ~mode & too_hot;
    assign fan = (heater | aircon) | fan_on;


endmodule
