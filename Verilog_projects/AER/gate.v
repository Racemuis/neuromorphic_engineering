module gate(clk, reset, spikes, gate_en);

parameter VECTOR_WIDTH = 5;							// Number of input neurons
parameter DURATION = 15;								// Duration of the high output after a spike

input clk, reset;											// 1-bit input wires
input [VECTOR_WIDTH-1:0] spikes;						// VECTOR_WIDTH-bits vector of spikes
output gate_en;											// 1-bit output wire

integer clock_counter = 0;								// Internal clock counter
wire trigger;												// Internal wire that is high when there's a spike

assign gate_en = (clock_counter > 0) ? 1:0;		// Specify output depending on clock counter
assign trigger = (|spikes)? 1:0;						// High if there is a spike


always@(posedge clk, posedge reset, posedge trigger) begin
	// Asynchronous reset
	if(reset) begin
		clock_counter <= 0;
		//mode <= 0;
	end
	
	// Update the duration
	else begin 			
		if(trigger) begin
			clock_counter <= DURATION;
		end
		else if(clk) begin
			clock_counter <= (clock_counter - 1 > 0)? clock_counter-1:0;
		end
		else begin
			clock_counter = clock_counter;
			end
	end
end 

endmodule

module gate_textbench();
	parameter VECTOR_WIDTH = 5;
	
	reg clk, reset;
	reg [VECTOR_WIDTH-1:0] spikes;
	
	wire gate_en;
	integer i;
	
	gate dut (.clk(clk),
				 .reset(reset),
				 .spikes(spikes),
				 .gate_en(gate_en));
				 
	initial begin
		// Initialize inputs
		reset = 1'b1;
		clk = 1'b0;
		spikes = 5'b00000;
		
		#20;
		reset = 1'b0;
		
		
		#10;
		spikes = 5'b01100;
		#20;
		spikes = 5'b00000;
		#20;
		spikes = 5'b00000;
		#20;
		spikes = 5'b00010;
		#20;
		spikes = 5'b00000;
		#20;
		spikes = 5'b00000;
		#20;
		spikes = 5'b10000;
		#20;
		spikes = 5'b00000;
	end

initial begin
			clk  = 1'b0;
			for(i = 0; i<=50; i = i+1) begin
				#10 clk = ~clk; 
			end
		end
endmodule
