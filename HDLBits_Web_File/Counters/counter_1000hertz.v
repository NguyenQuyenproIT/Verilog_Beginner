module top_module (
    input clk,
    input reset,
    output OneHertz,
    output [2:0] c_enable
); //

	wire [3:0] Q0, Q1, Q2;
	
	assign c_enable[0] = 1'b1;
	assign c_enable[1] = (Q0 == 4'd9);
	assign c_enable[2] =  (Q0 == 4'd9) && (Q1 == 4'd9);
	
	assign OneHertz = (Q0 == 4'd9) && (Q1 == 4'd9) && (Q2 == 4'd9);


    // tạo 3 bộ chia tần từ 1000Hz xuống còn 1 Hz
	bcdcount dut1(
		.clk(clk),
		.reset(reset),
		.enable(c_enable[0]),
		.Q(Q0)	
	);
	
	bcdcount dut2(
		.clk(clk),
		.reset(reset),
		.enable(c_enable[1]),
		.Q(Q1)	
	);
	
	bcdcount dut3(
		.clk(clk),
		.reset(reset),
		.enable(c_enable[2]),
		.Q(Q2)	
	);
	

endmodule
