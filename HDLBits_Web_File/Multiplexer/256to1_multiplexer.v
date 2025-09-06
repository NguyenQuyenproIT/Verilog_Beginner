/*	Create a 1-bit wide, 256-
	to-1 multiplexer. The 256 inputs are all packed into a single 256-bit input vector. 
	sel=0 should select in[0], sel=1 selects bits in[1], sel=2 selects bits in[2], etc.
*/

module top_module( 
    input [255:0] in,
    input [7:0] sel, // 8 bit để từ 0 - 255
    output out );
	// chọn một bit duy nhất từ in, tại vị trí chỉ định bởi sel
	//Verilog cho phép biến số trong chỉ mục, miễn là chỉ số nằm trong phạm vi hợp lệ
	assign out = in[sel]; // chọn chỉ số của in  từ sel (00000000 -> 11111111)

endmodule