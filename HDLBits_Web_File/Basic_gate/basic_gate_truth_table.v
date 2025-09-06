//truth table


// same AND gate

module top_module(input x1, 
				 input x2, 
				 input x3,
				 output f );
		
		always @(*) begin
		case({x3, x2, x1})
			3'b010: f = 1'b1;
			3'b011: f = 1'b1;
			3'b101: f = 1'b1;
			3'b111: f = 1'b1;
			default: f = 1'b0;
		endcase
	end	
endmodule