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
// CREATED		"Mon Nov 01 18:05:25 2021"

module aer(
	clk,
	reset,
	write_en,
	preset,
	spikes,
	EN_Neuron,
	FIFO_full,
	FIFO_empty,
	AER
);


input wire	clk;
input wire	reset;
input wire	write_en;
input wire	preset;
input wire	[4:0] spikes;
output reg	EN_Neuron;
output wire	FIFO_full;
output wire	FIFO_empty;
output wire	[3:0] AER;

wire	[3:0] encoder_out;
wire	[4:0] FIFO_out;
wire	[4:0] mux_out;
wire	n_preset;
wire	n_read_en;
wire	n_reset;
wire	read_en;
wire	[4:0] remainder;





comparator	b2v_comparator(
	.comp_in(remainder),
	.comp_out(read_en));
	defparam	b2v_comparator.VECTOR_WIDTH = 5;


FIFO_buffer	b2v_FIFO_buffer(
	.clk(clk),
	.reset(reset),
	.read_en(read_en),
	.write_en(write_en),
	.FIFO_in(spikes),
	.FIFO_full(FIFO_full),
	.FIFO_empty(FIFO_empty),
	.FIFO_out(FIFO_out));
	defparam	b2v_FIFO_buffer.FIFO_DEPTH = 4;
	defparam	b2v_FIFO_buffer.FIFO_SIZE = 16;
	defparam	b2v_FIFO_buffer.VECTOR_WIDTH = 5;


always@(posedge clk or negedge n_reset or negedge n_preset)
begin
if (!n_reset)
	begin
	EN_Neuron <= 0;
	end
else
if (!n_preset)
	begin
	EN_Neuron <= 1;
	end
else
	begin
	EN_Neuron <= read_en;
	end
end

assign	n_read_en =  ~read_en;

assign	n_reset =  ~reset;

multiplexer b2v_multiplexer(
	.a(FIFO_out),
	.b(remainder),
	.selector(read_en),
	.mux_out(mux_out));

priority_encoder	b2v_priority_encoder(
	.clk(clk),
	.reset(reset),
	.encoder_in(mux_out),
	.encoder_out(encoder_out),
	.remainder(remainder));
	defparam	b2v_priority_encoder.VECTOR_WIDTH = 5;

assign	n_preset = ~preset;
assign	AER = encoder_out;

endmodule

module aer_testbench();
		reg clk, reset, write_en, preset;
		reg [4:0] spikes;
		wire EN_Neuron;
		wire FIFO_full, FIFO_empty;
		wire [3:0] AER;	
		integer i;	
		
		aer dut  (.clk(clk),
								.reset(reset),
								.write_en(write_en),
								.preset(preset),
								.spikes(spikes),
								.EN_Neuron(EN_Neuron),
								.FIFO_full(FIFO_full),
								.FIFO_empty(FIFO_empty),
								.AER(AER)
							  );
		initial begin
			// Initialize Inputs
			reset = 1'b0;
			write_en  = 1'b1;    
			preset = 1'b0;		
			
			#10;
			spikes  = 5'b00000;
			#20;
			spikes  = 5'b00001;
			#20;
			spikes  = 5'b00000;
			#20
			spikes  = 5'b11011;
			#20;
			spikes  = 5'b00000;
			#20;
			spikes  = 5'b00110;
			#20;
			spikes  = 5'b00000;
		end
		
		// Create a clock that switches every 10 timepoints
		initial begin
			clk  = 1'b0;
			for(i = 0; i<=50; i = i+1) begin
				#10 clk = ~clk; 
			end
		end
endmodule
