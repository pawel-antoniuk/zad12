module counter_T_4_bits(
	input clk, enable, sreset,
	output[3:0] Q
);

	wire[3:1] c;
	assign c[1] = Q[0] & enable;
	assign c[2] = Q[1] & c[1];
	assign c[3] = Q[2] & c[2];

	FFT_sreset(clk, enable, sreset, Q[0]);
	FFT_sreset(clk, c[1], sreset, Q[1]);
	FFT_sreset(clk, c[2], sreset, Q[2]);
	FFT_sreset(clk, c[3], sreset, Q[3]);

endmodule
