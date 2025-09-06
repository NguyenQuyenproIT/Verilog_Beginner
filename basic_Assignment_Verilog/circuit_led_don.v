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
		
	always @(posedge clk or posedge rst) begin  //Đây là khối mạch tuần tự, thay đổi khi có cạnh lên của clk hoặc khi rst được kích hoạt.
												// posedge rst được dùng để xử lý reset bất đồng bộ.
			led <= rst ? 8'b1000000 : (change ? (direct ? {led[6:0], 1'b0} : {1'b0, led[6:0]} : led); // ghep bit
			
			/*		
								if(rst == 1) led = 8'b10000000
								else 
									if(change == 1){
											if(direct == 1){
												led <= led >> 1; // dịch phải
											else 
												led <= led << 1; // dịch trái
									else	
										led = led; // không có sự thay đổi
			
			*/
			
			
			
			
				//nếu rst = 1 thì bắt đầu tại vị trí 8'b1000000, còn nếu change = 1 thì xét led
			direct <= rst ? 0 : (change ? ((led == 8'b00000001) ? 1 : (led == 8'b10000000) ? 0 : direct) : direct);
			
			/*
			if (led == 8'b00000001)
					direct = 1;
			else if (led == 8'b10000000)
					direct = 0;
			else
					direct = direct; // giữ nguyên
			
			*/
			
			
			
			
			
				// nếu rst = 1 thì đặt direct = 0, hướng sẽ từ trái -> phải
				// còn nếu reset # 0 thì ta xét hướng, nếu change = 1 nghĩa là đang có sự dịch chuyển led
				// xét tiếp có đang ở vị trí cuối cùng bên phải hay bên trái để thực hiện quay đầu
				// nếu change == 1 và đang ở vị trí phải cùng thì gán direct = 1 để đổi chiều phải -> trái,
				// ngược lại nếu led đang ở vị trí trái cùng thì gán change = 0 để đổi chiều trái -> phải,
				// nếu change = 0 thì giữ nguyên hướng
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
     //   led <= rst ? 8'b10000001 : (change ? ((led == 8'b00011000) ? (8'b10000001) : (led >> 1 | led << 1)) : led);
        led <= rst ? 8'b10000001 : 
                                (change ? 
                                  (  (led == 8'b10000001) ? 8'b01000010 : 
                                     (led == 8'b01000010) ? 8'b00100100 :
                                     (led == 8'b00100100) ? 8'b00011000 :
                                     (led == 8'b00011000) ? 8'b10000001 :
                                             8'b10000001) : 
                                 led);
                                 
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
		
			