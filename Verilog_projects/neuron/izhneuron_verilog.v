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
// CREATED		"Thu Dec 09 14:01:51 2021"

module izhneuron_verilog(
	clk,
	rst,
	en,
	WE,
	Addr,
	AER_BUS,
	Weight,
	spike_out
);


input wire	clk;
input wire	rst;
input wire	en;
input wire	WE;
input wire	[3:0] Addr;
input wire	[3:0] AER_BUS;
input wire	[10:0] Weight;
output wire	spike_out;

wire	SYNTHESIZED_WIRE_0;
wire	[31:0] SYNTHESIZED_WIRE_9;
wire	[31:0] SYNTHESIZED_WIRE_10;
wire	[31:0] SYNTHESIZED_WIRE_3;
wire	[31:0] SYNTHESIZED_WIRE_4;
wire	[10:0] SYNTHESIZED_WIRE_5;
wire	[10:0] SYNTHESIZED_WIRE_6;

assign	spike_out = SYNTHESIZED_WIRE_0;




u_equation	b2v_inst(
	.rst(rst),
	.clk(clk),
	.spike(SYNTHESIZED_WIRE_0),
	.u(SYNTHESIZED_WIRE_9),
	.v(SYNTHESIZED_WIRE_10),
	.u_out(SYNTHESIZED_WIRE_3));
	defparam	b2v_inst.d = 80;


store	b2v_inst2(
	.rst(rst),
	.clk(clk),
	.in(SYNTHESIZED_WIRE_3),
	.out(SYNTHESIZED_WIRE_9));


neg_store	b2v_inst3(
	.rst(rst),
	.clk(clk),
	.in(SYNTHESIZED_WIRE_4),
	.out(SYNTHESIZED_WIRE_10));


input_align	b2v_inst4(
	.clk(clk),
	.rst(rst),
	.en(en),
	.synaptic_in(SYNTHESIZED_WIRE_5),
	.out(SYNTHESIZED_WIRE_6));


RAM	b2v_inst5(
	.clk(clk),
	.rst(rst),
	.we(WE),
	.AER_bus(AER_BUS),
	.syn_addr(Addr),
	.syn_weight(Weight),
	.weight_out(SYNTHESIZED_WIRE_5));
	defparam	b2v_inst5.N_NEURONS = 4;


v_equation	b2v_inst6(
	.clk(clk),
	.rst(rst),
	.I(SYNTHESIZED_WIRE_6),
	.u(SYNTHESIZED_WIRE_9),
	.v(SYNTHESIZED_WIRE_10),
	.spike(SYNTHESIZED_WIRE_0),
	.v_out(SYNTHESIZED_WIRE_4));
	defparam	b2v_inst6.c = -650;
	defparam	b2v_inst6.threshold = 300;


endmodule

module izhneuron_verilog_testbench();
	reg en, rst, clk, WE;
	reg	[3:0] Addr;
	reg	[3:0] AER_BUS;
	reg	[10:0] Weight;
	
	wire spike_out;
		
	integer i;
	
	izhneuron_verilog dut (.clk(clk),
								  .rst(rst),
								  .WE(WE),
								  .Addr(Addr),
								  .AER_BUS(AER_BUS),
								  .Weight(Weight),
								  .en(en),
						        .spike_out(spike_out)
								  );

	initial begin
		rst = 1'b1;
		clk = 1'b1;
		en  = 1'b0;    
		WE = 1'b0;
		AER_BUS = 0;
		Weight = 0;
		
		#30;
		rst = 1'b0;
		en = 1'b1;
		
		WE = 1'b1;
		Weight = 120;
		Addr = 1;
		
		#20;
		WE = 1'b0;
		#40;
		AER_BUS = 1;
	end
	
	// Create a clock that switches every 10 timepoints
	initial begin
			clk  = 1'b0;
			for(i = 0; i<=50; i = i+1) begin
				#10 clk = ~clk; 
			end
	end



endmodule 