module top_module (
    input clk,
    input reset,
    input [31:0] in,
    output reg [31:0] out
);
	reg [31:0] pre;
	integer i;
	
	always @(posedge clk) begin
		for(i = 0; i<32; i = i + 1) begin
		if(reset) begin
			out[i] <= 1'b0;
		end
		else if(pre[i] & ~in[i]) begin
			out[i] <= 1'b1;
		end
		pre <= in;
	end
    end


endmodule
	