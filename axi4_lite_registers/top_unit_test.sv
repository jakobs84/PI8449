`timescale 1 ns / 1 ns

`include "svunit_defines.svh"

module top_unit_test;
    import svunit_pkg::svunit_testcase;
    import unit_test_pkg::*;
    import registers_pkg::*;
    import axi4_lite_pkg::*;

    string name = "top_unit_test";
    svunit_testcase svunit_ut;

    parameter TDATA_BYTES   = 4;
    parameter ADDRESS_WIDTH = 21;

    typedef struct {
        bit [ADDRESS_WIDTH-1:0] address;
        bit [TDATA_BYTES-1:0][7:0] data;
        bit [3:0] byte_enable;
        axi4_lite_pkg::access_t access;
        axi4_lite_pkg::response_t response;
    } request_t;
/*
    function axi4_lite_pkg::access_t random_access();
        return axi4_lite_pkg::access_t'($urandom % $bits(axi4_lite_pkg::access_t));
    endfunction

    function axi4_lite_pkg::response_t random_response();
        return axi4_lite_pkg::response_t'($urandom % $bits(axi4_lite_pkg::response_t));
    endfunction
*/
    localparam real TIME_BASE = 1000.0;
    localparam real CLOCK_100 = (TIME_BASE / 100.00); //100MHz

    logic reset_n    = 1'b0;
    logic clk_100mhz = 0;

    initial forever #(CLOCK_100/2) clk_100mhz = ~clk_100mhz;

    // ----------------------------------
    // ------ Interfaces & Drivers ------
    // ----------------------------------

    axi4_lite_if #(
        .DATA_BYTES     (TDATA_BYTES),
        .ADDRESS_WIDTH  (ADDRESS_WIDTH)
    ) axi_lite_slave (
        .aclk           (clk_100mhz),
        .areset_n       (reset_n)
    );

    axi4_lite_driver_slave #(
        .DATA_BYTES     (TDATA_BYTES),
        .ADDRESS_WIDTH  (ADDRESS_WIDTH)
    ) axi4_slave_drv = new (axi_lite_slave);

    // ----------------------------------
    // ------- DUT initialization -------
    // ----------------------------------
    
    logic [ 7:0] LED;

    logic        s_axil_awready;
    logic        s_axil_awvalid;
    logic [20:0] s_axil_awaddr;
    logic [ 2:0] s_axil_awprot;

    logic        s_axil_wready;
    logic        s_axil_wvalid;
    logic [31:0] s_axil_wdata;
    logic [ 3:0] s_axil_wstrb;

    logic        s_axil_bready;
    logic        s_axil_bvalid;
    logic [ 1:0] s_axil_bresp;

    logic        s_axil_arready;
    logic        s_axil_arvalid;
    logic [20:0] s_axil_araddr;
    logic [ 2:0] s_axil_arprot;

    logic        s_axil_rready;
    logic        s_axil_rvalid;
    logic [31:0] s_axil_rdata;
    logic [ 1:0] s_axil_rresp;

    assign axi_lite_slave.awready = s_axil_awready;
    assign s_axil_awvalid = axi_lite_slave.awvalid;
    assign s_axil_awaddr  = axi_lite_slave.awaddr;
    assign s_axil_awprot  = axi_lite_slave.awprot;

    assign axi_lite_slave.wready = s_axil_wready;
    assign s_axil_wvalid = axi_lite_slave.wvalid;
    assign s_axil_wdata  = axi_lite_slave.wdata;
    assign s_axil_wstrb  = axi_lite_slave.wstrb;

    assign s_axil_bready = axi_lite_slave.bready;
    assign axi_lite_slave.bvalid = s_axil_bvalid;
    assign axi_lite_slave.bresp  = s_axil_bresp;

    assign axi_lite_slave.arready = s_axil_arready;
    assign s_axil_arvalid = axi_lite_slave.arvalid;
    assign s_axil_araddr  = axi_lite_slave.araddr;
    assign s_axil_arprot  = axi_lite_slave.arprot;

    assign s_axil_rready = axi_lite_slave.rready;
    assign axi_lite_slave.rvalid = s_axil_rvalid;
    assign axi_lite_slave.rdata  = s_axil_rdata;
    assign axi_lite_slave.rresp  = s_axil_rresp;


    modul_studenta dut (
        .rst             ( ~reset_n       ),
        .clk             ( clk_100mhz     ),
    
        .s_axil_awready  ( s_axil_awready ),
        .s_axil_awvalid  ( s_axil_awvalid ),
        .s_axil_awaddr   ( s_axil_awaddr  ),
        .s_axil_awprot   ( s_axil_awprot  ),
        .s_axil_wready   ( s_axil_wready  ),
        .s_axil_wvalid   ( s_axil_wvalid  ),
        .s_axil_wdata    ( s_axil_wdata   ),
        .s_axil_wstrb    ( s_axil_wstrb   ),
        .s_axil_bready   ( s_axil_bready  ),
        .s_axil_bvalid   ( s_axil_bvalid  ),
        .s_axil_bresp    ( s_axil_bresp   ),
        .s_axil_arready  ( s_axil_arready ),
        .s_axil_arvalid  ( s_axil_arvalid ),
        .s_axil_araddr   ( s_axil_araddr  ),
        .s_axil_arprot   ( s_axil_arprot  ),
        .s_axil_rready   ( s_axil_rready  ),
        .s_axil_rvalid   ( s_axil_rvalid  ),
        .s_axil_rdata    ( s_axil_rdata   ),
        .s_axil_rresp    ( s_axil_rresp   ),
    
        .LED             ( LED            )
    );

    int counter_led;
    int led_delay;
    bit led_ff;

    // initial begin
    //     counter_led = 0;
    //     led_delay = 0;

    //     forever begin
    //         led_ff = LED[0];
    //         @(posedge clk_100mhz);
    //         if (led_ff == 1'b0 && LED[0] == 1'b1) begin
    //             led_delay = counter_led;
    //             counter_led = 0;
    //         end

    //        counter_led++;
    //     end
    // end

    function void build();
        svunit_ut = new(name);
    endfunction

    task setup();
        svunit_ut.setup();
        reset_n = 1'b0;
        #120;
        axi4_slave_drv.aclk_posedge();
        axi4_slave_drv.reset();

        @(posedge clk_100mhz);
        reset_n = 1'b1;

        axi4_slave_drv.aclk_posedge();
    endtask

    task teardown();
        svunit_ut.teardown();
        reset_n = 1'b0;
        axi4_slave_drv.reset();
    endtask

