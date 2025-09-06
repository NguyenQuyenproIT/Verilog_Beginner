module top_module (
    input clk,
    input w, R, E, L,
    output reg Q
);

	wire in1, in2; // gồm bộ mux đầu tiên và các bộ mux tiếp theo(2)
	
	assign in1 = L ? R : w;
	assign in2 = E ? w : Q;
	
	always @(posedge clk) begin
		Q <= in2;
	end
endmodule

/*
MUX1 chọn giữa R và w, điều khiển bởi L.

MUX2 chọn giữa kết quả từ MUX1 và Q cũ, điều khiển bởi E.

Kết quả cuối cùng được chốt vào Q tại cạnh lên của clk.

*/
