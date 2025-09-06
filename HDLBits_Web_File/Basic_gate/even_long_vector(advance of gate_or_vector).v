module top_module( 
    input [99:0] in,
    output [98:0] out_both,
    output [99:1] out_any,
    output [99:0] out_different );
    
    genvar i, j;
    generate    
        for(i = 0; i<99; i = i + 1) begin: both_any
           assign out_both[i] = in[i] & in[i+1];
        end
        for(i = 1; i<100;i = i + 1) begin: any
               assign out_any[i] = in[i] | in[i-1];
        end
        for(j = 0; j < 99; j= j + 1) begin: diff
          assign  out_different[j] = in[j] ^ in[j+1];
            end
      
        assign out_different[99] = in[99] ^ in[0];
 endgenerate
endmodule
