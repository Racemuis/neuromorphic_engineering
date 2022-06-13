module u_equation(rst, clk, v, u, spike, u_out); // index page 39 and 103 of the pdf

parameter d = 80;

input clk, rst;
input signed [31:0] v, u;
input wire spike;

output integer u_out;

integer intermediate;

//assign intermediate = (((v>>>2) - u)>>>6) + u;
//assign u_out = (spike)? intermediate : intermediate+d; 


always@(*) begin
	if(rst)
		u_out = d;
	else begin
		intermediate = (((v>>>2) - u)>>>6) + u;
		if(spike) 
			u_out = intermediate;
		else 
			u_out = intermediate+d;
	end
		
end
endmodule