`SVUNIT_TESTS_BEGIN

    `SVTEST(simple_write)
        request_t request;
        axi4_lite_pkg::response_t expected_response = RESPONSE_OKAY;
        

        //zapisujemy LED ENABLE
        request.data[0] = 8'h00;
        request.data[1] = 8'h01;
        request.data[2] = 8'h00;
        request.data[3] = 8'h00;
        request.address = 21'h0000_0004;
        request.byte_enable = 4'b0010;
        request.access = axi4_lite_pkg::DEFAULT_DATA_ACCESS;

        axi4_slave_drv.aclk_posedge();
        axi4_slave_drv.write_request_address(request.address);

        axi4_slave_drv.aclk_posedge(3);
        axi4_slave_drv.write_request_data(request.data, request.byte_enable);

        axi4_slave_drv.write_response(request.response);
        `FAIL_UNLESS_EQUAL(expected_response, request.response);
        #300;
        `FAIL_UNLESS_EQUAL(dut.hwif_out.LEDS.LED_ENABLE.value, 1'b1);


        #300;

       //zapusujemy wawrtosci LED
        request.data[0] = 8'h11;
        request.data[1] = 8'h00;
        request.data[2] = 8'h00;
        request.data[3] = 8'h00;
        request.address = 21'h0000_0004;
        request.byte_enable = 4'b0001;
        request.access = axi4_lite_pkg::DEFAULT_DATA_ACCESS;

        axi4_slave_drv.aclk_posedge();
        axi4_slave_drv.write_request_address(request.address);

        axi4_slave_drv.aclk_posedge(1);
        axi4_slave_drv.write_request_data(request.data, request.byte_enable);

        axi4_slave_drv.write_response(request.response);
        `FAIL_UNLESS_EQUAL(expected_response, request.response);
        #300;
        `FAIL_UNLESS_EQUAL(dut.hwif_out.LEDS.LED.value, 8'h11);

  
        #100;


        request.address = 21'h0000_0000;
        request.access = axi4_lite_pkg::DEFAULT_DATA_ACCESS;

        fork
            begin
                axi4_slave_drv.read_request(request.address, request.access);
            end
            begin
                request_t captured;

                axi4_slave_drv.read_response(captured.data, captured.response);
                
                $display("Captured data = %0h", captured.data );

                `FAIL_UNLESS_EQUAL(expected_response, captured.response)
                `FAIL_UNLESS_EQUAL(captured.data, 32'hABCD_1234)
            end
        join

        #100;
  


        // request.data[0] = 8'h01;
        // request.data[1] = 8'h00;
        // request.data[2] = 8'h00;
        // request.data[3] = 8'h00;
        // request.address = 21'h0000_0008;
        // request.byte_enable = 4'b0001;
        // request.access = axi4_lite_pkg::DEFAULT_DATA_ACCESS;

        // axi4_slave_drv.aclk_posedge();
        // axi4_slave_drv.write_request_address(request.address);

        // axi4_slave_drv.aclk_posedge(3);
        // axi4_slave_drv.write_request_data(request.data, request.byte_enable);

        // axi4_slave_drv.write_response(request.response);
        // `FAIL_UNLESS_EQUAL(expected_response, request.response);
        // #300;
        // `FAIL_UNLESS_EQUAL(dut.hwif_out.FSM.ENABLE.value, 32'h1);

        // #300;
        // `FAIL_UNLESS_EQUAL(led_delay, 8);

        // #1000;

        // //-------------------------------------------------------------------------------
        // request.data[0] = 8'h12;
        // request.data[1] = 8'h00;
        // request.data[2] = 8'h00;
        // request.data[3] = 8'h00;
        // request.address = 21'h0000_000C;
        // request.byte_enable = 4'b1111;

        // axi4_slave_drv.aclk_posedge();
        // axi4_slave_drv.write_request_address(request.address);

        // axi4_slave_drv.aclk_posedge(3);
        // axi4_slave_drv.write_request_data(request.data, request.byte_enable);

        // axi4_slave_drv.write_response(request.response);
        // `FAIL_UNLESS_EQUAL(expected_response, request.response);

        // #300;
        // `FAIL_UNLESS_EQUAL(dut.hwif_out.COUNTER_VALUE.VALUE.value, request.data[0]);

        // #3000;
        // $display("led_delay = %0d", led_delay);
        // `FAIL_UNLESS_EQUAL(led_delay, 8*(request.data[0]+1));

        // //-------------------------------------------------------------------------------
        // request.data[0] = 8'h05;
        // request.data[1] = 8'h00;
        // request.data[2] = 8'h00;
        // request.data[3] = 8'h00;
        // request.address = 21'h0000_000C;
        // request.byte_enable = 4'b1111;

        // axi4_slave_drv.aclk_posedge();
        // axi4_slave_drv.write_request_address(request.address);

        // axi4_slave_drv.aclk_posedge(3);
        // axi4_slave_drv.write_request_data(request.data, request.byte_enable);

        // axi4_slave_drv.write_response(request.response);
        // `FAIL_UNLESS_EQUAL(expected_response, request.response);

        // #300;
        // `FAIL_UNLESS_EQUAL(dut.hwif_out.COUNTER_VALUE.VALUE.value, request.data[0]);

        // #3000;
        // $display("led_delay = %0d", led_delay);
        // `FAIL_UNLESS_EQUAL(led_delay, 8*(request.data[0]+1));
        
        //wait(1'b0);
    `SVTEST_END
`SVUNIT_TESTS_END

endmodule