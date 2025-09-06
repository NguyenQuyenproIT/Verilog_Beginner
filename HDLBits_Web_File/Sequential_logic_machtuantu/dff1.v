module top_module (
    input clk,
    input d, 
    input ar,   // asynchronous reset
    output q);

	always @(negedge clk or ar) begin
		if(ar) begin
			q <= 1'b0;
		end
		else begin
			q <= d;
		end
	end
endmodule
