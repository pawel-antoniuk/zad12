module FFT_sreset(
	input clk, T, sclr,
	output reg Q
);

	always @(posedge clk)
	begin
		if (!sclr)	Q <= 0;
		else if (T)	Q <= ~Q;
		else				Q <= Q;
	end

endmodule
