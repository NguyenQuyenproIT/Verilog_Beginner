/* Viết module, testbench bộ đếm mod 60 cho 2 led 7 thanh
 input clk;
 input up_down_mode;
 output [3:0] chuc, donvi
 */
 
 module led7seg(input clk,
				input up_down_mode, // biến check
				output reg [3:0] chuc, donvi );
				
				reg [5:0] count; // cần 6 bit để có thể đạt được mod 60
				// mạch tuần tự thực hiện đếm lên và đếm xuống
				
				
// 2 khối đồng bộ và tuần tự thực hiện song song 				
				
/*
		count thay đổi theo xung clk, còn chuc và donvi thay đổi dựa vào count
		cứ mỗi 1 sườn lên của xung clk thì count sẽ thay đổi
*/				
				
			// count dùng để reset khi đạt 59	
				always @(posedge clk) begin // đồng bộ theo sườn lên của xung clock
					if(up_down_mode) begin // đếm lên
						if(count == 59) begin
							count <= 0;
						end
						else begin
							count <= count + 1;
					end
			end
		/*		else begin // đêm xuống 
					if(count == 0) begin
						count <= 59;
					end
					else begin
						count <= count - 1;
				end
		*/
			// xuất ra số hàng chục và hàng đơn vị
			// hoạt động mỗi khi count thay đổi
			always @(*) begin // tách hàng chục và đơn vị
				chuc <= count / 10;
				donvi <= count % 10;
			end
endmodule

module testbench_7seg(
		);
	reg clkk;
	reg up_down_modee;
	wire [3:0] chucc, donvii;
	
	led7seg dut(
		.clk(clkk),
		.up_down_mode(up_down_modee),
		.chuc(chucc),
		.donvi(donvii)
	);
	initial begin
	count = 0;
end
	
	// time for a T is 20ns
	always #10 clkk = ~clkk;
	initial begin
		clkk = 0;	
		$monitor("At time = %0t: clk = %b, up_down_mode = %b, chuc = %d, donvi = %d", $time, clkk, up_down_modee, chucc, donvii);
		up_down_modee = 1;
		#500
		up_down_modee = 1;
	end
endmodule