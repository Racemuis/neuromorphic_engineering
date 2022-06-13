module FIFO_buffer(clk, reset, FIFO_in, read_en, write_en, FIFO_out, FIFO_full, FIFO_empty);
		parameter 	VECTOR_WIDTH = 5, 
						FIFO_DEPTH = 4,
						FIFO_SIZE = 2**FIFO_DEPTH;
		
		input clk, reset, read_en, write_en;			// Single bit inputvalues
		input [VECTOR_WIDTH-1:0] FIFO_in; 				// Input spike vector (packed array)
		
		output FIFO_full, FIFO_empty;						// Single bit outputvalues don't need reg because they're wires
		output reg [VECTOR_WIDTH-1:0] FIFO_out;		// Output spike vector (packed array)
		
		reg [VECTOR_WIDTH-1:0] buffer [FIFO_SIZE:0]; // Buffer (packed and unpacked array) https://verificationguide.com/systemverilog/systemverilog-packed-and-unpacked-array/
		
		reg [FIFO_DEPTH:0] read_ptr = 0;					// Initialize readpointer (of size FIFO_DEPTH bits)
		reg [FIFO_DEPTH:0] write_ptr = 0;				// Initialize writepointer (of size FIFO_DEPTH bits)
		
		// Assign warning wires whenever the righthandside changes 
		assign FIFO_empty = (read_ptr == write_ptr)? 1'b1:1'b0; 
		assign FIFO_full = (write_ptr == (read_ptr - 1)%FIFO_SIZE)? 1'b1:1'b0; //changed % FIFO_SIZE here
		
		always @ (posedge clk, posedge reset)
		begin
			if(reset)
				write_ptr <= 0;
				
			// Write to the buffer	
			else if(write_en && !FIFO_full)
					begin
					buffer[write_ptr] <= FIFO_in;
					// Increment the pointer & loop around.
					write_ptr <= (write_ptr+1)%FIFO_SIZE;
					end
		end
		
		always @ (negedge clk, posedge reset)
		begin
			if(reset)
					read_ptr <= 0;
			// Read from the buffer
			else if(read_en && !FIFO_empty)
				begin
				FIFO_out <= buffer[read_ptr];
				// Increment the pointer & loop around.
				read_ptr <= (read_ptr + 1)%FIFO_SIZE;
				end
		end
		
endmodule 

module FIFO_buffer_testbench();
		reg clk, reset, read_en, write_en;
		wire FIFO_full, FIFO_empty;
		reg [4:0] FIFO_in;
		wire [4:0] FIFO_out;
		integer i;
		
		FIFO_buffer dut  (.clk(clk),
								.reset(reset),
								.FIFO_in(FIFO_in),
								.read_en(read_en),
								.write_en(write_en),
								.FIFO_out(FIFO_out),
								.FIFO_full(FIFO_full),
								.FIFO_empty(FIFO_empty)
							  );
		initial begin
			// Initialize Inputs
			reset = 1'b0;
			FIFO_in  = 5'b00000;
			read_en  = 1'b0;
			write_en  = 1'b0;    

			
			#10;
			write_en  = 1'b1;			// Start writing to the buffer
			FIFO_in  = 5'b00001;
			#20;
			FIFO_in  = 5'b00010;
			#20;
			FIFO_in  = 5'b00011;
			read_en  = 1'b1; 			// Read the first value from the buffer
			#20
			FIFO_in  = 5'b00100;
			#20;
			FIFO_in  = 5'b00101;
			read_en  = 1'b0;			// Stop reading.
			#20;
			FIFO_in  = 5'b00110;
			#20
			write_en  = 1'b0;			// Stop writing.
			read_en  = 1'b1;			// Resume reading.
			#160
			read_en  = 1'b0;			// Stop reading.
		end
		
		// Create a clock that switches every 10 timepoints
		initial begin
			clk  = 1'b0;
			for(i = 0; i<=50; i = i+1) begin
				#10 clk = ~clk; 
			end
		end
endmodule 