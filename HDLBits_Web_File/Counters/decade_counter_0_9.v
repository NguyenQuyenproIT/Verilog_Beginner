module top_module (
    input clk,
    input reset,        // Synchronous active-high reset
    output reg [3:0] q);

	always @(posedge clk) begin
		
		if(reset) begin
			q <= 4'd0;
			end
        else if(q == 4'd9) begin
		// phải đặt == 9 vì đã đếm được đến 9, nếu để == 10 thì bên dưới sẽ thực hiện câu lệnh else rồi mới kết thúc
			q <= 4'd0;
			end
		else begin
			q <= q + 1'b1;
			end
	end

endmodule
