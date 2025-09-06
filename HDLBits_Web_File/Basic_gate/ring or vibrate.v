module top_module (
    input ring,
    input vibrate_mode,
    output ringer,       // Make sound
    output motor         // Vibrate
);
	always @(*) begin
	motor = 0;
       ringer = 0;
		if(ring) begin // nếu như có chuông
			if(vibrate_mode) begin // nếu như có rung
				motor = 1; // bật động cơ
            end	
			else begin
				ringer = 1; // bật chuông
				// động cơ và chuông không bật cùng 1 lúc
		end
	end
end
endmodule


// case 2:

module top_module (
    input ring,
    input vibrate_mode,
    output ringer,       // Make sound
    output motor         // Vibrate
);

	assign motor = ring & vibrate_mode;
	assign ringer = ring & vibrate_mode;

endmodule
