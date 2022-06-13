module comparator(comp_in, comp_out);
	parameter VECTOR_WIDTH = 5;
	input [VECTOR_WIDTH-1:0] comp_in;
	output comp_out;
	
	assign comp_out = (!comp_in || ^comp_in === 1'bx)? 1'b1:1'b0;

endmodule 

module comparator_testbench();
	reg [4:0] comp_in;
	wire comp_out;

	comparator dut (.comp_in(comp_in),
						 .comp_out(comp_out)
						);
						
	integer i;
	initial begin
		for(i = 0; i<2**5; i= i+1) begin
			comp_in = i; #20;
		end
		comp_in = 5'bxxxxx;
		#20;
	end

endmodule 