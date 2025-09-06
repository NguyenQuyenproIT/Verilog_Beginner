

module encoder2_4(input a, input b, output reg [3:0] q );
	always @(*) begin
		case({a, b}) 
			2'b00: q = 4'b1000;
			2'b01: q = 4'b0100;
			2'b10: q = 4'b0010;
			2'b11: q = 4'b0001;
		endcase
	end
endmodule


module testbench_endc(
		);
		
	/* aa, bb là biến điều khiển bạn gán giá trị thủ công trong initial → phải là reg.
		qq là biến nhận giá trị đầu ra từ module → phải là wire.
	*/
		
	reg aa;
	reg bb;
	wire [3:0] qq;
	
	encoder2_4 dut( // nhất quán với tên module
		.a(aa),
		.b(bb),
		.q(qq)
		);
		
		
	initial begin
	$monitor("At time %0t: a=%b, b=%b, q=%b", $time, aa, bb, qq);
		aa = 1'b0;
		bb = 1'b0;
		#100
		aa = 1'b0;
		bb = 1'b1;
		#100
		aa = 1'b1;
		bb = 1'b0;
		#100
		aa = 1'b1;
		bb = 1'b1;
	end
	initial begin
	
end
	
endmodule

