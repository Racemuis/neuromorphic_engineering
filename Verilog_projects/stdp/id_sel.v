module id_sel(clk, rst, pre_spike, post_spike, incr, decr, sim);
	input clk, rst, pre_spike, post_spike; 				// single bit inputs
	output reg incr, decr;										// 5 bit address
	output wire sim;
	
	assign sim = pre_spike && post_spike;
	
	
	always @ (posedge clk, posedge rst)
	begin 
		if (rst)
			begin
				decr <= 1'b0;
				incr <= 1'b0;
				//sim  <= 1'b0;
			end	
			
		else begin
			if(pre_spike && ~post_spike) begin
					decr <= 1'b0;
					incr <= 1'b1;
					//sim  <= 1'b0;
				end
			
			if  (~pre_spike && post_spike) begin
				decr <= 1'b1;
				incr <= 1'b0;
				//sim  <= 1'b0;	
			end
			
			/*if (pre_spike && post_spike) begin
					sim <= 1'b1;
			end
			
			if (~pre_spike && ~post_spike) begin		
				sim	<=1'b0;
			end*/
			/*begin
				decr <= 1'b0;
				incr <= 1'b0;
			end*/	
		end	
	end 
endmodule


module id_sel_testbench();
	wire incr, decr, sim;
	reg clk, pre_spike, post_spike,rst;
	integer i;
	
	id_sel devicetest  (.clk(clk),
						.rst(rst), 
						.pre_spike(pre_spike),
						.post_spike(post_spike),
						.incr(incr),
						.decr(decr),
						.sim(sim)
						  );
	initial begin
		// Initialize Inputs
		rst = 1'b1;
		clk  = 1'b0;
		pre_spike = 1'b0;
		post_spike = 1'b0;
		
		
		#10; //wait 10 nanoseconds 
		rst = 1'b0;
		pre_spike = 1'b1;
		post_spike = 1'b0;
		
		#20; 
		pre_spike = 1'b0;
		post_spike = 1'b0;
		
		
		#20;
		pre_spike = 1'b0;
		post_spike = 1'b1;
		
		#10;
		pre_spike = 1'b0;
		post_spike = 1'b0;
		
		#20;
		
		pre_spike = 1'b1;
		post_spike = 1'b1;
		#10;
		
	end
	
	// Create a clock that switches every 10 timepoints
	initial begin
			clk  = 1'b0;
			for(i = 0; i<=50; i = i+1) begin
				#10 clk = ~clk; 
			end
	end
endmodule 