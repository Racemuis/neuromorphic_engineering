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
// CREATED		"Fri Nov 19 11:28:09 2021"

module STDP_v(
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
wire	SYNTHESIZED_WIRE_0;





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
	.post_spike(SYNTHESIZED_WIRE_0),
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


mux_0	b2v_inst9(
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
	.gate_en(SYNTHESIZED_WIRE_0));
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
assign	p_spikes = post_spikes;
assign	syn_addr = selector;

endmodule

module mux_0(a,b,c,d,selector,mux_out);
/* synthesis black_box */

input [4:0] a;
input [4:0] b;
input [4:0] c;
input [4:0] d;
input [1:0] selector;
output [4:0] mux_out;

endmodule
