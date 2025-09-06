

module sw_ctrl_2_to_1#(parameter DATA_WIDTH = 16)
(
    input clk,
    input resetn,
	
    output [DATA_WIDTH - 1 : 0] m_axis_tdata,
    input m_axis_tready,
    output  [1 : 0] m_axis_tkeep,
    output  m_axis_tvalid,
    output  m_axis_tlast,
    
    input [DATA_WIDTH - 1 : 0] s_axis_tdata,
    output s_axis_tready,
    input [1 : 0] s_axis_tkeep,
    input s_axis_tvalid,
    input s_axis_tlast
    );

localparam SOP = 16'h0a0a;
localparam EOP = 16'h0b0b;

localparam STATE_SOP = 3'b0;
localparam STATE_ID = 3'd1;
localparam STATE_LEN = 3'd2;
localparam STATE_DATA = 3'd3;
localparam STATE_EOP = 3'd4;
localparam STATE_ERR = 3'd5;

reg [15:0] cnt=0, frame_id=0, frame_len=0, cnt_send=0;
reg [3:0] state_packet=0;
reg [15:0] mem [0:63];
reg send_data=0;
reg s_axis_tready_reg = 1;
 reg[DATA_WIDTH - 1 : 0] m_axis_tdata_reg = 0;
 reg [1 : 0] m_axis_tkeep_reg = 0;
 reg m_axis_tvalid_reg = 0;
 reg m_axis_tlast_reg = 0;
assign s_axis_tready = s_axis_tready_reg;
assign m_axis_tdata = m_axis_tdata_reg;
assign m_axis_tkeep = m_axis_tkeep_reg;
assign m_axis_tvalid = m_axis_tvalid_reg;
assign m_axis_tlast = m_axis_tlast_reg;
always @(posedge clk) begin
	//send_data <= 1'b0; 
	if(s_axis_tvalid && s_axis_tready) begin
		if(state_packet == STATE_SOP) begin
			if(s_axis_tdata == SOP) 
				state_packet <= STATE_ID;
			else state_packet <= STATE_ERR;
		end
		if(state_packet == STATE_ID) begin
			state_packet <= STATE_LEN;
			frame_id <= s_axis_tdata;
		end
		if(state_packet == STATE_LEN) begin
			state_packet <= STATE_DATA;
			frame_len <= s_axis_tdata;
			cnt <= 1'b0;
		end
		if(state_packet == STATE_DATA) begin
			cnt <= cnt + 1'b1;
			mem[cnt] <= s_axis_tdata;
			if(cnt >= frame_len - 1'b1) begin
				state_packet <= STATE_EOP;
			end
		end
		if(state_packet == STATE_EOP) begin
			if(s_axis_tdata != EOP || s_axis_tlast != 1'b1) begin
				state_packet <= STATE_ERR;
			end
			else send_data <= 1'b1;
		end
		if(state_packet == STATE_ERR) begin
			state_packet <= STATE_SOP;
		end
	end
	if(!m_axis_tvalid_reg && send_data) begin
		m_axis_tvalid_reg <= 1'b1;
		m_axis_tkeep_reg <= 2'b11;
		m_axis_tdata_reg <= mem[0];
		cnt_send <= cnt_send + 1'b1;
		send_data <= 1'b0;
	end
	if(m_axis_tvalid_reg && m_axis_tready) begin
		m_axis_tdata_reg <= mem[cnt_send];
		cnt_send <= cnt_send + 1'b1;
		if(cnt_send >= cnt - 1'b1) begin
			m_axis_tlast_reg <= 1'b1;
		end
		if(m_axis_tlast) begin
			m_axis_tvalid_reg <= 1'b0;
			m_axis_tlast_reg <= 1'b0;
		end
	end
end

endmodule



`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////


module tb(
    );
    reg clk, resetn;

    always #5 clk = ~clk;
    reg [15:0] s_axis_tdata;
    reg s_axis_tlast;
    reg [1:0]s_axis_tkeep;
    wire s_axis_tready;
    reg s_axis_tvalid;
    wire [15:0] m_axis_tdata;
    wire m_axis_tlast;
    wire [1:0]m_axis_tkeep;
    reg m_axis_tready = 1;
    wire m_axis_tvalid;
    sw_ctrl_2_to_1 uut(
        .clk(clk),
        .resetn(resetn),
        .m_axis_tdata(m_axis_tdata),
        .m_axis_tready(m_axis_tready),
        .m_axis_tkeep(m_axis_tkeep),
        .m_axis_tvalid(m_axis_tvalid),
        .m_axis_tlast(m_axis_tlast),
        .s_axis_tdata(s_axis_tdata),
        .s_axis_tready(s_axis_tready),
        .s_axis_tkeep(s_axis_tkeep),
        .s_axis_tvalid(s_axis_tvalid),
        .s_axis_tlast(s_axis_tlast)
    );
    reg [15:0] mem [0:31];
    reg [5:0]cnt;
    initial begin
       clk = 1'b0; 
       cnt = 1'b0;
       mem[0] = 16'h0a0a;
       mem[1] = 16'haabb;
       mem[2] = 16'h0005;
       mem[3] = 16'h0001;
       mem[4] = 16'h0002;
       mem[5] = 16'h0003;
       mem[6] = 16'h0004;
       mem[7] = 16'h0005;
       mem[8] = 16'h0b0b;
   end
     always @(posedge clk) begin
        cnt <= cnt + 1'b1;
        if(cnt <=7) begin
            s_axis_tlast <= 1'b0;
            s_axis_tvalid <= 1'b1;
            s_axis_tdata <= mem[cnt];
            s_axis_tkeep <= 2'b11;
        end
        if(cnt ==8) begin
            s_axis_tlast <= 1'b1;
            s_axis_tvalid <= 1'b1;
            s_axis_tdata <= mem[cnt];
            s_axis_tkeep <= 2'b11;
        end
        if(cnt >8) begin
            s_axis_tlast <= 1'b0;
            s_axis_tvalid <= 1'b0;
        end
    end
    
    
endmodule
