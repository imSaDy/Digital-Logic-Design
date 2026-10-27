# Digital Logic Design

My assignments for the Digital Logic Design course taught by Prof. Bijan Alizadeh at the University of Tehran, Fall 2024. All designs are in SystemVerilog and were simulated in ModelSim. Each folder has the assignment statement (in Persian), the code with testbenches, and my report.

| Folder | Assignment | What I did |
| --- | --- | --- |
| [CA1](CA1/DLD_CA1_810102588) | Seven-segment decoder | A BCD to seven-segment decoder written twice: once from logic gates and once with Boolean expressions, with a testbench for each. |
| [CA2](CA2/DLD_CA2_Code) | ALU | A 4-bit ALU that adds, subtracts, and finds the minimum or maximum of two numbers, chosen by a 3-bit opcode. It is built from combinational blocks: a carry-lookahead adder, a comparator, and one-hot encoders and decoders. The result is shown on a seven-segment display. |
| [CA3](CA3/DLD_CA3_Code) | Pseudo-random number generator | Builds up from a D latch to a master-slave flip-flop and a shift register, then uses these to make an 80-bit LFSR and a 24-bit NFSR. The two are combined into a Grain-style generator. |
| [CA4](CA4/DLD_CA4_Code) | Determinant calculator | Sequential circuits that compute the determinant of a 2×2 and a 3×3 matrix read from a ROM, each split into a datapath and a controller. `det.cpp` computes the expected values for checking. |

The `work` folders, `.wlf` files and `wlft*` files are ModelSim simulation output.
