module input_align(clk, rst, en, synaptic_in, out);
input en, rst, clk;
input [10:0] synaptic_in;
output reg [10:0] out;

reg [10:0] intermediate;

always @ (posedge clk) begin
	if(rst) begin
		intermediate = 0;
	end
	else begin
		intermediate = intermediate + synaptic_in;
		
		if(en) begin
				out = intermediate; // Might be that syn_in belongs to the next sequence of spikes
				intermediate = 0;
		end
	end


end

endmodule 

module input_align_testbench();
	reg en, rst, clk;
	reg [10:0] syn_in;
	wire [10:0] out;
	integer i;
	
	input_align dut (.clk(clk),
						  .en(en),
						  .rst(rst),
						  .synaptic_in(syn_in),
						  .out(out));

	initial begin
		rst = 1'b1;
		en  = 1'b0;    
		
		#20;
		rst = 1'b0;
		syn_in = 3;
		en = 1;
		#20;
		en = 0;
		syn_in = 2;
		#20;
		syn_in = 3;
		#20;
		syn_in = 5;
		#20;
		en = 1;
		syn_in = 1;
		#20;
		syn_in = 2;
		#20;
		syn_in = 3;
		#20;
	end
	
	// Create a clock that switches every 10 timepoints
	initial begin
			clk  = 1'b0;
			for(i = 0; i<=50; i = i+1) begin
				#10 clk = ~clk; 
			end
	end

endmodule 