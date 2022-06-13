module store(clk, rst, in, out);
input clk, rst;
input [31:0] in;
output integer out;

integer intermediate;

always @ (posedge clk) begin
	intermediate = in;
	out = intermediate;
end


endmodule


module store_testbench();
reg clk;
reg[31:0] in;
wire[31:0] out;
integer i;

store dut ( .clk(clk),
				.in(in),
				.out(out)
				);

initial begin
	in = 5;
	#20;
	in = 1;
	#20;
	in = 8;
	#20;
	in = 9;
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
