//MAIN CODE

module mux16_1(
    input [3:0] sel,
    input [15:0] in,
    output reg out // 1 bit
    );
    
    always @(*) begin
        case(sel) 
            4'd0: out = in[0];
            4'd1: out = in[1];
            4'd2: out = in[2];
            4'd3: out = in[3];
            4'd4: out = in[4];
            4'd5: out = in[5];
            4'd6: out = in[6];
            4'd7: out = in[7];
            4'd8: out = in[8];
            4'd9: out = in[9];
            4'd10: out = in[10];
            4'd11: out = in[11];
            4'd12: out = in[12];
            4'd13: out = in[13];
            4'd14: out = in[14];
            4'd15: out = in[15];
            default: out = 1'b0;
        endcase
     end           
    
endmodule

// TESTBENCH

module testbench_mux16_1(
    );
    
    reg [3:0] sel;
    reg [15:0] in;
    wire out;
    
    mux16_1 dut(
        .sel(sel),
        .in(in),
        .out(out)
      );
      
    initial begin
    $monitor("At time = %0t, sel = %b, in = %b, out = %b", $time, sel, in, out);
        in = 16'b1111_0101_0001_1000;
        for(sel = 0; sel < 16; sel = sel + 1) begin
            #20;
          end
      end
    
endmodule
