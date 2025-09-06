 /* 2. Viết module, testbench encode 4-2 - ngược lại decode.
 input [3: 0]q;
 output a,b
 */
 
 module decoder2_4(input [3:0] q,
			   output reg a, // vì lưu trong always
			   output reg b );
			   
		always @(*) begin
			case(q)
			4'b1000: {a, b} = 2'b00; 
			4'b0100: {a, b} = 2'b01;
			4'b0010: {a, b} = 2'b10;
			4'b0001: {a, b} = 2'b11;
			default: {a, b} = 2'b00;
		endcase
	end
endmodule	


module testbench_de(
		);
		
	reg [3:0] qq;
	wire aa; // do được gán từ module côn	
	wire bb;
	
	decode dut(
		.a(aa),
		.b(bb),
		.q(qq)
	);
	
	initial begin
	
	$monitor("At Time=%0t, qq=%b, a=%b, b=%b", $time, qq, aa, bb);
		qq = 4'b0100;
		#100
		qq = 4'b0001;
		#100
		qq = 4'b1000;
		#100
		qq = 4'b0010;
	end
endmodule