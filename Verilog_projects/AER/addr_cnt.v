module addr_cnt(clk, en, en_addr, syn_addr);
	input clk, en, en_addr; // single bit inputsL: clock
	output reg [4:0] syn_addr; // 5 bit address
	initial begin
		syn_addr = 5'b00000; 
	end
	
		always @ (posedge clk)
				if(en && en_addr)
						syn_addr = syn_addr + 1;
						
endmodule


module addr_cnt_testbench();
	wire [4:0] syn_addr;
	reg clk, en, en_addr;
	
	addr_cnt devicetest  (.clk(clk),
						.en(en),
						.en_addr(en_addr),
						.syn_addr(syn_addr)
						  );
	initial begin
		// Initialize Inputs
		clk  = 1'b0;
		en  = 1'b0;
		en_addr  = 1'b0;
		
		#10; //wait 10 nanoseconds 
		
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
		
		#20
		
		en = 1'b0;
		en_addr=1'b0;
		
	end
	
	// Create a clock that switches every 10 timepoints
	always #10 clk = ~clk; 
endmodule 