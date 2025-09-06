module top_module (
    input [3:0] x,
    input [3:0] y, 
    output [4:0] sum
);
    wire [4:0] carry;

    assign carry[0] = 1'b0; // Khởi tạo carry-in ban đầu

    genvar i;
    generate
        for (i = 0; i < 4; i = i + 1) begin: block_Adder
            full_adder fa(
                .a(x[i]),
                .b(y[i]),
                .cin(carry[i]),
                .sum(sum[i]),
                .cout(carry[i+1]) // cần wire carry có [4:0] nếu dùng như vậy
            );
        end
    endgenerate

    assign sum[4] = carry[4]; // Final carry-out // tại ban đầu carry bắt đầu từ i = 0

endmodule

module full_adder (
    input a, b, cin,
    output sum, cout
);
    assign sum = a ^ b ^ cin;
    assign cout = (a & b) | (a & cin) | (b & cin);
endmodule




//option2: 
module top_module (
	input [3:0] x,
	input [3:0] y,
	output [4:0] sum
);

	assign sum = x + y; // x+y là phép cộng 4-bit, kết quả là 5-bit (nếu bên trái đủ chỗ chứa)
endmodule