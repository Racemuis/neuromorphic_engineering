// Copyright (C) 2020  Intel Corporation. All rights reserved.
// Your use of Intel Corporation's design tools, logic functions 
// and other software and tools, and any partner logic 
// functions, and any output files from any of the foregoing 
// (including device programming or simulation files), and any 
// associated documentation or information are expressly subject 
// to the terms and conditions of the Intel Program License 
// Subscription Agreement, the Intel Quartus Prime License Agreement,
// the Intel FPGA IP License Agreement, or other applicable license
// agreement, including, without limitation, that your use is for
// the sole purpose of programming logic devices manufactured by
// Intel and sold by Intel or its authorized distributors.  Please
// refer to the applicable agreement for further details, at
// https://fpgasoftware.intel.com/eula.

// PROGRAM		"Quartus Prime"
// VERSION		"Version 20.1.1 Build 720 11/11/2020 SJ Lite Edition"
// CREATED		"Sat Nov 13 15:57:46 2021"

module STDP_verilog(
	clk,
	reset,
	en,
	en_addr,
	a,
	b,
	c,
	d,
	post_spikes,
	we,
	syn_addr,
	syn_weight
);


input wire	clk;
input wire	reset;
input wire	en;
input wire	en_addr;
input wire	[4:0] a;
input wire	[4:0] b;
input wire	[4:0] c;
input wire	[4:0] d;
input wire	[4:0] post_spikes;
output wire	we;
output wire	[1:0] syn_addr;
output wire	[10:0] syn_weight;

wire	decr;
wire	en_add;
wire	incr;
wire	[4:0] p_spikes;
wire	pre_spikes;
wire	[1:0] selector;
wire	sim;
wire	[4:0] spikes;
wire	post_spike;





addr_cnt	b2v_addr_cnt(
	.clk(clk),
	.reset(reset),
	.en(en),
	.en_addr(en_add),
	.syn_addr(selector));
	defparam	b2v_addr_cnt.SELECOR_DIMENSION = 2;


id_sel	b2v_inst(
	.clk(clk),
	.rst(reset),
	.pre_spike(pre_spikes),
	.post_spike(post_spike),
	.incr(incr),
	.decr(decr),
	.sim(sim));


weight_cnt	b2v_inst8(
	.clk(clk),
	.rst(reset),
	.en(en),
	.incr(incr),
	.decr(decr),
	.sim(sim),
	.syn_addr(selector),
	.we(we),
	.syn_weight(syn_weight));
	defparam	b2v_inst8.N_NEURONS = 4;


mux	b2v_inst9(
	.a(a),
	.b(b),
	.c(c),
	.d(d),
	.selector(selector),
	.mux_out(spikes));


gate	b2v_post_gate(
	.clk(clk),
	.reset(reset),
	.spikes(p_spikes),
	.gate_en(post_spike));
	defparam	b2v_post_gate.DURATION = 5;
	defparam	b2v_post_gate.VECTOR_WIDTH = 5;


gate	b2v_pre_gate(
	.clk(clk),
	.reset(reset),
	.spikes(spikes),
	.gate_en(pre_spikes));
	defparam	b2v_pre_gate.DURATION = 15;
	defparam	b2v_pre_gate.VECTOR_WIDTH = 5;

assign	en_add = en_addr;
assign	syn_addr = selector;
assign	p_spikes = post_spikes;

endmodule

module STDP_testbench();
reg clk, reset, en, en_addr;
reg [4:0] a, b, c, d, post_spikes;

wire	we;
wire	[1:0] syn_addr;
wire	[10:0] syn_weight;
integer i;

STDP_verilog dut (.clk(clk),
						.reset(reset),
						.en(en),
						.en_addr(en_addr),
						.a(a),
						.b(b),
						.c(c),
						.d(d),
						.post_spikes(post_spikes),
						.we(we),
						.syn_addr(syn_addr),
						.syn_weight(syn_weight)
						);

initial begin
	// Initialize Inputs
	clk  = 1'b0;
	en  = 1'b0;
	en_addr  = 1'b0;
	reset = 1'b1;
	a = 5'b00000;
	b = 5'b00000;
	c = 5'b00000;
	d = 5'b00000;
	post_spikes = 5'b00000;
	
	
	#10; //wait 10 nanoseconds 
	reset = 1'b0;
	en  = 1'b1;
	en_addr = 1'b1;
	
	#20
	en_addr = 1'b0;
	
	#20;
	post_spikes = 5'b00100;
	#20;
	post_spikes = 5'b00000;
	#20;
	b = 5'b10000;
	#20;
	b = 5'b00000;
end

// Create a clock that switches every 10 timepoints
initial begin
		clk  = 1'b0;
		for(i = 0; i<=50; i = i+1) begin
			#10 clk = ~clk; 
		end
end
endmodule
