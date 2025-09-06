// vending machine

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

module vending(
    input clk,
    input [1:0] input_xu, 
    output z1, // product
    output z2, // change
    output [2:0] state_out
    );
    
    localparam s0 = 3'b000;
    localparam s5 = 3'b001;
    localparam s10 = 3'b010;
    localparam s15 = 3'b011;
    localparam s20 = 3'b100;
  
    localparam xu_5 = 2'b01;
    localparam xu_10 = 2'b10;
    localparam xu_20 = 2'b11;
  
    reg [2:0] state = s0;
    assign state_out = state;
    // output product
    assign z1 = ((state == s20 && (input_xu == xu_5 || input_xu == xu_10 || input_xu == xu_20)) ||
              (state == s15 && (input_xu == xu_10 || input_xu == xu_20)) ||
              (state == s10 && input_xu == xu_20) ||
              (state == s5 && input_xu == xu_20)) ? 1'b1 : 1'b0;
     // output change       
    assign z2 = ((state == s20 && (input_xu == xu_10 || input_xu == xu_20)) ||
              (state == s15 && input_xu == xu_20) ||
              (state == s10 && input_xu == xu_20)) ? 1'b1 : 1'b0;
              
    always @(posedge clk) begin
        case(state)
         s0: begin
            state <= (input_xu == xu_5) ? s5 :
                     (input_xu == xu_10) ? s10 : 
                     (input_xu == xu_20) ? s20 : s0;
              end
          s5: begin
               state <= (input_xu == xu_5) ? s10 :
                        (input_xu == xu_10) ? s15 :
                        (input_xu == xu_20) ? s0 : s5;
               end
          s10: begin
               state <= (input_xu == xu_5) ? s15 :
                        (input_xu == xu_10) ? s20 :
                        (input_xu == xu_20) ? s0 : s10;
                end
          s15: begin
                state <= (input_xu == xu_5) ? s20 :
                         (input_xu == xu_10) ? s0 :
                         (input_xu == xu_20) ? s0 : s15;
                end
          s20: begin
                state <= (input_xu == xu_5) ? s0 :
                         (input_xu == xu_10) ? s0 :
                         (input_xu == xu_20) ? s0 : s20;
               end
              default: state <= state;
          endcase
     end         
              
    
    
endmodule






// TESTBENCH


`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

module tb_vending(
    );
    reg clk = 1'b0;
    reg [1:0] input_xu;
    wire [2:0] state_out;
    wire z1, z2;
     
    vending dut(
        .clk(clk),
        .input_xu(input_xu),
        .z1(z1),
        .z2(z2),
        .state_out(state_out)
    );   
    
    always #5 clk = ~clk;
    
	
	
	reg [1:0] mem_data [15:0];
	reg [3:0] ptr; 
	
	
	initial begin	// không nên tự tạo delay
		clk = 1'b0;
		mem_data[0]  = 2'b01;
		mem_data[1]  = 2'b01;
		mem_data[2]  = 2'b01;
		mem_data[3]  = 2'b01;
		mem_data[4]  = 2'b01;
		mem_data[5]  = 2'b01;
		mem_data[6]  = 2'b01;
		mem_data[7]  = 2'b01;
		mem_data[8]  = 2'b01;
		mem_data[9]  = 2'b01;
		mem_data[10]  = 2'b01;
		mem_data[11]  = 2'b01;
		mem_data[12]  = 2'b01;
		mem_data[13]  = 2'b01;
		mem_data[14]  = 2'b01;
		mem_data[15]  = 2'b01;
		input_xu = 1'b0;
		ptr = 1'b0;
		end
		
		always @(posedge clk) begin
			ptr <= ptr + 1'b1;
			input_xu <= mem_data[ptr];
		//	if(cnt > 100) enable <= 1'b1;
		end  
    
endmodule
