transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/Racemuis/Documents/school/m\ artificial\ intelligence/semester\ 1/neuromorphic\ engineering/neuromorphic_engineering/neuron {C:/Users/Racemuis/Documents/school/m artificial intelligence/semester 1/neuromorphic engineering/neuromorphic_engineering/neuron/v_equation.v}
vlog -vlog01compat -work work +incdir+C:/Users/Racemuis/Documents/school/m\ artificial\ intelligence/semester\ 1/neuromorphic\ engineering/neuromorphic_engineering/neuron {C:/Users/Racemuis/Documents/school/m artificial intelligence/semester 1/neuromorphic engineering/neuromorphic_engineering/neuron/u_equation.v}
vlog -vlog01compat -work work +incdir+C:/Users/Racemuis/Documents/school/m\ artificial\ intelligence/semester\ 1/neuromorphic\ engineering/neuromorphic_engineering/neuron {C:/Users/Racemuis/Documents/school/m artificial intelligence/semester 1/neuromorphic engineering/neuromorphic_engineering/neuron/store.v}
vlog -vlog01compat -work work +incdir+C:/Users/Racemuis/Documents/school/m\ artificial\ intelligence/semester\ 1/neuromorphic\ engineering/neuromorphic_engineering/neuron {C:/Users/Racemuis/Documents/school/m artificial intelligence/semester 1/neuromorphic engineering/neuromorphic_engineering/neuron/RAM.v}
vlog -vlog01compat -work work +incdir+C:/Users/Racemuis/Documents/school/m\ artificial\ intelligence/semester\ 1/neuromorphic\ engineering/neuromorphic_engineering/neuron {C:/Users/Racemuis/Documents/school/m artificial intelligence/semester 1/neuromorphic engineering/neuromorphic_engineering/neuron/input_align.v}
vlog -vlog01compat -work work +incdir+C:/Users/Racemuis/Documents/school/m\ artificial\ intelligence/semester\ 1/neuromorphic\ engineering/neuromorphic_engineering/neuron {C:/Users/Racemuis/Documents/school/m artificial intelligence/semester 1/neuromorphic engineering/neuromorphic_engineering/neuron/izhneuron_verilog.v}
vlog -vlog01compat -work work +incdir+C:/Users/Racemuis/Documents/school/m\ artificial\ intelligence/semester\ 1/neuromorphic\ engineering/neuromorphic_engineering/neuron {C:/Users/Racemuis/Documents/school/m artificial intelligence/semester 1/neuromorphic engineering/neuromorphic_engineering/neuron/neg_store.v}

