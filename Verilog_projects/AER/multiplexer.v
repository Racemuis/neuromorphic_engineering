module multiplexer(a, b, selector, mux_out);
parameter 	VECTOR_WIDTH = 5;
input [VECTOR_WIDTH-1:0] a, b;
input selector;
output [VECTOR_WIDTH-1:0] mux_out;

assign mux_out = selector?a:b;

endmodule 