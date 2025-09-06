// MAIN CODE
// chỉ phụ thuộc vào trạng thái hiện tại


module moore_1001(
    input input_bit,
    input clk,
    output z,
	output [2:0] state_out // quan sát trạng thái hiện tại
    );
    
 localparam s0 = 3'b0;
 localparam s1 = 3'b001;
 localparam s2 = 3'b010;
 localparam s3 = 3'b011;
 localparam s4 = 3'b100;
 
 reg [2:0] state = s0; // trạng thái ban đầu
 assign state_out = state;
 
 assign z = (state == s4) ? 1'b1 : 1'b0;

 
 always @(posedge clk) begin
    case(state) 
        s0: begin
            state <= (input_bit == 1'b1) ? s1 : s0;
            end
        s1: begin
            state <= (input_bit == 1'b1) ? s1 : s2;
            end
        s2: begin
            state <= (input_bit == 1'b1) ? s1 : s3;
            end
        s3: begin 
            state <= (input_bit == 1'b1) ? s4: s3;
            end
        s4: begin
            state <= (input_bit == 1'b1) ? s1 : s2;
            end
     endcase
    end    
endmodule


// TESTBENCH

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

module testbench_moore_1001(
    );
    reg clk;
    reg input_bit;
    wire z_moore;
    wire [2:0] state_out;
    
    moore_1001 dut(
        .clk(clk),
        .input_bit(input_bit),
        .z(z_moore),
        .state_out(state_out)
    );
    reg [15:0] i;
    always #5 clk = ~clk;
    always @(posedge clk) begin
       input_bit <= i[15];
        i <= {i[14:0], i[15]}; 
       end
     initial begin
        $monitor("At time = %0t, state = %b, input = %d, z = %d", $time, state_out, input_bit, z_moore);
        i <= 16'b1000_1001_1001_1101;
        clk <= 1'b0;
        end
    
    
endmodule

	
