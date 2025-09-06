
	module top_module(
			input a,
			input b,
			input sel_b1,
			input sel_b2,
			output wire out_assign,
			output reg out_always  );
			
		assign out_assign = (sel_b1 & sel_b2) ? b : a; // khi sel_b1 và sel_b2 đều = 1 thì có nghĩa là đúng thì chọn b, cả 2 đầu vào = 1 thì là TRUE
		// khi cả 2 đều đúng thì kết quả mới đúng
		always @(*) begin
			if(sel_b1 & sel_b2)
				out_always = b;
			else
				out_always = a;
			end
	endmodule