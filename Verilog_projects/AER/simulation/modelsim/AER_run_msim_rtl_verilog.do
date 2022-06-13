transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/Racemuis/Documents/school/m\ artificial\ intelligence/semester\ 1/neuromorphic\ engineering/neuromorphic_engineering/AER_system {C:/Users/Racemuis/Documents/school/m artificial intelligence/semester 1/neuromorphic engineering/neuromorphic_engineering/AER_system/aer.v}
vlog -vlog01compat -work work +incdir+C:/Users/Racemuis/Documents/school/m\ artificial\ intelligence/semester\ 1/neuromorphic\ engineering/neuromorphic_engineering/AER_system {C:/Users/Racemuis/Documents/school/m artificial intelligence/semester 1/neuromorphic engineering/neuromorphic_engineering/AER_system/FIFO_buffer.v}
vlog -vlog01compat -work work +incdir+C:/Users/Racemuis/Documents/school/m\ artificial\ intelligence/semester\ 1/neuromorphic\ engineering/neuromorphic_engineering/AER_system {C:/Users/Racemuis/Documents/school/m artificial intelligence/semester 1/neuromorphic engineering/neuromorphic_engineering/AER_system/comparator.v}
vlog -vlog01compat -work work +incdir+C:/Users/Racemuis/Documents/school/m\ artificial\ intelligence/semester\ 1/neuromorphic\ engineering/neuromorphic_engineering/AER_system {C:/Users/Racemuis/Documents/school/m artificial intelligence/semester 1/neuromorphic engineering/neuromorphic_engineering/AER_system/priority_encoder.v}
vlog -vlog01compat -work work +incdir+C:/Users/Racemuis/Documents/school/m\ artificial\ intelligence/semester\ 1/neuromorphic\ engineering/neuromorphic_engineering/AER_system {C:/Users/Racemuis/Documents/school/m artificial intelligence/semester 1/neuromorphic engineering/neuromorphic_engineering/AER_system/multiplexer.v}

