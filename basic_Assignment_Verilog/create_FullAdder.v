// thiết kế mạch FA bộ cộng có carry-in

module full_adder #(parameter n_bit = 8)(
				input [n_bit -1:0] a, b,
				input carry_in,
				output carry_out,
				output [n_bit-1:0] sum );
			
	wire [n_bit:0] carry;
	assign carry[0] = carry_in;
	
	genvar i;
	generate 
		for(i = 0; i< n_bit; i = i+1) begin: fa_block
			assign sum[i] = a[i] ^ b[i] ^ carry[i]; // trả về 1 nếu số bit 1 đầu vào là lẻ
			assign carry[i+1] = a[i]&carry[i] | b[i]&carry[i] | a[i]&b[i]; // bit nhớ cho vị trí kế tiếp, vì ban đầu i = 0, trả về 1 khi số bit 1 đầu vào >=2 
		end
	endgenerate
		assign carry_out = carry[n_bit]; // bit nhớ cuối cùng 
		
		
		
		
		assign {carry_out, sum} = a + b + carry-in;
endmodule
		