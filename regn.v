module regn #(N) (
	input [N-1:0] R,
	input Rin, Clock,
	output reg [N-1:0] Q
);
	
	always @(posedge Clock)
		if (Rin)
			Q <= R;
endmodule
