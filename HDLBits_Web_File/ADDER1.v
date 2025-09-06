		
		
		module top_module(input [31:0] a, input [31:0] b, output [31:0] sum);
			
			wire w1;
			
			add16 module1(
				.a(a[15:0]),
				.b(b[15:0]),
				.cin(1'b0),
				.cout(w1),
				.sum(sum[15:0])
			);
			
		add16 module2(
			.a(a[31:16]),
			.b(b[31:16]),
			.cin(w1),
			.cout(),
			.sum(sum[31:16])
		);
		
endmodule
			