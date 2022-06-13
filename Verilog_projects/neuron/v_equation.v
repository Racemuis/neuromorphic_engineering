module v_equation(clk, rst, v, u, I, v_out, spike);
parameter threshold = 300;
parameter c = -650;

input signed [31:0] v, u;
input signed [10:0] I;
input rst, clk;

output integer v_out;
output reg spike;

integer intermediate;

//assign intermediate = ((v*v)>>>8) + (v<<<1) + (v<<<2) + 1400 - u + I;
//assign spike = (intermediate > threshold)? 1'b1 : 1'b0;
//assign v_out = (rst)? c : ((spike)? c : intermediate); 

always@(*) begin
	intermediate = ((v*v)>>>8) + (v<<<1) + (v<<<2) + 1400 - u + I;
	if(intermediate > threshold) 
		spike = 1'b1;
	else 
		spike = 1'b0;
		
	if(rst)begin
		v_out <= c;
		spike <= 1'b0;
		end
		
	else begin
		if(spike) begin
			v_out = c;
		end
		else
			v_out = intermediate;
	end
		
end

endmodule

module v_equation_testbench();

reg[31:0] v,u;
reg[10:0] I;
reg rst, clk;

integer i;

wire [31:0] v_out;//, intermediate;
wire spike;

v_equation dut (.clk(clk),
					.rst(rst),
					.v(v),
					.u(u),
					.I(I),
					.v_out(v_out),
					.spike(spike)
					);
					
initial begin
	clk = 0;
	v = 0;
	u = 3;
	I = 5;
	rst = 1'b1;
	
	#20;
	rst = 1'b0;
	v = 30;
	#50;

	
end

	initial begin
			clk  = 1'b0;
			for(i = 0; i<=50; i = i+1) begin
				#10 clk = ~clk; 
			end
	end

endmodule 