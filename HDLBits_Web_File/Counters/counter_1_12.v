	module top_module (
		input clk,
		input reset,
		input enable,
		output [3:0] Q, // giá trị hiện tại của bộ đếm, Q chính là giá trị đếm hiện tại, ta giám sát để biết khi nào tới 12.
		output reg c_enable, // Đây là tín hiệu điều khiển enable cho module count4.
		output reg c_load,/*c_load
							Đây là tín hiệu nạp dữ liệu đồng bộ cho bộ đếm count4.
							Khi c_load = 1 ở cạnh lên của xung clock → bộ đếm bỏ qua giá trị đang đếm và nạp ngay giá trị từ c_d vào Q.
							Tức là nó giống như “ép” bộ đếm nhảy tới một giá trị khởi đầu mới.
							Trong bài này, mỗi khi reset hoặc khi Q = 12, c_load được kích để nạp lại 1, chuẩn bị cho vòng đếm tiếp theo..*/
		
		
		
		output reg [3:0] c_d /*Đây là giá trị sẽ được nạp vào Q khi c_load = 1.
								Ở bài này, ta luôn cho c_d = 4'd1 → nghĩa là:
								Khi reset → Q = 1 (bắt đầu đếm từ 1).
								Khi Q đang là 12 và ta muốn quay vòng → nạp Q = 1 lại.
								Nếu muốn bộ đếm bắt đầu từ giá trị khác, chỉ cần đổi c_d.
	 */
);
		count4 the_counter (
			.clk(clk),
			.enable(c_enable),
			.load(c_load),
			.d(c_d),
			.Q(Q) 
		);
		
		always @(*) begin
		/*Đây là giá trị mặc định (default assignment) cho các tín hiệu điều khiển bộ đếm.
			Nghĩa là nếu không rơi vào bất kỳ điều kiện if nào, bộ đếm sẽ:
			Chạy theo tín hiệu enable.
			Không bị nạp lại (c_load=0).
			Không quan tâm giá trị c_d (vì c_load=0).
		*/
			c_enable = enable; // điều khiển cho count4
			c_load = 1'b0; // khi chưa có reset hay Q == 12
			c_d = 4'd0; // khi chưa có giá trị nạp vào count4
			
			
			if(reset) begin	
				c_enable = 1'b0; // tạm ngưng đếm
				c_load = 1'b1;   // yêu cầu nạp lại giá trị mới
				c_d = 4'd1; // giá trị mới cần nạp là 1
				end
			else if(enable && Q == 4'd12) begin // Khi đang đếm (enable=1) và Q=12 → dừng đếm trong chu kỳ hiện tại và nạp ngay giá trị 1.
				c_load = 1'b1;
				c_d = 4'd1;
				c_enable = 1'b0; // tạm ngưng đếm ngay trong xung clock này
				end
		end
			
			
			

	endmodule
