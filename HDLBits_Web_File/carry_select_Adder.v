
		module top_module(input [31:0] a, input [31:0] b, output [31:0] sum);
		
		wire w1;
		wire [31:16] sum2, sum3; // tạo 2 wire trung gian để gán cho module, tránh tranh chấp tín hiệu
			add16 m1(
				.a(a[15:0]),
				.b(b[15:0]),
				.cin(1'b0),
				.cout(w1),
				.sum(sum[15:0])
			);
			
			add16 m2(
				.a(a[31:16]),
				.b(b[31:16]),
				.cin(1'b0),
				.cout(),
				.sum(sum2) //
			);
			
			add16 m3(
				.a(a[31:16]),
				.b(b[31:16]),
				.cin(1'b1),
				.cout(),
				.sum(sum3) //
			);
			
			always @(*) begin
			case(w1)
				1'b0: sum[31:16] = sum2;
				1'b1: sum[31:16] = sum3;
			//	assign sum[31:16] = (w1 == 1'b0) ? sum2 : sum3;
			endcase
			end
	endmodule