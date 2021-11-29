`include "tap.v"

module tb;

  reg tclk  ;
  reg tms   ;
  reg trst  ;

  wire test_logic_reset ;
  wire run_test_idle    ;
  wire select_dr_scan   ;
  wire capture_dr       ;
  wire shift_dr         ;
  wire exit1_dr         ;
  wire pause_dr         ;
  wire exit2_dr         ;
  wire update_dr        ;
  wire select_ir_scan   ;
  wire capture_ir       ;
  wire shift_ir         ;
  wire exit1_ir         ;
  wire pause_ir         ;
  wire exit2_ir         ;
  wire update_ir        ;


  tap dut(
    .tclk (tclk),
    .tms  (tms),
    .trst (trst),

    .test_logic_reset (test_logic_reset),
    .run_test_idle    (run_test_idle),
    .select_dr_scan   (select_dr_scan),
    .capture_dr       (capture_dr),
    .shift_dr         (shift_dr),
    .exit1_dr         (exit1_dr),
    .pause_dr         (pause_dr),
    .exit2_dr         (exit2_dr),
    .update_dr        (update_dr),
    .select_ir_scan   (select_ir_scan),
    .capture_ir       (capture_ir),
    .shift_ir         (shift_ir),
    .exit1_ir         (exit1_ir),
    .pause_ir         (pause_ir),
    .exit2_ir         (exit2_ir),
    .update_ir        (update_ir)
  );

  integer i;

  initial begin
    $dumpfile("test.vcd");
    $dumpvars(0, tb);
    {trst,tms,tclk} = 0;

    for (i=0;i<8;i++) begin
      #10;
      {trst,tms,tclk} = {trst,tms,tclk} + 1;
    end
  end

  initial
    $monitor("tclk=%b, tms=%b, trst=%b, test_logic_reset=%b, run_test_idle=%b, select_dr_scan=%b, capture_dr=%b, shift_dr=%b, exit1_dr=%b, pause_dr=%b, exit2_dr=%b, update_dr=%b, select_ir_scan=%b, capture_ir=%b, shift_ir=%b, exit1_ir=%b, pause_ir=%b,  exit2_ir=%b, update_ir=%b",tclk, tms, trst, test_logic_reset, run_test_idle, select_dr_scan, capture_dr, shift_dr, exit1_dr, pause_dr, exit2_dr,  update_dr, select_ir_scan, capture_ir, shift_ir, exit1_ir, pause_ir, exit2_ir, update_ir);
endmodule



