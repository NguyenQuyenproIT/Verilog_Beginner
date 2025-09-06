module top_module (
    input clk,
    input reset,      // Synchronous active-high reset
    output reg [3:0] q);
    
	assign 
	
    always @(posedge clk) begin
        if(clk) begin
        q <= q + 1;
        end
        if(reset) begin
            q <= 4'b0000;
        end
    end
    
    

endmodule
