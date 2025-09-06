`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module generate_if #(parameter n_bit = 8, parameter use_case = 1)(
                     input [n_bit - 1:0] a,
                     input [n_bit - 1: 0] b,
                     output [n_bit - 1: 0] out
					);

generate
    if(use_case == 1) begin // module AND
        and1 #(n_bit) dut(
            .a(a),
            .b(b),
            .out(out)
          );
      end
    else if(use_case == 2) begin // module OR
           or1 #(n_bit) dut(
               .a(a),
               .b(b),
               .out(out)
               );
          end
    else if(use_case == 3) begin // module NOR
          nor1 #(n_bit) dut(
               .a(a),
               .b(b),
               .out(out)
              );
          end
     else begin
          not1 #(n_bit) dut( // module NOT
                .a(a),
                .out(out)
                );
           end
    endgenerate
endmodule


// 4 module con
module and1 #(parameter n_bit = 8)(
             input [n_bit - 1:0] a, 
             input [n_bit - 1: 0] b, 
             output [n_bit - 1: 0] out);
    assign out = a & b;
endmodule
 
 
module or1 #(parameter n_bit = 8)(
             input [n_bit - 1:0] a, 
             input [n_bit - 1: 0] b, 
             output [n_bit - 1: 0] out);
        assign out = a | b;
endmodule
 
module nor1 #(parameter n_bit = 8)(
             input [n_bit - 1:0] a, 
             input [n_bit - 1: 0] b, 
             output [n_bit - 1: 0] out);
        assign out = ~(a | b);
endmodule

module not1 #(parameter n_bit = 8)(
             input [n_bit - 1:0] a, 
             output [n_bit - 1: 0] out);
        assign out = ~ a;
endmodule


// TESTBENCH

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

module testbenchh(
    );
    
    reg [7:0] a;
    reg [7:0] b;
   wire [7:0] out1, out2, out3, out4;
    
	
	// tạo instance của các module
	// ghi đè các giá trị vào use_case ban đầu
    generate_if #(.use_case(1)) dut1(  // AND
     .a(a),
     .b(b),
     .out(out1)
    ); 
    
    generate_if #(.use_case(2)) dut2(// OR
          .a(a),
          .b(b),
          .out(out2)
        ); 
        
    generate_if #(.use_case(3)) dut3(// NOR
         .a(a),
         .b(b),
         .out(out3)
      ); 
    generate_if #(.use_case(4)) dut4(// NOT
         .a(a),
         .b(b),
         .out(out4)
      ); 
    
    
initial begin
   $monitor("At time: %0t | a = %b | b = %b | AND = %b | OR = %b | NOR = %b | NOT = %b", $time, a, b, out1, out2, out3, out4);
       
                a = 8'b00001111;
                b = 8'b00000011;
                #40
                a = 8'b10101010;
                b = 8'b01010101;           
                #40
                a = 8'b10100000;
                b = 8'b00000000;
                #40
                a = 8'b10000001;
                b = 8'b10101010;
                #40;
           
                a = 8'b10101111;
                b = 8'b01011111;
                #40
                a = 8'b00001110;
                b = 8'b11110000;
                #40;
            
                a = 8'b00000000;
                b = 8'b10100011;
                #40;
    end
endmodule
