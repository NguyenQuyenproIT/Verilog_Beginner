
add1 có 3 đầu vào là a, b, cin và 2 đầu ra là cout và sum
ở đây top_module dùng để tính tổng 32 bit, nhưng mà dựa vào 2 add16. Mà mỗi add16 lại dùng 16 add1 để tính tổng từng bit 1
ở đây ta dùng XOR

sum = a ^ b ^ cin // cin là bit nhớ từ số trước đó, sum = 1 khi có số lẻ bit 1
cout = (a&b) | (a&cin) | (b & cin) // cout = 1 khi có ít nhất 2 bit là 1, nghĩa là thoả mãn 1 trong 3 case kia
	phép and đúng ( = 1) khi cả 2 bằng 1
	chẳng hạn nếu a và b = 1 thì sum chắc chắn có cin (nhớ) = 1



module top_module (
    input [31:0] a,
    input [31:0] b,
    output [31:0] sum
);//
wire w1;
    add16 m1(
        .a(a[15:0]),
        .b(b[15:0]),
        .cin(1'b0),
        .cout(w1),
        .sum(sum[15:0])
    );
    
    add16 m2(
        .a(a[31:16]),
        .b(b[31:16]),
        .cin(w1),
        .cout(),
        .sum(sum[31:16])
    );
    
    
endmodule

// định nghĩa logic cho full adder 
module add1 ( input a, input b, input cin,   output sum, output cout );
	assign sum = a ^ b ^ cin;
    assign cout = (a&b) | (a&cin) | (b & cin);

endmodule
