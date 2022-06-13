module mux(a, b, c, d, selector, mux_out);
	parameter 	VECTOR_WIDTH = 5;
	input [VECTOR_WIDTH-1:0] a, b, c, d;
	input [1:0] selector;
	output [VECTOR_WIDTH-1:0] mux_out;

	assign mux_out = selector[1]? (selector[0]? c : d) : (selector[0]? b : a);

endmodule 