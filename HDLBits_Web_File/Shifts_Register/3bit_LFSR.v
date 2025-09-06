		
		
		
		module top_module (
			input [2:0] SW,      // R
			input [1:0] KEY,     // L and clk
			output [2:0] LEDR);  // Q

		reg Q0, Q1, Q2;	
			
			always @(posedge KEY[0]) begin
				if(KEY[1]) begin
					 Q0 <= SW[0];
					 Q1 <= SW[1] ;
					 Q2 <= SW[2];
				end
			else begin
				Q0 <= Q2;
				Q1 <= Q0;
				Q2 <= Q1 ^ Q2;

		end		
				end

		assign LEDR = {Q2, Q1, Q0};


		endmodule
