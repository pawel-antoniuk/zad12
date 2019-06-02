module datapath(
	input clk,
	input clr,
	
	//control
	input [7:0] A,
	input mv_addr,
	input load,

	//mem
	input [7:0] Data,
	output[4:0] Addr,
	
	output reg [4:0] L,
	output reg found
);
	//reg [4:0] current_addr;
	localparam N = 32;
	/*
	input clk, enable, sreset,
	output[3:0] Q*/
	
	wire [7:0] reg_data_q;
	reg reg_data_in;
	regn #(8) reg_data (
		.R(Data),
		.Rin(reg_data_in),
		.Clock(clk),
		.Q(reg_data_q));
	
	reg [4:0] reg_addr_r;
	reg reg_addr_in;
	regn #(5) reg_addr (
		.R(reg_addr_r),
		.Rin(reg_addr_in),
		.Clock(clk),
		.Q(Addr));
	
	reg counter_ena;
	reg counter_sreset;
	(* keep *) wire [3:0] counter_Q;
	
	counter_T_4_bits counter(
		.clk(clk),
		.enable(counter_ena),
		.sreset(counter_sreset),
		.Q(counter_Q));
		
	always @(posedge clk) begin
		reg_addr_in = 0;
		counter_ena = 0;
		//found = 0;
		counter_sreset = 1;
		reg_addr_r = 0;
		
		if(~clr) begin
			reg_addr_r = N / 2;
			reg_addr_in = 1;
			counter_ena = 1;
			counter_sreset = 0;
			found = 0;
			L = 0;
		end
		if(mv_addr) begin
			if (reg_data_q > A) begin
				reg_addr_r = Addr - N / (4 << counter_Q);
				counter_ena = 1;
				reg_addr_in = 1;
			end
			else if(reg_data_q < A) begin
				reg_addr_r = Addr + N / (4 << counter_Q);
				counter_ena = 1;
				reg_addr_in = 1;
			end
			else begin
				found = 1;
				L = Addr;
			end
		end
	end
	
	always @(posedge clk) begin
		reg_data_in = 0;
		
		//if(clr) begin
		//end
		if(load) begin
			reg_data_in = 1;
		end
	end
	

endmodule
