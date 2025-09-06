module top_module (
    input clk,
    input slowena,
    input reset,
    output reg [3:0] q);

	always @(posedge clk) begin
		if(slowena) begin
			if(reset) begin
				q <= 4'd0;
			end
		else if(q == 4'd9) begin
				q <= 4'd0;
				end
			else 
				q <= q + 1'd1;
			end
	end
	end

endmodule
