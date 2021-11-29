module tap
(
  input tclk,
  input tms,
  input trst,

  output reg test_logic_reset,
  output reg run_test_idle,
  output reg select_dr_scan,
  output reg capture_dr,
  output reg shift_dr,
  output reg exit1_dr,
  output reg pause_dr,
  output reg exit2_dr,
  output reg update_dr,
  output reg select_ir_scan,
  output reg capture_ir,
  output reg shift_ir,
  output reg exit1_ir,
  output reg pause_ir,
  output reg exit2_ir,
  output reg update_ir
);

// Defining 4 bit values for the states
`define state_test_logic_reset 4'h0
`define state_run_test_idle    4'h1
`define state_select_dr_scan   4'h2
`define state_capture_dr       4'h3
`define state_shift_dr         4'h4
`define state_exit1_dr         4'h5
`define state_pause_dr         4'h6
`define state_exit2_dr         4'h7
`define state_update_dr        4'h8
`define state_select_ir_scan   4'h9
`define state_capture_ir       4'hA
`define state_shift_ir         4'hB
`define state_exit1_ir         4'hC
`define state_pause_ir         4'hD
`define state_exit2_ir         4'hE
`define state_update_ir        4'hF


// Taking 4 bit rehister to store the 16 states
reg [3:0] state = `state_test_logic_reset;
reg [3:0] next_state;

// Sequential
always @ (posedge tclk or negedge trst)
begin
	if(trst == 0)
		state = `state_test_logic_reset;
	else
		state = next_state;
end

//FSM
always @ (state or tms)
begin
  case(state)
		`state_test_logic_reset:
			begin
			if(tms) next_state = `state_test_logic_reset; 
			else next_state = `state_run_test_idle;
			end
		`state_run_test_idle:
			begin
			if(tms) next_state = `state_select_dr_scan; 
			else next_state = `state_run_test_idle;
			end
		`state_select_dr_scan:
			begin
			if(tms) next_state = `state_select_ir_scan; 
			else next_state = `state_capture_dr;
			end
		`state_capture_dr:
			begin
			if(tms) next_state = `state_exit1_dr; 
			else next_state = `state_shift_dr;
			end
		`state_shift_dr:
			begin
			if(tms) next_state = `state_exit1_dr; 
			else next_state = `state_shift_dr;
			end
		`state_exit1_dr:
			begin
			if(tms) next_state = `state_update_dr; 
			else next_state = `state_pause_dr;
			end
		`state_pause_dr:
			begin
			if(tms) next_state = `state_exit2_dr; 
			else next_state = `state_pause_dr;
			end
		`state_exit2_dr:
			begin
			if(tms) next_state = `state_update_dr; 
			else next_state = `state_shift_dr;
			end
		`state_update_dr:
			begin
			if(tms) next_state = `state_select_dr_scan; 
			else next_state = `state_run_test_idle;
			end
		`state_select_ir_scan:
			begin
			if(tms) next_state = `state_test_logic_reset;
			else next_state = `state_capture_ir;
			end
		`state_capture_ir:
			begin
			if(tms) next_state = `state_exit1_ir; 
			else next_state = `state_shift_ir;
			end
		`state_shift_ir:
			begin
			if(tms) next_state = `state_exit1_ir; 
			else next_state = `state_shift_ir;
			end
		`state_exit1_ir:
			begin
			if(tms) next_state = `state_update_ir;
			else next_state = `state_pause_ir;
			end
		`state_pause_ir:
			begin
			if(tms) next_state = `state_exit2_ir;
			else next_state = `state_pause_ir;
			end
		`state_exit2_ir:
			begin
			if(tms) next_state = `state_update_ir;
			else next_state = `state_shift_ir;
			end
		`state_update_ir:
			begin
			if(tms) next_state = `state_select_dr_scan;
			else next_state = `state_run_test_idle;
			end
		default: next_state = `state_test_logic_reset;
	endcase
end

//Output of controller
always @ (state)
begin
  //reset all output state values to 0
  	test_logic_reset = 1'b0;
	run_test_idle = 1'b0;
	select_dr_scan = 1'b0;
	capture_dr = 1'b0;
	shift_dr = 1'b0;
	exit1_dr = 1'b0;
	pause_dr = 1'b0;
	exit2_dr = 1'b0;
	update_dr = 1'b0;
	select_ir_scan = 1'b0;
	capture_ir = 1'b0;
	shift_ir = 1'b0;
	exit1_ir = 1'b0;
	pause_ir = 1'b0;
	exit2_ir = 1'b0;
	update_ir = 1'b0;

  //update output state value depending on current state
  case(state)
		`state_test_logic_reset: test_logic_reset = 1'b1;
		`state_run_test_idle:    run_test_idle = 1'b1;
		`state_select_dr_scan:   select_dr_scan = 1'b1;
		`state_capture_dr:       capture_dr = 1'b1;
		`state_shift_dr:         shift_dr = 1'b1;
		`state_exit1_dr:         exit1_dr = 1'b1;
		`state_pause_dr:         pause_dr = 1'b1;
		`state_exit2_dr:         exit2_dr = 1'b1;
		`state_update_dr:        update_dr = 1'b1;
		`state_select_ir_scan:   select_ir_scan = 1'b1;
		`state_capture_ir:       capture_ir = 1'b1;
		`state_shift_ir:         shift_ir = 1'b1;
		`state_exit1_ir:         exit1_ir = 1'b1;
		`state_pause_ir:         pause_ir = 1'b1;
		`state_exit2_ir:         exit2_ir = 1'b1;
		`state_update_ir:        update_ir = 1'b1;
		default: ;
	endcase
end
endmodule