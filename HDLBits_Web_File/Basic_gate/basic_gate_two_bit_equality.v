
// case1:
// tóm tắt: trả về 1 nếu a == b

module top_module(input [1:0] A,
				  input [1:0] B,
				  output reg z );
		always @(*) begin
			case({A, B}) // a 2 bit và b 2 bit
				4'b0000: z = 1'b1;
				4'b0101: z = 1'b1;
				4'b1010: z = 1'b1;
				4'b1111: z = 1'b1;
				default: z = 1'b0;
			endcase
		end
	endmodule
	
// case 2:

module top_module(input [1:0] a,
				  input [1:0] b,
				  output z );
		assign z = (a == b);
		
endmodule