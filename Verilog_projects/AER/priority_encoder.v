module priority_encoder(clk, encoder_in, reset, encoder_out, remainder);
	parameter 	VECTOR_WIDTH = 5;						// such that [VECTOR_WIDTH-1:0] = 5 bits
	
	input clk, reset;										// Single bit inputvalue
	input [VECTOR_WIDTH-1:0] encoder_in; 			// Input spike vector (packed array)
	
	output reg [3:0] encoder_out;						// Initialize 3 bits output
	output reg [VECTOR_WIDTH-1:0] remainder;		// Output spike vector (packed array)
	integer i;
	integer stop;


	always@(posedge clk, posedge reset) begin		
		if(reset)begin
			encoder_out <= 4'b1111;
			remainder <= 0;
		end
		
		else begin
			remainder <= encoder_in;
			encoder_out <= 4'b1111;						// -1 in two's complement notation; default if there are no spikes
			i = VECTOR_WIDTH-1;
			stop = 0;
			while(!stop && i>=0) begin		
				if(encoder_in[i]) begin
					remainder[i] <= 0;
					encoder_out <= i;
					stop = 1;
				end
				i = i-1;
			end
		end
	end
	
endmodule 

module priorty_encoder_testbench();
		reg clk, reset;
		reg [4:0] encoder_in;
		wire [4:0] remainder;
		wire [3:0] encoder_out;
		integer i, j;
		
		priority_encoder dut (  .clk(clk),
										.reset(reset),
										.encoder_in(encoder_in),
										.encoder_out(encoder_out),
										.remainder(remainder)
									 );
		
		initial begin
			clk  = 1'b0;
			reset = 1'b1;
			#10;
			reset = 1'b0;
			#10;
			for(i = 0; i<2**5; i = i+1) begin
				encoder_in = i; #20;
			end
		end
		
		// Create a clock that switches every 10 timepoints
		initial begin
			clk  = 1'b0;
			for(j = 0; j<=50; j = i+1) begin
				#10 clk = ~clk; 
			end
		end
endmodule 