 // Pulse Synchronizer 
 
 
		 module pulse_sync (
			input  wire clk_src, // Là clock miền nguồn (source clock domain), pulse_in sẽ xuất hiện và thay đổi theo miền clock này.
			input  wire clk_dst, // Là clock miền đích (destination clock domain), pulse_out sẽ được sinh ra theo miền clock này, sau khi đồng bộ từ pulse_in.
			input  wire rst_n,
			input  wire pulse_in, //Tín hiệu xung từ miền clk_src. 
			output wire pulse_out // Tín hiệu xung ở miền clk_dst, Là bản đồng bộ của pulse_in sang clock đích, Được trễ một vài chu kỳ clk_dst tùy cấu trúc đồng bộ
		 );
		 reg pulse_src_reg;
		 reg [2:0] sync_dst_reg;
		 
		 always @(posedge clk_src or negedge rst_n) begin // tín hiệu reset đang là sườn xuống
			if (!rst_n)
				pulse_src_reg <= 1'b0;
			else if (pulse_in) 
				pulse_src_reg <= ~pulse_src_reg; 
			/*
			Câu pulse_src_reg <= ~pulse_src_reg; trong mạch đồng bộ kiểu “toggle flip-flop” 
			có mục đích biến một xung đơn (pulse_in) thành một tín hiệu mức thay đổi qua lại (toggle signal) mỗi khi có xung đó.
			
			Khi ta truyền xung từ miền clock clk_src sang miền clock clk_dst, 
			nếu chỉ truyền trực tiếp xung 1 chu kỳ thì bên clk_dst có thể bỏ lỡ xung (vì hai clock không đồng bộ, có thể trễ hoặc lệch pha).

			Giải pháp: ta tạo một bit “toggle” (pulse_src_reg) mà mỗi khi nhận pulse_in thì đảo trạng thái 0 → 1 hoặc 1 → 0.
			Sau đó, ở miền clk_dst, ta đồng bộ bit này qua 2 hoặc 3 FF và 
			so sánh giá trị trước và sau để phát hiện sự thay đổi → từ đó tạo lại một xung ở miền đích (pulse_out).
			
			Mỗi lần đảo toggle = báo cho miền clk_dst rằng “một xung vừa xảy ra”.
			Nếu không đảo (toggle) mà chỉ gửi trực tiếp pulse_in thì rất dễ bị mất xung nếu xung đó quá ngắn so với chu kỳ clk_dst.
			*/
				
		 end
		 
		 
		 always @(posedge clk_dst or negedge rst_n) begin
			if (!rst_n)
				sync_dst_reg <= 3'b000; // reset
			else
				sync_dst_reg <= {sync_dst_reg[1:0], pulse_src_reg};// nếu có tín hiệu xung clk_dst
		 end
		 
		 assign pulse_out = sync_dst_reg[1] ^ sync_dst_reg[2];
		 
		 endmodule
