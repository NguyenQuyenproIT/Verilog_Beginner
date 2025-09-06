/* Thiết kế mạch LED đơn
Input: change
Output: led[7:0]

a.  8 LED đơn sáng di chuyển từ trái sang phải,
sau đó quay ngược về trái, và lặp lại liên tục.
Mỗi khi có tín hiệu change, di chuyển LED.


*/

// a:
	module top_module(
				input clk,  // xung nhịp clock
				input rst,	// tín hiệu reset
				input change,	// control signal, khi = 1 thì thay đổi vị trí LED
				output reg [7:0] led );
				
		reg direct; // nếu = 0 thì từ trái -> phải, = 1 thì phải -> trái
		
	always @(posedge clk or posedge rst) begin 		// làm song song, cập nhật trước 1 bước
			if(rst) begin
		led <= 8'b10000000; // start LED
		direct <= direct;
		
			if(change) begin
				if(direct == 0) begin // shift left
					led <= {1'b0, led[7:1]};
					if(led == 8'b00000010) direct = 1'b1;
								end
				else begin
					led <= {led[6:0]1'b0};
					if(led == 8'b01000000) direct = 1'b0;
					end	
			end
		end
endmodule
	
	
	
	
	
/*
b.  8 LED đơn sáng di chuyển từ 2 bên vào giữa,
và lặp lại liên tục.
Mỗi khi có tín hiệu change, di chuyển LED.
*/

module top_module(
	input clk,
	input rst,
	input change,
	output reg [7:0] led );
	
	always @(posedge clk or posedge rst) begin
			led <= 8'b10000001;
			if(change) begin
				led <= {{led[4], led[7:5]}, {led[2:0], led[3]}};
			end




			led <= {{led[4], led[7:5]}, {led[2:0], led[3]}};
    end
	/*
		if(rst == 1) // có reset
			led <= 8'b10000001; // reset về trạng thái led ban đầu
		else if(change == 1) // có tín hiệu liên quan đến thay đổi
			if(led == 8'b00011000) // nếu led đang ở vị trí cuối (giữa)
				led <= 8'b10000001;
			else // nếu vẫn chưa ở vị trí cuối thì dịch
				led <= (led >> 1 | led << 1); // Khi đến giữa (00011000), thì quay lại trạng thái ban đầu (10000001).
		else // nếu không có tín hiệu change
			led <= led



	*/	
endmodule
		
			