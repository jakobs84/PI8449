transcript on

vlib work
vmap work

vlog -sv -work work {./rdl/registers_pkg.sv}
vlog -sv -work work {./rdl/registers.sv}

vlog -sv -work work {./axi_lite/axi4_lite_pkg.sv}
vlog -sv -work work {./axi_lite/axi4_lite_if.sv}

vlog -sv -work work +incdir+./axi_lite {./axi_lite/unit_test_pkg.sv}

vlog -sv -work work +incdir+./svunit_base {./svunit_base/svunit_pkg.sv}

vlog -sv -work work +incdir+./svunit_base {./top_unit_test.sv}

vlog -sv -work work +incdir+./svunit_base {./top_unit_test_runner.sv}

vlog -sv -work work {../modul_studenta.sv}

vsim -suppress 12003,8386,8440 -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L fiftyfivenm_ver -L work -sv_seed random -voptargs="+acc" top_unit_test_runner

add wave -position insertpoint  \
sim:/top_unit_test_runner/ut/dut/clk \
sim:/top_unit_test_runner/ut/dut/rst \
sim:/top_unit_test_runner/ut/dut/s_axil_awready \
sim:/top_unit_test_runner/ut/dut/s_axil_awvalid \
sim:/top_unit_test_runner/ut/dut/s_axil_awaddr \
sim:/top_unit_test_runner/ut/dut/s_axil_awprot \
sim:/top_unit_test_runner/ut/dut/s_axil_wready \
sim:/top_unit_test_runner/ut/dut/s_axil_wvalid \
sim:/top_unit_test_runner/ut/dut/s_axil_wdata \
sim:/top_unit_test_runner/ut/dut/s_axil_wstrb \
sim:/top_unit_test_runner/ut/dut/s_axil_bready \
sim:/top_unit_test_runner/ut/dut/s_axil_bvalid \
sim:/top_unit_test_runner/ut/dut/s_axil_bresp \
sim:/top_unit_test_runner/ut/dut/s_axil_arready \
sim:/top_unit_test_runner/ut/dut/s_axil_arvalid \
sim:/top_unit_test_runner/ut/dut/s_axil_araddr \
sim:/top_unit_test_runner/ut/dut/s_axil_arprot \
sim:/top_unit_test_runner/ut/dut/s_axil_rready \
sim:/top_unit_test_runner/ut/dut/s_axil_rvalid \
sim:/top_unit_test_runner/ut/dut/s_axil_rdata \
sim:/top_unit_test_runner/ut/dut/s_axil_rresp \
sim:/top_unit_test_runner/ut/dut/hwif_out \
sim:/top_unit_test_runner/ut/dut/LED \
sim:/top_unit_test_runner/ut/counter_led \
sim:/top_unit_test_runner/ut/led_delay \
sim:/top_unit_test_runner/ut/dut/LED[4] \
sim:/top_unit_test_runner/ut/dut/LED[0]


view structure
view signals
run -all