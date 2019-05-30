module control(
	input clk,
	input start,
	input reset,
	
	input  datapath_found,
	output reg datapath_mv_addr,
	output reg datapath_load
	
);
	(* keep *) reg [2:0] state, next;

	localparam
		s0 = 3'b000,
		s1 = 3'b001,
		s2 = 3'b010,
		s3 = 3'b011,
		s4 = 3'b100,
		s5 = 3'b101;
		
	always @(posedge clk, negedge reset)
		if (~reset) 	state <= s0;
		else		   	state <= next;
		
	always @(state) begin
		datapath_load = 0;
		datapath_mv_addr = 0;
		case(state)
			s0: begin
				if(start) begin
					next = s1;
				end
				else begin
					next = s0;
				end
			end
			s1: begin
				datapath_load = 1;
				next = s2;
			end
			s2: begin
				//datapath_load = 1;
				next = s3;
			end
			s3: begin
				datapath_mv_addr = 1;
				next = s4;
			end
			s4: begin
				//datapath_mv_addr = 1;
				next = s5;
			end
			s5: begin
				if(!datapath_found) begin
					next = s1;
				end
				else begin
					next = s0;
				end
			end
		endcase
	end

endmodule
