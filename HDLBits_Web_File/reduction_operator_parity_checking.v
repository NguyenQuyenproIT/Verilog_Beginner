 // reduction operator
 
 module top_module(
		input [7:0] in,
		output parity,
     output [8:0] outt
 );
		
		
	assign parity = ^in[7:0]; // xor để tìm ra là chẵn hay lẻ
							// kết quả là 0: số lượng bit 1 là chẵn -> parity = 0
							// kết quả là 1: số lượng bit 1 là lẻ -> parity = 1
     assign outt = {in, parity}; // gộp thành 9 bit
		
		
endmodule


// chỉ cần kiểm tra là chẵn hay lẻ
 module top_module (
    input [7:0] in,
    output parity
);

    assign parity = ^in;

endmodule