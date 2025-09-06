


		module top_module (
			input clk,
			input d,
			output q
			
		);
		
			reg q_neg, q_pos;
			always @(posedge clk) begin
				q_pos <= d;
				end
			always @(negedge clk) begin
				q_neg <= d;
				end
			always @(*) begin
				q = clk ? q_pos : q_neg;
				end

		endmodule
