module binary_search(
	input clk,
	input clr,
	input start,
	input [7:0] A,
	
	output [7:0] Data,
	output [7:0] Addr,
	output found,
	output [4:0] L
);
	(* keep *) wire ctrl_dp_found;
	(* keep *) wire ctrl_dp_mv_addr;
	(* keep *) wire ctrl_dp_load;

	control ctrl(
		.clk(clk),
		.start(start),
		.reset(clr),
		.datapath_found(ctrl_dp_found),
		.datapath_mv_addr(ctrl_dp_mv_addr),
		.datapath_load(ctrl_dp_load));

	datapath dp(
		.clk(clk),
		.clr(clr),
		.A(A),
		.mv_addr(ctrl_dp_mv_addr),
		.load(ctrl_dp_load),
		.Data(Data),
		.Addr(Addr),
		.L(L),
		.found(ctrl_dp_found));
		
	mem32x8 mem(
		.clock(clk),
		.address(Addr),
		.data(),
		.wren(0),
		.q(Data));
		
	assign found = ctrl_dp_found;

endmodule
