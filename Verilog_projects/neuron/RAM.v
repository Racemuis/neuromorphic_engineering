module RAM(clk, rst, we, syn_addr, AER_bus, syn_weight, weight_out);

	parameter N_NEURONS=4;				// The number of neurons that have a synaptic connection to this neuron
	input we, rst, clk;					// 1-bit inputs write enabled & reset
	input [3:0] AER_bus, syn_addr;	// 4 bits inputs AER_bus and syn_addr
	input [10:0] syn_weight;			// 11 bits input syn_weight
	output reg [10:0] weight_out;			// 11 bits output weight (of neuron AER_bus)

	reg [10:0] memory [N_NEURONS-1:0];
	integer i;

	always @ (posedge clk) begin
					if (rst) begin
							weight_out <= 11'b00000000000;
							for (i=0; i<N_NEURONS; i= i+1)begin				// Set all connections to 0
								memory[i] <= 11'b00000000000;
							end
					end
					
					else begin
						if(we)
							memory[syn_addr] <= syn_weight;
						else
							weight_out <= memory[AER_bus];
					end
	end


endmodule 

module RAM_testbench();
	reg we, rst, clk;
	reg [3:0] AER_bus, syn_addr;
	reg [10:0] syn_weight;
	wire [10:0] weight_out;
	integer i;
	
	RAM dut (.clk(clk),
				.we(we),
			   .rst(rst),
				.AER_bus(AER_bus),
				.syn_addr(syn_addr),
				.syn_weight(syn_weight),
				.weight_out(weight_out)
				);

	initial begin
		rst = 1'b1;
		we  = 1'b0;    
		
		#20;
		rst = 1'b0;
		syn_addr = 3;
		syn_weight = 10;
		we = 1;
		#20;
		we = 0;
		AER_bus = 2;
		#20;
		AER_bus = 3;
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