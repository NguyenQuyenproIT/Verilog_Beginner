// giải mã ưu tiên 
// xuất ra vị trí của bit 1 xuất hiện đầu tiên, ưu tiên từ LSB - MSB

	module top_module(
			input [3:0] in,
			output reg [1:0] pos );
			
		always @(*) begin
				if(in[0]) pos = 2'd0;
				else if(in[1]) pos = 2'd1;
				else if(in[2]) pos = 2'd2;
				else if(in[3]) pos = 2'd3;
				else pos = 2'd0;
		end
		
endmodule

//option2:

	module top_module(
		input [3:0] in,
		output reg [1:0] pos );
		
		always @(*) begin
			casez(in[3:0])
				4'b???1: pos = 2'd0;
				4'b??1?: pos = 2'd1;
				4'b?1??: pos = 2'd2;
				4'b1???: pos = 2'd3;
				default: pos = 2'd0;
			endcase
		end
	endmodule