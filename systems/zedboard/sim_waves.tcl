#source ../sim_waves.tcl

proc reset_waves { } {
    set orca_system_name [lindex [get_bd_designs] [lsearch [get_bd_designs] *orca_system*]]
    catch { close_wave_config -force } error

    add_wave_divider "Top level"
    add_wave /[set orca_system_name]_wrapper/[set orca_system_name]_i/processing_system7_0_FCLK_CLK0 /[set orca_system_name]_wrapper/[set orca_system_name]_i/processing_system7_0_FCLK_RESET0_N /[set orca_system_name]_wrapper/[set orca_system_name]_i/clk_wiz_clk_out1 /[set orca_system_name]_wrapper/[set orca_system_name]_i/clock_clk_2x_out /[set orca_system_name]_wrapper/[set orca_system_name]_i/clock_peripheral_reset /[set orca_system_name]_wrapper/[set orca_system_name]_i/rst_clk_wiz_100M_interconnect_aresetn /[set orca_system_name]_wrapper/[set orca_system_name]_i/rst_clk_wiz_100M_peripheral_aresetn /[set orca_system_name]_wrapper/[set orca_system_name]_i/leds_8bits_tri_o

    add_wave /[set orca_system_name]_wrapper/[set orca_system_name]_i/clock_peripheral_reset_cpu
    add_wave /[set orca_system_name]_wrapper/[set orca_system_name]_i/orca/U0/core/clk
    add_wave /[set orca_system_name]_wrapper/[set orca_system_name]_i/orca/U0/core/program_counter
    add_wave /[set orca_system_name]_wrapper/[set orca_system_name]_i/orca/U0/core/ifetch_to_decode_instruction
    add_wave /[set orca_system_name]_wrapper/[set orca_system_name]_i/orca/U0/core/decode_to_execute_instruction
    add_wave /[set orca_system_name]_wrapper/[set orca_system_name]_i/orca/U0/core/X/to_lsu_valid
    add_wave /[set orca_system_name]_wrapper/[set orca_system_name]_i/orca/U0/core/X/alu_select
    add_wave /[set orca_system_name]_wrapper/[set orca_system_name]_i/orca/U0/core/X/alu/from_shift_ready
    add_wave /[set orca_system_name]_wrapper/[set orca_system_name]_i/orca/U0/core/X/alu/from_shift_valid
    add_wave /[set orca_system_name]_wrapper/[set orca_system_name]_i/orca/U0/core/X/alu/shift_select
    add_wave /[set orca_system_name]_wrapper/[set orca_system_name]_i/orca/U0/core/X/alu/from_execute_ready
    add_wave /[set orca_system_name]_wrapper/[set orca_system_name]_i/orca/U0/core/X/alu/mul_dest_valid
    add_wave /[set orca_system_name]_wrapper/[set orca_system_name]_i/orca/U0/core/X/alu/source_valid
    add_wave /[set orca_system_name]_wrapper/[set orca_system_name]_i/orca/U0/core/D/the_register_file/registers
    add_wave /[set orca_system_name]_wrapper/[set orca_system_name]_i/orca/U0/core/D/the_register_file/writeback_select
    add_wave /[set orca_system_name]_wrapper/[set orca_system_name]_i/orca/U0/core/D/the_register_file/writeback_data
    add_wave /[set orca_system_name]_wrapper/[set orca_system_name]_i/orca/U0/core/D/the_register_file/writeback_enable
    add_wave /[set orca_system_name]_wrapper/[set orca_system_name]_i/orca/U0/core/X/fpau_data_enable
    add_wave /[set orca_system_name]_wrapper/[set orca_system_name]_i/orca/U0/core/X/fpau_enable
    add_wave /[set orca_system_name]_wrapper/[set orca_system_name]_i/orca/U0/core/X/fpau_enable_delay
    add_wave /[set orca_system_name]_wrapper/[set orca_system_name]_i/orca/U0/core/X/rs1_mux
    add_wave /[set orca_system_name]_wrapper/[set orca_system_name]_i/orca/U0/core/X/rs2_mux
    add_wave /[set orca_system_name]_wrapper/[set orca_system_name]_i/orca/U0/core/X/rs3_mux
    add_wave /[set orca_system_name]_wrapper/[set orca_system_name]_i/orca/U0/core/X/rs1_data
    add_wave /[set orca_system_name]_wrapper/[set orca_system_name]_i/orca/U0/core/X/rs2_data
    add_wave /[set orca_system_name]_wrapper/[set orca_system_name]_i/orca/U0/core/X/rs3_data
    add_wave /[set orca_system_name]_wrapper/[set orca_system_name]_i/orca/U0/core/X/from_writeback_ready
    add_wave /[set orca_system_name]_wrapper/[set orca_system_name]_i/orca/U0/core/X/to_alu_valid
    add_wave /[set orca_system_name]_wrapper/[set orca_system_name]_i/orca/U0/core/X/from_alu_ready
    add_wave /[set orca_system_name]_wrapper/[set orca_system_name]_i/orca/U0/core/X/to_execute_instruction
    add_wave /[set orca_system_name]_wrapper/[set orca_system_name]_i/orca/U0/core/X/to_execute_next_instruction

    add_wave_divider "FPAU"

    add_wave /[set orca_system_name]_wrapper/[set orca_system_name]_i/orca/U0/core/D/fpau/en
    add_wave /[set orca_system_name]_wrapper/[set orca_system_name]_i/orca/U0/core/D/fpau/op
    add_wave /[set orca_system_name]_wrapper/[set orca_system_name]_i/orca/U0/core/D/fpau/a0
    add_wave /[set orca_system_name]_wrapper/[set orca_system_name]_i/orca/U0/core/D/fpau/a1
    add_wave /[set orca_system_name]_wrapper/[set orca_system_name]_i/orca/U0/core/D/fpau/acc
    add_wave /[set orca_system_name]_wrapper/[set orca_system_name]_i/orca/U0/core/D/fpau/omega
    add_wave /[set orca_system_name]_wrapper/[set orca_system_name]_i/orca/U0/core/D/fpau/rsum
    add_wave /[set orca_system_name]_wrapper/[set orca_system_name]_i/orca/U0/core/D/fpau/out2
    
    #orca_reset_waves add_wave add_wave_divider /[set orca_system_name]_wrapper/[set orca_system_name]_i/orca/U0
}
    

