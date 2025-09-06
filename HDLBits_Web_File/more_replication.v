// cho 5 tín hiệu 1 bit (a, b, c, d, e);
// Hãy tính tất cả 25 phép so sánh cặp 1 bit và lưu kết quả vào vector đầu ra 25 bit


module top_module(input a, b, c, d, e, output [24:0] out);

// cách 1, so sánh từng bit
/* out[24] = ~a ^ a;   // a == a, so out[24] is always 1.
out[23] = ~a ^ b;
out[22] = ~a ^ c;
...
out[ 1] = ~e ^ d;
out[ 0] = ~e ^ e;
*/

// cách 2: replication + concatination

wire [24:0] tmp1 = {{5{a}}, {5{b}}, {5{c}}, {5{d}}, {5{e}}};
wire [24:0] tmp2 = {5{a, b, c, d, e}};

assign out = ~(tmp1 ^ tmp2);

endmodule