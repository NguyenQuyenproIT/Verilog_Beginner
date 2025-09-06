// MAIN CODE

module demux4_16(
    input [3:0] sel,
    input in,
    output reg [15:0] out
    );
    
    always @(*) begin
        out = 16'b0;
           case(sel)
            4'd0: out[0] = in;
            4'd1: out[1] = in;
            4'd2: out[2] = in;
            4'd3: out[3] = in;
            4'd4: out[4] = in;
            4'd5: out[5] = in;
            4'd6: out[6] = in;
            4'd7: out[7] = in;
            4'd8: out[8] = in;
            4'd9: out[9] = in;
            4'd10: out[10] = in;
            4'd11: out[11] = in;
            4'd12: out[12] = in;
            4'd13: out[13] = in;
            4'd14: out[14] = in;
            4'd15: out[15] = in;
            default: out = 16'b0;   
 
        endcase
       
     //  out[sel] <= in; 
  end
endmodule

//TESTBENCH

module testbench_demux4_16(
    );
  reg [3:0] sel;
  reg in;
  wire [15:0] out;
  
  demux4_16 dut(
        .sel(sel),
        .in(in),
        .out(out)  
  );
  
  initial begin
            in = 1;
         $monitor("At time = %0t, sel = %b, in = %b, out = %b", $time, sel, in, out);  
         for(sel = 0; sel < 16; sel = sel + 1) begin
            #10;
       end
    end
endmodule