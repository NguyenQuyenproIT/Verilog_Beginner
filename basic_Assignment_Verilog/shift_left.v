// viết module, testbench bộ dịch trái 8 bit - chèn d_in vào bên phải

module shift_left(input clk, input rst, input d_in, output reg [7:0] d_out );
		
		
		always @(posedge clk or posedge rst) begin
			if(rst) begin
				d_out <= 8'b0;
				end
			else begin
				d_out <= {d_out[6:0], d_in};
		end
	end
endmodule


module testbench_sl(
			);
	reg clk;
	reg rst;
	reg d_in;
	wire [7:0] d_out;
	
	shift_left dut(
		.clk(clk),
		.rst(rst),
		.d_in(d_in),
		.d_out(d_out)
		);
		
	always #10 clk = ~clk;	
	
	initial begin
	
	$monitor("Time=%t clk=%b rst=%b d_in=%b d_out=%b", $time, clk, rst, d_in, d_out);
	
			clk = 0;
			
			rst = 1;
			#10
			rst = 0;
			d_in = 1;
			#10
			d_in = 0;
			#10
			d_in = 0;
			#10
			d_in = 1;
			#50
			$finish
	end
	
endmodule
		