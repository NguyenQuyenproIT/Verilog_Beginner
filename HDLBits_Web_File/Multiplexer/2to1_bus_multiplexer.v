// Create a 100-bit wide, 2-to-1 multiplexer. When sel=0, choose a. When sel=1, choose b.

module top_module( 
    input [99:0] a, b,
    input sel,
    output [99:0] out );

    assign out = sel ? b : a; // gán toàn bộ vector
							  // sẽ tạo ra 100 multiplexers 2:1 (mỗi bit một cái)
    
endmodule

/*

Câu lệnh assign out = sel ? b : a; là cách viết rất gọn gàng và chính xác để chọn giữa hai vector 100 bit.

Vẫn hoạt động đúng trên toàn bộ các bit từ 0 đến 99.

Trình tổng hợp sẽ tự động hiểu và tạo 100 mạch chọn tương ứng.
*/