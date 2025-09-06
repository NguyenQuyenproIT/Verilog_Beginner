/* Now that you know how to build a full adder, make 3 instances of it to create a 3-bit binary ripple-carry adder. 
The adder adds two 3-bit numbers and a carry-in to produce a 3-bit sum and carry out. 
To encourage you to actually instantiate full adders, also output the carry-out from each full adder in the ripple-carry adder. 
cout[2] is the final carry-out from the last full adder, and is the carry-out you usually see.
*/

module top_module( 
    input [2:0] a, b,
    input cin,
    output [2:0] cout,
    output [2:0] sum );

	wire [3:0] carry; // tạo 1 mảng carry để chứa các bit nhớ trung gian
	// 						carry[1], carry[2], carry[3] là output carry-out từ từng full adder.
	assign carry[0] = cin; // bit đầu tiên khởi tạo carry[0] = cin (tức là = 0), đầu vào được gán = cin
	
	genvar i;
	generate
		for(i = 0; i<3; i = i + 1) begin: block_Adder
			full_adder fa( // truyền các dữ liệu vào module để tạo 3 bộ full_adder
			/*
					Truyền a[i], b[i], carry[i] vào full adder thứ i.
					Full adder tính tổng → cho ra sum[i] và cout (bit nhớ ra).
					cout này được nối ra dây carry[i+1].
					Và carry[i+1] sẽ trở thành carry-in cho full adder kế tiếp (i+1)
			*/
			
			
			
			
			
			
				.a(a[i]),// a[i] truyền vào fa
				.b(b[i]), // b[i] truyền vào fa
				.cin(carry[i]), // cin truyền vào fa	
				.sum(sum[i]), // lấy ra sum[i] từ fa
				.cout(carry[i+1]) // lấy ra carry[i+1] từ fa
			);
			//cout là xuất ra các bit nhớ
			assign cout[i] = carry[i+1]; // gán lại các giá trị nhớ	
				// cin của quá trình tính toán trước sẽ là cout của lần sau	
				/*		carry-out từ full adder thứ i sẽ được lưu vào carry[i+1].
						Và đây chính là carry-in cho full adder kế tiếp.
				*/
				
				
				
		end
	endgenerate
			


endmodule

module full_adder (
    input a, b, cin,
    output sum, cout
);
    assign sum = a ^ b ^ cin;
    assign cout = (a & b) | (a & cin) | (b & cin);
endmodule