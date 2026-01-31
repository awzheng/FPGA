module LogicalStep_Lab2_top
(
	input			rst_n,		//reset in
	input			clkin_50,	//clock in
	input	[7:0]	sw,
	input	[3:0]	pb_n,

	output	[7:0]	leds,
	output	[6:0]	seg7_data,
	output			seg7_char1,
	output			seg7_char2
);

// Intermediate signals
	wire 	[3:0] hex_A, hex_B;
	wire	[6:0] seg7_A, seg7_B;
	wire 	[3:0] pb;
	
// Adder Output Wires
	wire	[3:0] sum_result;
	wire		  carry_out_bit;
	
// Wire assignments
	assign hex_A = sw[3:0];
	assign hex_B = sw[7:4];

	
// --- CHANGED SECTION START ---

    // Instance u1: Drives Digit 1 (Right). Now displays the SUM.
	SevenSegment u1 (
		.hex	  (sum_result),      // Changed from hex_A to sum_result
		.sevenseg (seg7_A)
	);

    // Instance u2: Drives Digit 2 (Left). Now displays the CARRY.
    // Uses concatenation {000, carry} to turn 1-bit carry into 4-bit input
	SevenSegment u2 (
		.hex	  ({3'b000, carry_out_bit}), // Changed from hex_B to concatenation
		.sevenseg (seg7_B)
	);

// --- CHANGED SECTION END ---


	segment7_mux u3 (
		.clk  (clkin_50),
		.din2 (seg7_A), 
		.din1 (seg7_B),
		.dout (seg7_data),
		.dig2 (seg7_char2), 
		.dig1 (seg7_char1)
	);
	
	pb_inverters u4 (
		.pbin  (pb_n),
		.pbout (pb)	
	);
	
	mux_4bit_2_to_1 u5 (
		.din_A    (hex_A),
		.din_B    (hex_B),
		.selector (pb[1:0]), 
		.dout     (leds[3:0])
	);

	full_adder_4bit u6 (
		.BUS0      (hex_A),        
		.BUS1      (hex_B),         
		.carry_in  (1'b0),          
		.SUM       (sum_result),    
		.carry_out (carry_out_bit)  
	);

endmodule