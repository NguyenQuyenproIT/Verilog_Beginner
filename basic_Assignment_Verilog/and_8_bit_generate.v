// MAIN CODE

module and8bit(
    input [7:0] a,
    input [7:0] b,
    output [7:0] seg_out
    );
    
    genvar i;
    generate
        for(i = 0; i<8; i = i + 1) begin: block_and
            and8 andd(
                .a(a[i]),
                .b(b[i]),
                .seg_out(seg_out[i])
              );
        end
        endgenerate
endmodule

module and8(input a, input b, output seg_out );
    assign seg_out = a & b;
 endmodule
 
// TESTBENCH

module testbench_and8bit(
    );
    
    reg [7:0] a;
    reg [7:0] b;
    wire [7:0] seg_out;
    
    and8bit andd(
        .a(a),
        .b(b),
        .seg_out(seg_out)
      );
      
    initial begin
    $monitor("At time = %0t, a = %b, b = %b, seg_out = %b", $time, a, b , seg_out);
        a = 8'b00001001;
        b = 8'b10001000;
        #50
        a = 8'b10101010;
        b = 8'b01010101;
        #50
        a = 8'b11111111;
        b = 8'b10101010;
     end
     
endmodule
