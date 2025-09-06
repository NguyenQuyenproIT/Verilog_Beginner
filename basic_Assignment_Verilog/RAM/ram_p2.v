					// RAM part 2

					`timescale 1ns / 1ps
					//////////////////////////////////////////////////////////////////////////////////

					module ram_advanced #(parameter DATA_WIDTH = 8, parameter MEM_SIZE = 24)( // RAM đủ chứa max 24 words
						input clk,
						input [7:0] data_i, // input
						input recev_valid,
						input last_in, // last value
						output reg [7:0] data_o, // output
						output reg trans_valid,
						output reg last_out
						);
					  
					 (*RAM_STYLE = "block"*) reg [DATA_WIDTH - 1:0] mem [MEM_SIZE - 1:0];   
					  reg [4:0] wr_addr = 0, rd_addr = 0;
					  reg [4:0] last_addr;
					  
					  
					  
					always @(posedge clk) begin
						if (recev_valid) begin
							mem[wr_addr] <= data_i;
							wr_addr <= wr_addr + 1;
							if (last_in || wr_addr >= 5'd19) begin
							// chưa liên quan đến RAM
								mem[wr_addr + 1] <= 8'd1;
								mem[wr_addr + 2] <= 8'd2;
								mem[wr_addr + 3] <= 8'd3;
								mem[wr_addr + 4] <= 8'd4;
								data_o <= mem[rd_addr]; // đọc luôn phần tử đầu tiên // phần tử cuối của ghi
								last_addr <= wr_addr + 3'd4;
								rd_addr <= rd_addr + 1'b1;
								trans_valid <= 1; // start read
							end    
						end

						last_out <= 1'b0; // hạn chế latch
						if (trans_valid) begin
							data_o <= mem[rd_addr];
							rd_addr <= rd_addr + 1'b1;
								 if (rd_addr == last_addr) begin // nếu là phần tử cuối cùng
									last_out = 1'b1; // cờ báo hiệu
									end		   
								end 
						if(last_out) begin
							rd_addr <= rd_addr; // gán lại vị trí đã đọc xong, không cần tăng nữa
							trans_valid <= 1'b0; // đọc xong
						end
					end	
					endmodule




					`timescale 1ns / 1ps
					//////////////////////////////////////////////////////////////////////////////////

					module tb_ram_advanced();
						reg clk;
						reg last_in;
						reg recev_valid;
						reg [7:0] data_i;
						wire [7:0] data_o;
						wire last_out;
						wire trans_valid;
						
						ram_advanced dut(
							.clk(clk),
							.last_in(last_in),
							.recev_valid(recev_valid),
							.data_i(data_i),
							.data_o(data_o),
							.last_out(last_out),
							.trans_valid(trans_valid)    
						);

						always #5 clk = ~clk;
						
						initial begin
							$monitor("T=%0t | clk=%b last_in=%b last_out=%b recev=%b data_in=%0d data_out=%0d trans_valid=%b", 
									 $time, clk, last_in, last_out, recev_valid, data_i, data_o, trans_valid);

							clk = 1'b0;
							recev_valid = 1'b0;
							last_in = 1'b0;
						//    data_i = 0;

							// Gửi 3 mẫu dữ liệu
							recev_valid = 1;
							@(posedge clk); data_i = 8'd10;
							@(posedge clk); data_i = 8'd20;
							@(posedge clk); data_i = 8'd30; 
							last_in = 1;  // Đánh dấu kết thúc
							@(posedge clk); 
							last_in = 0; 
							recev_valid = 0;
							data_i = 1'b0;
							#200;
						end
					endmodule




reg [2:0] write_state = 0;

case (write_state) // clk bắt đầu trạng thái ghi 4 số 1 2 3 4
            0: begin
                mem[wr_addr] <= 8'd1;
                write_state <= 1;
            end
            1: begin
                mem[wr_addr + 1] <= 8'd2;
                write_state <= 2;
            end
            2: begin
                mem[wr_addr + 2] <= 8'd3;
                write_state <= 3;
            end
            3: begin
                mem[wr_addr + 3] <= 8'd4;
                write_state <= 4;
            end
            4: begin
                // Bắt đầu đọc sau khi ghi xong
                data_o <= mem[rd_addr];
                rd_addr <= rd_addr + 1'b1;
                last_addr <= wr_addr + 3'd4;
                trans_valid <= 1'b1;
                write_state <= 0; // Reset trạng thái