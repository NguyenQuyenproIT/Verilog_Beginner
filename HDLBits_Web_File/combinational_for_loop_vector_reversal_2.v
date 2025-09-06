
	//	Given a 100-bit input vector [99:0], reverse its bit ordering.

	//		Module Declaration
	//				module top_module( 
	//					input [99:0] in,
	//					output [99:0] out
	//					);
	
	module top_module(
				input [99:0] in,
				output reg [99:0] out
			);
			integer i;
		always @(*) begin
			
			for(i = 0; i <= 99; i = i + 1) begin
				out[i] = in[99-i];
			end
		end
	endmodule