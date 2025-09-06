	//	Create a 100-bit binary ripple-carry adder by instantiating 100 full adders. 
	//	The adder adds two 100-bit numbers and a carry-in to produce a 100-bit sum and carry out. 
	//	To encourage you to actually instantiate full adders, also output the carry-out from each full adder in the ripple-carry adder. 
	//	cout[99] is the final carry-out from the last full adder, and is the carry-out you usually see.
	
	
// cout lưu lại toàn bộ bit nhớ (carry-bit)	
	
// trong top_module, khởi tạo 100 lần module full_adder này, không dùng vòng lặp
	

module top_module( 
    input [99:0] a, b,
    input cin,
    output [99:0] cout,
    output [99:0] sum );

    wire [100:0] carry; // l01 bit, nhưng có 1 bit là bit khởi tạo
						// carry[i] là đầu vào carry-in cho FA thứ i nên đủ 100 FA
    assign carry[0] = cin; // khởi tạo carry[0] đầu tiên là cin (cin là 1 bit, có thể là 0 or 1, nghĩa là bit nhớ đầu tiên)

    genvar i;
    generate // tạo ra 100 bản sao, thay vì viết 100 module
        for(i = 0; i < 100; i = i + 1) begin: adder_block
            full_adder fa(
                .a(a[i]),
                .b(b[i]),
                .cin(carry[i]), // bit nhớ đầu tiên để tính sum, ban đầu là carry[1]
                .sum(sum[i]), // thay các dữ liệu vào để tính sum
                .cout(carry[i+1]) // carry[i+1] từ FA thứ i sẽ là carry[i+1], tức là carry-in của FA i+1
								// kiểu như ở case i = 0 đầu thì ta có cout[1], đến case i = 1 thì cin sẽ là carry[1] 
            );
			//carry có 101 bit: 1 bit khởi đầu (cin) và 100 bit carry-out
            assign cout[i] = carry[i+1]; // lưu các bit nhớ, vì ban đầu khởi tạo carry là 101 bit nên phải để carry[i+1], nghĩa là carry[i+1] của FA thứ i
        end
    endgenerate

endmodule


	
	
// module full adder
// khởi tạo bộ cộng toàn phần, mỗi lần cộng 1 bit là gọi 1 lần bộ cộng này
	module adder(input a, input, input cin, 
				output sum, output cout );
				
			assign sum = a ^ b ^ cin;
			assign cout = a&b | a&cin | b&cin;
	endmodule 	