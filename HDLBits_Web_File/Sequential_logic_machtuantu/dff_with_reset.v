// Create 8 D flip-flops with active high synchronous reset. All DFFs should be triggered by the positive edge of clk.

module top_module (
    input clk,
    input reset,            // Synchronous reset
    input [7:0] d,
    output reg [7:0] q
);
	integer i;
	always @(posedge clk) begin
		for(i = 0; i< 8; i = i + 1) begin
	if(reset) begin
		q[i] <= 1'b0;
		end
		else begin
			q[i] <= d[i];
		end
	end
	end

endmodule


// option 2:

// Create 8 D flip-flops with active high synchronous reset. All DFFs should be triggered by the positive edge of clk.

module top_module (
    input clk,
    input reset,            // Synchronous reset
    input [7:0] d,
    output reg [7:0] q
);
	always @(posedge clk) begin
	if(reset) begin
        q <= 8'b0;
		end
		else begin
			q <= d;
		end
    end

endmodule

