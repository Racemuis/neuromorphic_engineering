module addr_cnt(clk, reset, en, en_addr, syn_addr);
	parameter SELECOR_DIMENSION = 2;							// The dimension of the selector bit
	input clk, reset, en, en_addr; 							// single bit inputsL: clock
	output reg [SELECOR_DIMENSION-1:0] syn_addr; 		// The selector bit of the MUX.
	initial begin
		
	end
	
		always @ (posedge clk, posedge reset)
				if(reset) begin
					syn_addr = 2'b00; 
				end
				else begin
					if(en && en_addr) begin
							syn_addr = syn_addr + 1;			// Increment the address of the neuron	
							syn_addr = syn_addr % 4; 			// Loop around the addresses if necessesary 
					end
				end
endmodule


module addr_cnt_testbench();
	wire [1:0] syn_addr;
	reg clk, en, en_addr, reset;
	integer i;
	
	addr_cnt devicetest  (.clk(clk),
						.reset(reset),
						.en(en),
						.en_addr(en_addr),
						.syn_addr(syn_addr)
						  );
	initial begin
		// Initialize Inputs
		clk  = 1'b0;
		en  = 1'b0;
		en_addr  = 1'b0;
		reset = 1'b1;
		
		#10; //wait 10 nanoseconds 
		reset = 1'b0;
		en  = 1'b1;
		
		#20; 
		
		en  = 1'b0;
		en_addr  = 1'b1;
		
		#20;
		
		en  = 1'b1;
		
		
		#10
		
		en = 1'b0;
		en_addr=1'b0;
		
		#20
		
		en = 1'b1;
		en_addr=1'b1;
		
		#10
		
		en = 1'b0;
		en_addr=1'b0;
		
		#20 
		
		en = 1'b1;
		en_addr=1'b1;
		
	end
	
	// Create a clock that switches every 10 timepoints
	initial begin
			clk  = 1'b0;
			for(i = 0; i<=50; i = i+1) begin
				#10 clk = ~clk; 
			end
	end
endmodule 