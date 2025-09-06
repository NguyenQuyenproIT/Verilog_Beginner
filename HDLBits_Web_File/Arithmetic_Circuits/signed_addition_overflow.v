/*
Assume that you have two 8-bit 2's complement numbers, a[7:0] and b[7:0]. 
These numbers are added to produce s[7:0]. Also compute whether a (signed) overflow has occurred.
*/

module top_module (
    input [7:0] a,
    input [7:0] b,
    output [7:0] s,
    output overflow
); //
 
     assign s = a + b; // cộng 2 số 8 bit, s[7] là bit dấu của sum
     assign overflow = (~a[7] & ~b[7] & s[7]) | (a[7] & b[7] & ~s[7]);
						// logic: nếu 2 số âm thì ra +, mà 2 số dương thì ra -
	 

endmodule
