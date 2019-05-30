module binary_search_board(
	input [9:0] SW,
	input CLOCK_50,
	input [0:0] KEY,
	output [6:0] HEX0, HEX1,
	output [9:0] LEDR
);

	wire [4:0] L;
	wire c;
	
	counter_modulo_k_rollover_0 #(500) (1, 1, CLOCK_50, ,c);
	
	binary_search(c, KEY[0], SW[9], SW[7:0], , , LEDR[9], L);
	
	decoder_hex_16 dec1 (L[3:0], HEX0);
	decoder_hex_16 dec2 (L[4:4], HEX1);
	
endmodule
