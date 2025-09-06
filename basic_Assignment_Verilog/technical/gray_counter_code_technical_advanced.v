 // Gray Code Counter
 
 
 module gray_counter #(    parameter WIDTH = 4)(
    input  wire clk,
    input  wire rst_n,
    input  wire enable,   // xung cho phép đếm (phải cùng miền clk!)
    output reg [WIDTH-1:0] gray_count
	// gray_count tạo từ binary_count theo quy tắc Gray.
	
	
 );
 reg [WIDTH-1:0] binary_count; // bộ đếm nhị phân thực sự.
 always @(posedge clk or negedge rst_n) begin 
    if (!rst_n)
        binary_count <= {WIDTH{1'b0}};
    else if (enable)
        binary_count <= binary_count + 1;
 end
 always @(*) begin
    gray_count[WIDTH-1] = binary_count[WIDTH-1];
    for (int i = WIDTH-2; i >= 0; i--) begin
        gray_count[i] = binary_count[i+1] ^ binary_count[i];
    end
 end
 endmodule
