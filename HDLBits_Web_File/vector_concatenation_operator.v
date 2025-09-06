// ghép các vector đầu vào và chia tách thành các vector đầu ra

module top_module (
    input [4:0] a, b, c, d, e, f,
    output [7:0] w, x, y, z );//
	
    wire [31:0] temp = {a, b, c, d, e, f, 2'b11};
    assign w[7:0] = temp[31:24];
    assign x[7:0] = temp[23:16];
    assign y[7:0] = temp[15:8];
    assign z[7:0] = temp[7:0];
   

endmodule