proc add_wave_data_masters { } {
    set orca_system_name [lindex [get_bd_designs] [lsearch [get_bd_designs] *orca_system*]]
    orca_add_wave_data_masters add_wave add_wave_divider /[set orca_system_name]_wrapper/[set orca_system_name]_i/orca/U0
}

proc add_wave_instruction_masters { } {
    set orca_system_name [lindex [get_bd_designs] [lsearch [get_bd_designs] *orca_system*]]
    orca_add_wave_instruction_masters add_wave add_wave_divider /[set orca_system_name]_wrapper/[set orca_system_name]_i/orca/U0
}

proc add_wave_instruction_cache { } {
    set orca_system_name [lindex [get_bd_designs] [lsearch [get_bd_designs] *orca_system*]]
    orca_add_wave_instruction_cache add_wave add_wave_divider /[set orca_system_name]_wrapper/[set orca_system_name]_i/orca/U0
}

proc add_wave_data_cache { } {
    set orca_system_name [lindex [get_bd_designs] [lsearch [get_bd_designs] *orca_system*]]
    orca_add_wave_data_cache add_wave add_wave_divider /[set orca_system_name]_wrapper/[set orca_system_name]_i/orca/U0
}

proc add_wave_instruction_fetch { } {
    set orca_system_name [lindex [get_bd_designs] [lsearch [get_bd_designs] *orca_system*]]
    orca_add_wave_instruction_fetch add_wave add_wave_divider /[set orca_system_name]_wrapper/[set orca_system_name]_i/orca/U0
}

proc add_wave_syscall { } {
    set orca_system_name [lindex [get_bd_designs] [lsearch [get_bd_designs] *orca_system*]]
    orca_add_wave_syscall add_wave add_wave_divider /[set orca_system_name]_wrapper/[set orca_system_name]_i/orca/U0
}

proc add_wave_lsu { } {
    set orca_system_name [lindex [get_bd_designs] [lsearch [get_bd_designs] *orca_system*]]
    orca_add_wave_lsu add_wave add_wave_divider /[set orca_system_name]_wrapper/[set orca_system_name]_i/orca/U0
}

proc add_wave_execute { } {
    set orca_system_name [lindex [get_bd_designs] [lsearch [get_bd_designs] *orca_system*]]
    orca_add_wave_execute add_wave add_wave_divider /[set orca_system_name]_wrapper/[set orca_system_name]_i/orca/U0
}

proc add_wave_alu { } {
    set orca_system_name [lindex [get_bd_designs] [lsearch [get_bd_designs] *orca_system*]]
    orca_add_wave_alu add_wave add_wave_divider /[set orca_system_name]_wrapper/[set orca_system_name]_i/orca/U0
}

proc add_wave_branch { } {
    set orca_system_name [lindex [get_bd_designs] [lsearch [get_bd_designs] *orca_system*]]
    orca_add_wave_branch add_wave add_wave_divider /[set orca_system_name]_wrapper/[set orca_system_name]_i/orca/U0
}

proc add_wave_decode { } {
    set orca_system_name [lindex [get_bd_designs] [lsearch [get_bd_designs] *orca_system*]]
    orca_add_wave_decode add_wave add_wave_divider /[set orca_system_name]_wrapper/[set orca_system_name]_i/orca/U0
}

proc add_wave_all { } {
    set orca_system_name [lindex [get_bd_designs] [lsearch [get_bd_designs] *orca_system*]]
    orca_add_wave_all add_wave add_wave_divider /[set orca_system_name]_wrapper/[set orca_system_name]_i/orca/U0
}
