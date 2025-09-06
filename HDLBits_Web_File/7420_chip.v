//7420_chip

module top_module(input wire p1a, p1b, p1c, p1d,
				  input wire p2a, p2b, p2c, p2d,
				  output p1y, p2y );
		assign p1y = ~(p1a & p1b & p1c & p1d);
		assign p2y = ~(p2a & p2b & p2c & p2d );
		
endmodule