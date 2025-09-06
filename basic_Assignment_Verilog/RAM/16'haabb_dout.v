`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////


module ram_value #(parameter DATA_WIDTH = 16, parameter MEM_SIZE = 256)(
    input clk,
    input we,
    input [15:0] din,
    output [15:0] dout
    );
  
(*RAM_STYLE = "block" *) reg [DATA_WIDTH - 1:0] mem [0 : MEM_SIZE - 1]; 
     
reg [$clog2(MEM_SIZE) - 1: 0] wr_addr = 0, rd_addr = 0, count = 0;
reg recev_done = 0;

 assign dout = mem[rd_addr];

always @(posedge clk) begin
    if(we && !recev_done) begin
        mem[wr_addr] <= din;
        wr_addr <= wr_addr + 1'b1;
        if(din == 16'haabb) begin
            count <= wr_addr + 1'b1;
            recev_done <= 1'b1;
            end
      end
     if(recev_done) begin
        if(rd_addr < count) begin
            // can put here (dout)
             rd_addr <= rd_addr + 1'b1;
             
           end
      end
   end 
endmodule


// TESTBENCH

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////


module tb_ram();
    reg clk = 1'b0;
    reg we = 1'b0;
    reg [15:0] din;
    wire [15:0] dout;
    
    ram_value dut(
        .clk(clk),
        .we(we),
        .din(din),
        .dout(dout)   
       ); 
     reg [15:0] in; 
    always #5 clk = ~clk;
    
    always @(posedge clk) begin
        in <= {in[14:0], in[15]};
        din <= in;
        end
  
    
    
    initial begin
         we = 1'b1;
         in = 16'hbaab;
          $monitor("At time = %0t, clk = %b, we = %b, din = %h, dout = %h", $time, clk, we, din, dout);
        /* din = 16'h1111; 
         #10
         din = 16'h2222; 
         #10
         din = 16'h3333; 
         #10
         din = 16'haabb; 
         #10;
         din = 16'hab04;
         #10
         din = 16'haaba;
         #10
         din = 16'haabb;
         #10;
         */
     end
endmodule
