// MAIN CODE


// phụ thuộc vào trạng thái hiện tại và input đầu vào

module mearly_1001(
    input input_bit,
    input clk,
    output z
	output [1:0] state_out // dùng để quan sát trạng thái;
    );
  
localparam s0 = 2'b0;
localparam s1 = 2'b01;
localparam s2 = 2'b10;
localparam s3 = 2'b11;

reg [1:0] state = s0; // trạng thái ban đầu
assign state_out = state;
// đang ở s3 và input_bit nhận 1 thì thoả mãn
assign z = ((state == s3) & (input_bit == 1'b1)) ? 1'b1 : 1'b0;

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
            state <= (input_bit == 1'b1) ? s1 : s3;
            end
         default: state <= s0;
      endcase
     end

    
endmodule


// TESTBENCH

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

module tb_mearly_1001(
    );
    reg clk = 1'b0;
    reg input_bit;
	wire [1:0] state_out;
    wire z_mearly;
    
    mearly_1001 dut(
        .clk(clk),
        .input_bit(input_bit),
        .z(z_mearly)
		.state_out(state_out)
      );
      
      reg [15:0] i;
      
      always #5 clk = ~clk;
       always @(posedge clk) begin
            input_bit <= i[15];
            i <= {i[14:0], i[15]};
          end
       initial begin
         $monitor("At time = %0t, state = %b, input = %d, z = %d", $time, state_out, input_bit, z_mearly);
            i = 16'b1001000110011100;
            
         end  
endmodule
