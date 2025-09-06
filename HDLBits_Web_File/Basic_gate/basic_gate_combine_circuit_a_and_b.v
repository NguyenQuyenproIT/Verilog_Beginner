
module top_module(input x, input y, output z );

wire z1, z2, z3, z4; // làm đầu ra cho các trigger
wire or1, and1; // khởi tạo cho các gates


// làm phải dựa vào đề và hình ảnh
	moduleA a1(
			.x(x),
			.y(y),
			.z(z1)
		);
	moduleB b1(
		.x(x),
			.y(y),
			.z(z2)
		);
	moduleA a2(
			.x(x),
			.y(y),
			.z(z3)
		);
	moduleB b2(
		.x(x),
			.y(y),
			.z(z4)
		);
	assign or1 = z1 | z2;
	assign and1 = z3 & z4;
	assign z = or1 ^ and1;

endmodule

// viết chức năng cho từng module

module moduleA(input x, input y, output z); // Đây là chức năng logic cụ thể mà moduleA thực hiện.	
	assign z = (x ^ y) & x;
endmodule

module moduleB(input x, input y, output z); // Đây là chức năng logic cụ thể mà moduleB thực hiện.	
	assign z = ~(x ^ y); 
endmodule

