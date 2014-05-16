onerror {quit -f}
vlib work
vlog -work work lab3_part4.vo
vlog -work work lab3_part4.vt
vsim -novopt -c -t 1ps -L cycloneii_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.lab3_part4_vlg_vec_tst
vcd file -direction lab3_part4.msim.vcd
vcd add -internal lab3_part4_vlg_vec_tst/*
vcd add -internal lab3_part4_vlg_vec_tst/i1/*
add wave /*
run -all