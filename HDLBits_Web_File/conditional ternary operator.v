// tìm số nhỏ nhất giữa 4 số dùng toán tử 3 ngôi

		module top_module(
			input [7:0] a, b, c, d,
			output [7:0] min );
			
		wire [7:0] min1, min2;
		
		assign min1 = (a < b) ? a : b; // nếu giá trị nào nhỏ hơn thì gán vào min1 => tách được 2 giá trị
		assign min2 = (c < d) ? c : d; // nếu giá trị nào nhổ hơn thì gán vào min2 =? tách được 2 giá trị
		assign min = (min1 < min2) ? min1 : min2; // lấy 2 giá trị vừa gán được rồi so sánh với nhau
	
endmodule