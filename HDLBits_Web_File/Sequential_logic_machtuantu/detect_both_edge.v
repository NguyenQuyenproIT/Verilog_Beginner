module top_module (
    input clk,
    input [7:0] in,
    output reg [7:0] anyedge
);
    reg [7:0] pre;
    
    integer i;
    always @(posedge clk) begin
	/*always @(posedge clk) begin
		anyedge <= pre ^ in;
		pre <= in;
	end	
	*/
	
	
        for(i = 0; i<8; i = i + 1) begin
            anyedge[i] = (~pre[i] & in[i]) | (pre[i] & ~in[i]);
        end
        pre <= in;
    end
endmodule
