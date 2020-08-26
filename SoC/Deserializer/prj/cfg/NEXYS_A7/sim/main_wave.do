onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /hw_standalone_tb/DUT/clk
add wave -noupdate /hw_standalone_tb/DUT/reset
add wave -noupdate -height 21 -expand -group RegFile /hw_standalone_tb/DUT/regfile/ra1
add wave -noupdate -height 21 -expand -group RegFile /hw_standalone_tb/DUT/regfile/ra2
add wave -noupdate -height 21 -expand -group RegFile /hw_standalone_tb/DUT/regfile/wa3
add wave -noupdate -height 21 -expand -group RegFile /hw_standalone_tb/DUT/regfile/wd3
add wave -noupdate -height 21 -expand -group RegFile /hw_standalone_tb/DUT/regfile/rd1
add wave -noupdate -height 21 -expand -group RegFile /hw_standalone_tb/DUT/regfile/rd2
add wave -noupdate -height 21 -expand -group RegFile /hw_standalone_tb/DUT/regfile/we3
add wave -noupdate -height 21 -expand -group RegFile /hw_standalone_tb/DUT/regfile/regf
add wave -noupdate -height 21 -expand -group ALU /hw_standalone_tb/DUT/ALU_inst/srca
add wave -noupdate -height 21 -expand -group ALU /hw_standalone_tb/DUT/ALU_inst/srcb
add wave -noupdate -height 21 -expand -group ALU /hw_standalone_tb/DUT/ALU_inst/aluctrl
add wave -noupdate -height 21 -expand -group ALU /hw_standalone_tb/DUT/ALU_inst/aluout
add wave -noupdate -height 21 -expand -group ALU /hw_standalone_tb/DUT/ALU_inst/zero
add wave -noupdate -height 21 -expand -group Controller /hw_standalone_tb/DUT/Controller/mnemonic
add wave -noupdate -height 21 -expand -group Controller /hw_standalone_tb/DUT/Controller/reg_write
add wave -noupdate -height 21 -expand -group Controller /hw_standalone_tb/DUT/Controller/mem_write
add wave -noupdate -height 21 -expand -group Controller /hw_standalone_tb/DUT/Controller/ALUsrc
add wave -noupdate -height 21 -expand -group Controller /hw_standalone_tb/DUT/Controller/imm_gen_mode
add wave -noupdate -height 21 -expand -group Controller /hw_standalone_tb/DUT/Controller/instruction
add wave -noupdate -height 21 -expand -group Controller /hw_standalone_tb/DUT/Controller/rf_wd3src
add wave -noupdate -height 21 -expand -group {Instruction mem} /hw_standalone_tb/DUT/imem/addr
add wave -noupdate -height 21 -expand -group {Instruction mem} /hw_standalone_tb/DUT/imem/rdata
add wave -noupdate -height 21 -expand -group {Instruction mem} /hw_standalone_tb/DUT/imem/RAM
add wave -noupdate -height 21 -expand -group {Data memory} /hw_standalone_tb/DUT/dmem/addr
add wave -noupdate -height 21 -expand -group {Data memory} /hw_standalone_tb/DUT/dmem/wdata
add wave -noupdate -height 21 -expand -group {Data memory} /hw_standalone_tb/DUT/dmem/mem_write
add wave -noupdate -height 21 -expand -group {Data memory} /hw_standalone_tb/DUT/dmem/rdata
add wave -noupdate -height 21 -expand -group {Data memory} /hw_standalone_tb/DUT/dmem/RAM
add wave -noupdate -height 21 -expand -group {Imm gen} /hw_standalone_tb/DUT/Imm_gen_adder/instr
add wave -noupdate -height 21 -expand -group {Imm gen} /hw_standalone_tb/DUT/Imm_gen_adder/mode
add wave -noupdate -height 21 -expand -group {Imm gen} /hw_standalone_tb/DUT/Imm_gen_adder/out
add wave -noupdate -height 21 -expand -group {Current look in top} /hw_standalone_tb/DUT/instruction
add wave -noupdate -height 21 -expand -group {Current look in top} /hw_standalone_tb/DUT/PC_count_out
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {75 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 398
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {151030 ps}
