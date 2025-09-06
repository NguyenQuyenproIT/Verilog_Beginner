	module top_module (
    input clk,
    input j,
    input k,
    output reg Q); 
    wire D;
    assign D = (j & ~Q) | (~k & Q); // Q hiện tại
    
    always @(posedge clk) begin
        Q <= D; // Q tiếp theo liên tục được gán khi có cạnh lên CLK
    end
    

endmodule
