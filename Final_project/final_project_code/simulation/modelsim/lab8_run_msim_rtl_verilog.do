transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+D:/ECE385/ECE385_FinalProject {D:/ECE385/ECE385_FinalProject/vga_clk.v}
vlog -vlog01compat -work work +incdir+D:/ECE385/ECE385_FinalProject/db {D:/ECE385/ECE385_FinalProject/db/vga_clk_altpll.v}
vlib nios_system
vmap nios_system nios_system
vlog -vlog01compat -work nios_system +incdir+D:/ECE385/ECE385_FinalProject/nios_system/synthesis {D:/ECE385/ECE385_FinalProject/nios_system/synthesis/nios_system.v}
vlog -vlog01compat -work nios_system +incdir+D:/ECE385/ECE385_FinalProject/nios_system/synthesis/submodules {D:/ECE385/ECE385_FinalProject/nios_system/synthesis/submodules/altera_reset_controller.v}
vlog -vlog01compat -work nios_system +incdir+D:/ECE385/ECE385_FinalProject/nios_system/synthesis/submodules {D:/ECE385/ECE385_FinalProject/nios_system/synthesis/submodules/altera_reset_synchronizer.v}
vlog -vlog01compat -work nios_system +incdir+D:/ECE385/ECE385_FinalProject/nios_system/synthesis/submodules {D:/ECE385/ECE385_FinalProject/nios_system/synthesis/submodules/nios_system_mm_interconnect_0.v}
vlog -vlog01compat -work nios_system +incdir+D:/ECE385/ECE385_FinalProject/nios_system/synthesis/submodules {D:/ECE385/ECE385_FinalProject/nios_system/synthesis/submodules/nios_system_mm_interconnect_0_avalon_st_adapter.v}
vlog -vlog01compat -work nios_system +incdir+D:/ECE385/ECE385_FinalProject/nios_system/synthesis/submodules {D:/ECE385/ECE385_FinalProject/nios_system/synthesis/submodules/altera_avalon_sc_fifo.v}
vlog -vlog01compat -work nios_system +incdir+D:/ECE385/ECE385_FinalProject/nios_system/synthesis/submodules {D:/ECE385/ECE385_FinalProject/nios_system/synthesis/submodules/nios_system_sysid_qsys_0.v}
vlog -vlog01compat -work nios_system +incdir+D:/ECE385/ECE385_FinalProject/nios_system/synthesis/submodules {D:/ECE385/ECE385_FinalProject/nios_system/synthesis/submodules/nios_system_sdram_pll.v}
vlog -vlog01compat -work nios_system +incdir+D:/ECE385/ECE385_FinalProject/nios_system/synthesis/submodules {D:/ECE385/ECE385_FinalProject/nios_system/synthesis/submodules/nios_system_sdram.v}
vlog -vlog01compat -work nios_system +incdir+D:/ECE385/ECE385_FinalProject/nios_system/synthesis/submodules {D:/ECE385/ECE385_FinalProject/nios_system/synthesis/submodules/nios_system_otg_hpi_data.v}
vlog -vlog01compat -work nios_system +incdir+D:/ECE385/ECE385_FinalProject/nios_system/synthesis/submodules {D:/ECE385/ECE385_FinalProject/nios_system/synthesis/submodules/nios_system_otg_hpi_cs.v}
vlog -vlog01compat -work nios_system +incdir+D:/ECE385/ECE385_FinalProject/nios_system/synthesis/submodules {D:/ECE385/ECE385_FinalProject/nios_system/synthesis/submodules/nios_system_otg_hpi_address.v}
vlog -vlog01compat -work nios_system +incdir+D:/ECE385/ECE385_FinalProject/nios_system/synthesis/submodules {D:/ECE385/ECE385_FinalProject/nios_system/synthesis/submodules/nios_system_onchip_memory2_0.v}
vlog -vlog01compat -work nios_system +incdir+D:/ECE385/ECE385_FinalProject/nios_system/synthesis/submodules {D:/ECE385/ECE385_FinalProject/nios_system/synthesis/submodules/nios_system_nios2_gen2_0.v}
vlog -vlog01compat -work nios_system +incdir+D:/ECE385/ECE385_FinalProject/nios_system/synthesis/submodules {D:/ECE385/ECE385_FinalProject/nios_system/synthesis/submodules/nios_system_nios2_gen2_0_cpu.v}
vlog -vlog01compat -work nios_system +incdir+D:/ECE385/ECE385_FinalProject/nios_system/synthesis/submodules {D:/ECE385/ECE385_FinalProject/nios_system/synthesis/submodules/nios_system_nios2_gen2_0_cpu_debug_slave_sysclk.v}
vlog -vlog01compat -work nios_system +incdir+D:/ECE385/ECE385_FinalProject/nios_system/synthesis/submodules {D:/ECE385/ECE385_FinalProject/nios_system/synthesis/submodules/nios_system_nios2_gen2_0_cpu_debug_slave_tck.v}
vlog -vlog01compat -work nios_system +incdir+D:/ECE385/ECE385_FinalProject/nios_system/synthesis/submodules {D:/ECE385/ECE385_FinalProject/nios_system/synthesis/submodules/nios_system_nios2_gen2_0_cpu_debug_slave_wrapper.v}
vlog -vlog01compat -work nios_system +incdir+D:/ECE385/ECE385_FinalProject/nios_system/synthesis/submodules {D:/ECE385/ECE385_FinalProject/nios_system/synthesis/submodules/nios_system_nios2_gen2_0_cpu_test_bench.v}
vlog -vlog01compat -work nios_system +incdir+D:/ECE385/ECE385_FinalProject/nios_system/synthesis/submodules {D:/ECE385/ECE385_FinalProject/nios_system/synthesis/submodules/nios_system_keycode.v}
vlog -vlog01compat -work nios_system +incdir+D:/ECE385/ECE385_FinalProject/nios_system/synthesis/submodules {D:/ECE385/ECE385_FinalProject/nios_system/synthesis/submodules/nios_system_jtag_uart_0.v}
vlog -vlog01compat -work nios_system +incdir+D:/ECE385/ECE385_FinalProject/nios_system/synthesis/submodules {D:/ECE385/ECE385_FinalProject/nios_system/synthesis/submodules/nios_system_Player_1_X_Pos.v}
vlog -sv -work work +incdir+D:/ECE385/ECE385_FinalProject {D:/ECE385/ECE385_FinalProject/mouse_interface_IP.sv}
vlog -sv -work work +incdir+D:/ECE385/ECE385_FinalProject {D:/ECE385/ECE385_FinalProject/audio_control.sv}
vlog -sv -work work +incdir+D:/ECE385/ECE385_FinalProject {D:/ECE385/ECE385_FinalProject/tristate.sv}
vlog -sv -work work +incdir+D:/ECE385/ECE385_FinalProject {D:/ECE385/ECE385_FinalProject/Mem2IO.sv}
vlog -sv -work work +incdir+D:/ECE385/ECE385_FinalProject {D:/ECE385/ECE385_FinalProject/Reg_16.sv}
vlog -sv -work work +incdir+D:/ECE385/ECE385_FinalProject {D:/ECE385/ECE385_FinalProject/hpi_io_intf.sv}
vlog -sv -work work +incdir+D:/ECE385/ECE385_FinalProject {D:/ECE385/ECE385_FinalProject/VGA_controller.sv}
vlog -sv -work work +incdir+D:/ECE385/ECE385_FinalProject {D:/ECE385/ECE385_FinalProject/HexDriver.sv}
vlog -sv -work work +incdir+D:/ECE385/ECE385_FinalProject {D:/ECE385/ECE385_FinalProject/keycode_handler.sv}
vlog -sv -work work +incdir+D:/ECE385/ECE385_FinalProject {D:/ECE385/ECE385_FinalProject/title_palette.sv}
vlog -sv -work work +incdir+D:/ECE385/ECE385_FinalProject {D:/ECE385/ECE385_FinalProject/ram.sv}
vlog -sv -work nios_system +incdir+D:/ECE385/ECE385_FinalProject/nios_system/synthesis/submodules {D:/ECE385/ECE385_FinalProject/nios_system/synthesis/submodules/nios_system_irq_mapper.sv}
vlog -sv -work nios_system +incdir+D:/ECE385/ECE385_FinalProject/nios_system/synthesis/submodules {D:/ECE385/ECE385_FinalProject/nios_system/synthesis/submodules/nios_system_mm_interconnect_0_avalon_st_adapter_error_adapter_0.sv}
vlog -vlog01compat -work nios_system +incdir+D:/ECE385/ECE385_FinalProject/nios_system/synthesis/submodules {D:/ECE385/ECE385_FinalProject/nios_system/synthesis/submodules/altera_avalon_st_handshake_clock_crosser.v}
vlog -vlog01compat -work nios_system +incdir+D:/ECE385/ECE385_FinalProject/nios_system/synthesis/submodules {D:/ECE385/ECE385_FinalProject/nios_system/synthesis/submodules/altera_avalon_st_clock_crosser.v}
vlog -vlog01compat -work nios_system +incdir+D:/ECE385/ECE385_FinalProject/nios_system/synthesis/submodules {D:/ECE385/ECE385_FinalProject/nios_system/synthesis/submodules/altera_std_synchronizer_nocut.v}
vlog -sv -work nios_system +incdir+D:/ECE385/ECE385_FinalProject/nios_system/synthesis/submodules {D:/ECE385/ECE385_FinalProject/nios_system/synthesis/submodules/nios_system_mm_interconnect_0_rsp_mux_001.sv}
vlog -sv -work nios_system +incdir+D:/ECE385/ECE385_FinalProject/nios_system/synthesis/submodules {D:/ECE385/ECE385_FinalProject/nios_system/synthesis/submodules/altera_merlin_arbitrator.sv}
vlog -sv -work nios_system +incdir+D:/ECE385/ECE385_FinalProject/nios_system/synthesis/submodules {D:/ECE385/ECE385_FinalProject/nios_system/synthesis/submodules/nios_system_mm_interconnect_0_rsp_mux.sv}
vlog -sv -work nios_system +incdir+D:/ECE385/ECE385_FinalProject/nios_system/synthesis/submodules {D:/ECE385/ECE385_FinalProject/nios_system/synthesis/submodules/nios_system_mm_interconnect_0_rsp_demux_001.sv}
vlog -sv -work nios_system +incdir+D:/ECE385/ECE385_FinalProject/nios_system/synthesis/submodules {D:/ECE385/ECE385_FinalProject/nios_system/synthesis/submodules/nios_system_mm_interconnect_0_rsp_demux.sv}
vlog -sv -work nios_system +incdir+D:/ECE385/ECE385_FinalProject/nios_system/synthesis/submodules {D:/ECE385/ECE385_FinalProject/nios_system/synthesis/submodules/nios_system_mm_interconnect_0_cmd_mux_001.sv}
vlog -sv -work nios_system +incdir+D:/ECE385/ECE385_FinalProject/nios_system/synthesis/submodules {D:/ECE385/ECE385_FinalProject/nios_system/synthesis/submodules/nios_system_mm_interconnect_0_cmd_mux.sv}
vlog -sv -work nios_system +incdir+D:/ECE385/ECE385_FinalProject/nios_system/synthesis/submodules {D:/ECE385/ECE385_FinalProject/nios_system/synthesis/submodules/nios_system_mm_interconnect_0_cmd_demux_001.sv}
vlog -sv -work nios_system +incdir+D:/ECE385/ECE385_FinalProject/nios_system/synthesis/submodules {D:/ECE385/ECE385_FinalProject/nios_system/synthesis/submodules/nios_system_mm_interconnect_0_cmd_demux.sv}
vlog -sv -work nios_system +incdir+D:/ECE385/ECE385_FinalProject/nios_system/synthesis/submodules {D:/ECE385/ECE385_FinalProject/nios_system/synthesis/submodules/nios_system_mm_interconnect_0_router_003.sv}
vlog -sv -work nios_system +incdir+D:/ECE385/ECE385_FinalProject/nios_system/synthesis/submodules {D:/ECE385/ECE385_FinalProject/nios_system/synthesis/submodules/nios_system_mm_interconnect_0_router_002.sv}
vlog -sv -work nios_system +incdir+D:/ECE385/ECE385_FinalProject/nios_system/synthesis/submodules {D:/ECE385/ECE385_FinalProject/nios_system/synthesis/submodules/nios_system_mm_interconnect_0_router_001.sv}
vlog -sv -work nios_system +incdir+D:/ECE385/ECE385_FinalProject/nios_system/synthesis/submodules {D:/ECE385/ECE385_FinalProject/nios_system/synthesis/submodules/nios_system_mm_interconnect_0_router.sv}
vlog -sv -work nios_system +incdir+D:/ECE385/ECE385_FinalProject/nios_system/synthesis/submodules {D:/ECE385/ECE385_FinalProject/nios_system/synthesis/submodules/altera_merlin_slave_agent.sv}
vlog -sv -work nios_system +incdir+D:/ECE385/ECE385_FinalProject/nios_system/synthesis/submodules {D:/ECE385/ECE385_FinalProject/nios_system/synthesis/submodules/altera_merlin_burst_uncompressor.sv}
vlog -sv -work nios_system +incdir+D:/ECE385/ECE385_FinalProject/nios_system/synthesis/submodules {D:/ECE385/ECE385_FinalProject/nios_system/synthesis/submodules/altera_merlin_master_agent.sv}
vlog -sv -work nios_system +incdir+D:/ECE385/ECE385_FinalProject/nios_system/synthesis/submodules {D:/ECE385/ECE385_FinalProject/nios_system/synthesis/submodules/altera_merlin_slave_translator.sv}
vlog -sv -work nios_system +incdir+D:/ECE385/ECE385_FinalProject/nios_system/synthesis/submodules {D:/ECE385/ECE385_FinalProject/nios_system/synthesis/submodules/altera_merlin_master_translator.sv}
vlog -sv -work work +incdir+D:/ECE385/ECE385_FinalProject {D:/ECE385/ECE385_FinalProject/Color_Mapper.sv}
vlog -sv -work work +incdir+D:/ECE385/ECE385_FinalProject {D:/ECE385/ECE385_FinalProject/ball.sv}
vlog -sv -work work +incdir+D:/ECE385/ECE385_FinalProject {D:/ECE385/ECE385_FinalProject/grass.sv}
vlog -sv -work work +incdir+D:/ECE385/ECE385_FinalProject {D:/ECE385/ECE385_FinalProject/bomb.sv}
vlog -sv -work work +incdir+D:/ECE385/ECE385_FinalProject {D:/ECE385/ECE385_FinalProject/status.sv}
vlog -sv -work work +incdir+D:/ECE385/ECE385_FinalProject {D:/ECE385/ECE385_FinalProject/cursor.sv}
vlog -sv -work work +incdir+D:/ECE385/ECE385_FinalProject {D:/ECE385/ECE385_FinalProject/end.sv}
vlog -sv -work work +incdir+D:/ECE385/ECE385_FinalProject {D:/ECE385/ECE385_FinalProject/back_ground.sv}
vlog -sv -work work +incdir+D:/ECE385/ECE385_FinalProject {D:/ECE385/ECE385_FinalProject/lab8.sv}
vcom -93 -work work {D:/ECE385/ECE385_FinalProject/audio.vhd}

vlog -sv -work work +incdir+D:/ECE385/ECE385_FinalProject {D:/ECE385/ECE385_FinalProject/testbench.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -L nios_system -voptargs="+acc"  testbench

add wave *
view structure
view signals
run 10000 ns
