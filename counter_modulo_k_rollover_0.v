module counter_modulo_k_rollover_0 #(parameter k=20)(
	input enable, aclr, clk,
	output reg[N-1:0] Q,
	output rollover
);

	localparam N = clogb2(k-1);
	
	function integer clogb2(input [31:0] v);
		for (clogb2 = 0; v > 0; clogb2 = clogb2 + 1)
			v = v >> 1;
	endfunction
	
	reg x;
			
	always @(posedge clk, negedge aclr)
	begin
		if (!aclr)
		begin
			Q <= { N{1'b0} };
			x = 0;
		end
		else if (Q == k-1)
		begin
			Q <= { N{1'b0} };
			x = 1;
		end
		else if (enable) 
		begin
			Q <= Q + 1'b1;
			x = 0;
		end
		else 						Q <= Q;
	end
	
	assign rollover = x;

endmodule
