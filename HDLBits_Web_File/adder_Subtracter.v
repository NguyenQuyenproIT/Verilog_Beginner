

	module top_module(input [31:0] a, 
			input [31:0] b, 
			input sub, 
			output [31:0] sum);
			
			wire w1;
			
			add16 m1(
				.a(a[15:0]),
				.b(b[15:0]),
				.cin(sub),
				.cout(w1),
				.sum(sum[15:0])
			);
			wire [15:0] w2;
			assign w2 = b ^ sub;
			
			
			add16 m2(
				.a(a[31:16]),
				.w2(b[31:16],
				.cin(w1),
				.cout(),
				.sum(sum[31:15])
			);
			
endmodule