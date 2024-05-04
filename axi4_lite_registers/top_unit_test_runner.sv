module top_unit_test_runner;
    logic test_passed = 0;

    import svunit_pkg::svunit_testrunner;
    import svunit_pkg::svunit_testsuite;

    svunit_testrunner svunit_tr;
    svunit_testsuite svunit_ts;

    top_unit_test ut();

    initial begin
        build();
        run();

        unique case (svunit_tr.get_results())
            svunit_pkg::PASS: begin
                test_passed = 1;
                $finish;
            end
            svunit_pkg::FAIL: begin
                test_passed = 0;
                $fatal(1);
            end
        endcase
    end

    function void build();
        svunit_tr = new ("testrunner");
        svunit_ts = new ("testsuite");

        ut.build();
        svunit_ts.add_testcase(ut.svunit_ut);
        svunit_tr.add_testsuite(svunit_ts);
    endfunction

    task run();
        svunit_ts.run();
        ut.run();
        svunit_ts.report();
        svunit_tr.report();
    endtask
endmodule