transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/Racemuis/Documents/school/m\ artificial\ intelligence/semester\ 1/neuromorphic\ engineering/neuromorphic_engineering/Verilog_projects/stdp {C:/Users/Racemuis/Documents/school/m artificial intelligence/semester 1/neuromorphic engineering/neuromorphic_engineering/Verilog_projects/stdp/weight_cnt.v}
vlog -vlog01compat -work work +incdir+C:/Users/Racemuis/Documents/school/m\ artificial\ intelligence/semester\ 1/neuromorphic\ engineering/neuromorphic_engineering/Verilog_projects/stdp {C:/Users/Racemuis/Documents/school/m artificial intelligence/semester 1/neuromorphic engineering/neuromorphic_engineering/Verilog_projects/stdp/id_sel.v}
vlog -vlog01compat -work work +incdir+C:/Users/Racemuis/Documents/school/m\ artificial\ intelligence/semester\ 1/neuromorphic\ engineering/neuromorphic_engineering/Verilog_projects/stdp {C:/Users/Racemuis/Documents/school/m artificial intelligence/semester 1/neuromorphic engineering/neuromorphic_engineering/Verilog_projects/stdp/gate.v}
vlog -vlog01compat -work work +incdir+C:/Users/Racemuis/Documents/school/m\ artificial\ intelligence/semester\ 1/neuromorphic\ engineering/neuromorphic_engineering/Verilog_projects/stdp {C:/Users/Racemuis/Documents/school/m artificial intelligence/semester 1/neuromorphic engineering/neuromorphic_engineering/Verilog_projects/stdp/addr_cnt.v}
vlog -vlog01compat -work work +incdir+C:/Users/Racemuis/Documents/school/m\ artificial\ intelligence/semester\ 1/neuromorphic\ engineering/neuromorphic_engineering/Verilog_projects/stdp {C:/Users/Racemuis/Documents/school/m artificial intelligence/semester 1/neuromorphic engineering/neuromorphic_engineering/Verilog_projects/stdp/STDP_verilog.v}
vlog -vlog01compat -work work +incdir+C:/Users/Racemuis/Documents/school/m\ artificial\ intelligence/semester\ 1/neuromorphic\ engineering/neuromorphic_engineering/Verilog_projects/stdp {C:/Users/Racemuis/Documents/school/m artificial intelligence/semester 1/neuromorphic engineering/neuromorphic_engineering/Verilog_projects/stdp/mux.v}

