/* You are provided with a BCD (binary-coded decimal) one-digit adder named bcd_fadd that adds two BCD digits and carry-in, and produces a sum and carry-out.

module bcd_fadd (
    input [3:0] a,
    input [3:0] b,
    input     cin,
    output   cout,
    output [3:0] sum );
Instantiate 4 copies of bcd_fadd to create a 4-digit BCD ripple-carry adder. 
Your adder should add two 4-digit BCD numbers (packed into 16-bit vectors) and a carry-in to produce a 4-digit sum and carry out.
*/

module top_module ( 
    input [15:0] a, b,
    input cin,
    output cout,
    output [15:0] sum );
	
	wire [4:0] carry;
	assign carry[0] = cin;
	
	genvar i;
	generate
		for(i = 0; i<4; i = i+1) begin: block_Adder
			bcd_fadd fa(
				.a(a[i*4 +: 4]),
				.b(b[i*4 +: 4]),
				.cin(carry[i]),
				.sum(sum[i*4 +: 4]),
				.cout(carry[i+1])
			);
		end
	endgenerate
		assign cout = carry[4];


endmodule
