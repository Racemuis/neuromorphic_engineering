module weight_cnt(clk,rst, en, incr, decr, sim, syn_addr, we, syn_weight);
	input clk,rst, en, incr, decr, sim; 								// single bit inputs
	input [1:0] syn_addr;
	parameter N_NEURONS=4;

	output reg we; 															//write enabled
	output reg [10:0] syn_weight; 										// 11 bit weight value
	reg [10:0] memory [N_NEURONS-1:0];
	integer i;

	always @ (posedge clk, posedge rst) begin
				if (rst) begin
						we <= 1'b1;												// Start writing
						syn_weight = 11'b00000000000;
						for (i=0; i<N_NEURONS; i= i+1)begin				// Define memory
							memory[i] = 11'b00000000000;
						end
				end
				
            else begin
					if (en && incr && sim) begin
						 memory[syn_addr] = memory[syn_addr] + 1;
						 syn_weight = memory[syn_addr];
					  end
					  
					else if (en && decr && sim) begin
						 memory[syn_addr] = memory[syn_addr] - 1;
						 syn_weight = memory[syn_addr];
					  end  
					  
					if(sim) begin
						we <= 1'b1;
						end
					else begin
						we <= 1'b0;
						end
				end
	end
			
endmodule


module weight_cnt_testbench();
	reg clk, rst, en, incr, decr, sim;
	reg [1:0] syn_addr;
	wire we;
	wire [10:0] syn_weight;
	integer i;
	
	weight_cnt dut (.clk(clk),
						 .rst(rst),
						 .en(en),
						 .incr(incr),
						 .decr(decr),
						 .sim(sim),
						 .syn_addr(syn_addr),
						 .we(we),
						 .syn_weight(syn_weight)
						);
	
	initial begin
		clk = 1'b0;
		rst = 1'b1;
		en = 1'b1;
		incr = 1'b0;
		decr = 1'b0;
		sim = 1'b0;
		syn_addr = 2'b00;
		
		#10;
		rst = 1'b0;
		incr = 1'b1;
		# 40;
		sim = 1'b1;
		# 40;
		sim = 1'b0;
		# 20;
		incr = 1'b0;
		#20;
		
		rst = 1'b1;
		#20;
		rst = 1'b0;
		decr = 1'b1;
		# 40;
		sim = 1'b1;
		# 40;
		sim = 1'b0;
		# 20;
		decr = 1'b0;
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
