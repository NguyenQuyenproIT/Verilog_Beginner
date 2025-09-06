module top_module (
    input clk,
    input [7:0] in,
    output reg [7:0] pedge
);	
    reg [7:0] previous;
    
    
    integer i;
    always @(posedge clk) begin
        for(i = 0; i<8; i= i + 1) begin
            pedge[i] <= ~previous[i] & in[i];// kiểm tra vị trí trước đó và hiện tại có phải từ 0 -> 1 không
        end
		/*
		previous là bản sao lưu của in từ chu kỳ trước.
		pedge[i] = 1 nếu lần này in[i] = 1 và lần trước previous[i] = 0.
		Dòng previous <= in; không có nghĩa là “sau khi in đổi thì đem đi so sánh lại”,	
		mà là: ghi lại in hiện tại vào previous, để dùng cho lần sau.
		*/
		
		
		
        previous <= in; // cập nhật lại previous để xét cho lần sau
						//Lưu lại in của hiện tại, để vòng posedge clk tiếp theo dùng previous này so sánh với in mới.
    end
 
    
    
endmodule
