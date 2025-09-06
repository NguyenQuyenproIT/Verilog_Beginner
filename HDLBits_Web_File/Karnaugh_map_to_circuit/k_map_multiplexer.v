// k_map_implemented with a multiplexer

module top_module (
    input c,
    input d,
    output [3:0] mux_in
); 
    
    always @(*) begin
			 mux_in[0] = (~d&c | c | d);
			 mux_in[1] = 1'b0;
			 mux_in[2] = ~d & c;
			 mux_in[3] = d & c;
	end
endmodule
