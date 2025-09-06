
module fifo_async
    #(
       parameter reg[7:0] WIDTH = 64,
       parameter reg[15:0] DEPT = 256,
       parameter ALENGTH = 8
    )
    (
    input wire wr_clk,
    input wire wr_en,
    input wire [WIDTH - 1:0] wr_data,
    output reg fifo_full,
    input wire rd_clk,
    input wire rd_en,
    output wire [WIDTH - 1:0] rd_data,
    output reg fifo_empty,
    output wire fifo_wr_valid,
    output wire fifo_rd_valid
    );
    
    reg [WIDTH - 1:0] buffer_ff [DEPT - 1:0];
    reg [ALENGTH:0] write_ptr_sync1, write_ptr_sync2, write_ptr_g;
    reg [ALENGTH:0] read_ptr_sync1, read_ptr_sync2, read_ptr_g;
    reg [ALENGTH:0]read_ptr;
    reg [ALENGTH:0]write_ptr;
    reg [1:0] counter_wr_valid;
    reg [1:0] counter_rd_valid;
	
    initial begin
        write_ptr <= 0;
        read_ptr <= 0;
        counter_wr_valid <= 0;
        counter_rd_valid <= 0;
//        fifo_wr_valid <= 1;
    end  
	
    always @(posedge rd_clk) begin
        write_ptr_sync2 <= write_ptr_sync1;
        write_ptr_sync1 <= write_ptr_g;
        read_ptr_g <= read_ptr ^ read_ptr[ALENGTH:1];//convert binary to gray
        fifo_empty <= read_ptr_g == write_ptr_sync2;
        if(rd_en && !fifo_empty) begin
            read_ptr <= read_ptr + 1;
            counter_rd_valid <= 0;
        end   
        else if(counter_rd_valid <= 2'd1) counter_rd_valid <= counter_rd_valid + 1;
    end
	
    assign fifo_rd_valid = !rd_en & (counter_rd_valid > 2'd1);
    assign rd_data = buffer_ff[read_ptr[ALENGTH - 1:0]];
	
	
	
    always @(posedge wr_clk) begin
        read_ptr_sync2 <= read_ptr_sync1;
        read_ptr_sync1 <= read_ptr_g;
        write_ptr_g <= write_ptr ^ write_ptr[ALENGTH:1];//convert binary to gray
        fifo_full <= {~read_ptr_sync2[ALENGTH:ALENGTH-1], read_ptr_sync2[ALENGTH - 2:0]} == write_ptr_g;
        if(wr_en && !fifo_full) begin
            buffer_ff[write_ptr[ALENGTH - 1:0]] <= wr_data;
            write_ptr <= write_ptr + 1'b1;
            counter_wr_valid <= 0;
        end
        else if(counter_wr_valid <= 2'd1) counter_wr_valid <= counter_wr_valid + 1;
    end
	
    assign fifo_wr_valid = !wr_en & (counter_wr_valid > 2'd1);
	
endmodule
