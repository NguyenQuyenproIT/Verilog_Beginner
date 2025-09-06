// Gán default time

module traffic_light(
    input clk,
    output reg [7:0] timee,
    output reg [1:0] light, // chỉ cần 2 bit để biểu diễn trạng thái đèn
     );
     
     // state
     localparam green = 2'b00;
     localparam yellow = 2'b01;
     localparam red = 2'b10;
     
     // time counter
     localparam green_time = 8'd30; // 30s
     localparam yellow_time = 8'd3; // 3s
     localparam red_time = 8'd60;   // 60s
     
     reg [1:0] state = green; // first_state
     reg [7:0] timee = green_time; // first_time
     
     always @(posedge clk) begin
        if(timee == 0) begin // khi đếm xong thì transfer light
            case(state)
                green: begin
                    state <= yellow;
                    timee <= yellow_time;
                        end
                yellow: begin
                    state <= red;
                    timee <= red_time;
                        end
                red: begin
                    state <= green;
                    timee <= green_time;
                      end
                 endcase
          end
                 
               else begin
                    timee <= timee - 1;
                    end
                    
             light <= state; // cập nhật đầu ra light bằng trạng thái hiện tại để điều khiển hiển thị đèn.
         end    
endmodule


// TESTBENCH

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////


module tb_traffic_light(
    );
    reg clk = 1'b0;
    wire [7:0] timee;
    wire [1:0] light;
    
    traffic_light dut(
        .clk(clk),
        .timee(timee),
        .light(light)
        );
    always #5 clk = ~clk;
    
     always @(posedge clk) begin
        if (timee == 0) begin 
            case (light) // time_out // xét light
                2'b00: $display("green_light (%0d giây)", timee);
                2'b01: $display("yellow_light (%0d giây)", timee);
                2'b10: $display("red_light  (%0d giây)", timee);
                default: $display("error_light");
            endcase
        end else begin // printf light and time
            $display("At time = %0t: light = %b | time left = %0d", $time, light, timee);
        end
    end
endmodule





// Có thể thay đổi thời gian tuỳ ý trong TESTBENCH


`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

module traffic_light(
    input clk,
    output reg [7:0] timee,
    output wire [1:0] light, // ch? c?n 2 bit ?? bi?u di?n tr?ng thái ?èn
    input [7:0] green_time,
    input [7:0] yellow_time,
    input [7:0] red_time
     );
     
     // state
     localparam green = 2'b00;
     localparam yellow = 2'b01;
     localparam red = 2'b10;
   
     reg [1:0] state = green;
     assign light = state;
	 
	 
     always @(posedge clk) begin
    if (timee === 8'bx) begin // Khởi tạo ban đầu khi timee chưa được xác định
        timee <= green_time;  
        state <= green;
		
	// chuyển trạng thái 
    end else if (timee == 0) begin
        case(state)
            green: begin
                state <= yellow;
                timee <= yellow_time;
            end
            yellow: begin
                state <= red;
                timee <= red_time;
            end
            red: begin
                state <= green;
                timee <= green_time;
            end
        endcase
    end else begin
        timee <= timee - 1;
    end

   // light <= state; // cập nhật trạng thái liên tục
end
endmodule

// TESTBENCH

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////


module tb_traffic_light(
    );
    reg clk;
    wire [7:0] timee;
    wire [1:0] light;
    reg [7:0] green_time;
    reg [7:0] yellow_time;
    reg [7:0] red_time;
    
    traffic_light dut(
        .clk(clk),
        .timee(timee),
        .green_time(green_time),
        .yellow_time(yellow_time),
        .red_time(red_time),
        .light(light)
        );
    always #5 clk = ~clk;
    
     always @(posedge clk) begin
        if (timee == 0) begin
            case (light) // time_out
                2'b00: $display("green_light (%0d time_out)", timee);
                2'b01: $display("yellow_light (%0d _time_out)", timee);
                2'b10: $display("red_light  (%0d time_out)", timee);
                default: $display("error_light");
            endcase
        end else begin
            $display("At time = %0t, light = %b, time left = %0d", $time, light, timee);
        end
    end
    
    initial begin
       clk = 1'b0;
       green_time = 8'd30;
       yellow_time = 8'd3;
       red_time = 8'd60;
       
       end
   
endmodule