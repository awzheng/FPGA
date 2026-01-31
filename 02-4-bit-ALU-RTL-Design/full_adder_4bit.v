module full_adder_4bit (
    input [3:0] BUS0,      // Represents BUS0_b0 through BUS0_b3
    input [3:0] BUS1,      // Represents BUS1_b0 through BUS1_b3
    input carry_in,        // The Carry_In signal for the LSB
    output [3:0] SUM,      // The 4-bit Sum output
    output carry_out       // The final Carry_Out3
);

    // Internal wires for the daisy-chained carry signals
    // These correspond to Carry_Out0, Carry_Out1, Carry_Out2 in the diagram
    wire c0, c1, c2;

    // Instance 0: LSB (Bit 0)
    // Connects BUS0[0], BUS1[0] and the initial carry_in
    full_adder_1bit FA0 (
        .input_A(BUS0[0]),
        .input_B(BUS1[0]),
        .carry_in(carry_in), 
        .carry_out(c0),
        .sum_out(SUM[0])
    );

    // Instance 1: Bit 1
    // Connects BUS0[1], BUS1[1] and the carry from previous stage (c0)
    full_adder_1bit FA1 (
        .input_A(BUS0[1]),
        .input_B(BUS1[1]),
        .carry_in(c0),
        .carry_out(c1),
        .sum_out(SUM[1])
    );

    // Instance 2: Bit 2
    // Connects BUS0[2], BUS1[2] and the carry from previous stage (c1)
    full_adder_1bit FA2 (
        .input_A(BUS0[2]),
        .input_B(BUS1[2]),
        .carry_in(c1),
        .carry_out(c2),
        .sum_out(SUM[2])
    );

    // Instance 3: MSB (Bit 3)
    // Connects BUS0[3], BUS1[3] and the carry from previous stage (c2)
    // Outputs the final carry_out
    full_adder_1bit FA3 (
        .input_A(BUS0[3]),
        .input_B(BUS1[3]),
        .carry_in(c2),
        .carry_out(carry_out),
        .sum_out(SUM[3])
    );
	 
endmodule 
