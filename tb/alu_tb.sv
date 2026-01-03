`timescale 1ns/1ps

module alu_tb;

    // -------------------------
    // DUT signals
    // -------------------------
    logic        r_type;
    logic        i_type;
    logic [2:0]  funct3;
    logic [6:0]  funct7;
    logic [12:0] imm12_i_s;

    logic        op_jalr;
    logic        op_intRegImm;
    logic        op_consShf;
    logic        op_intRegReg;

    logic [31:0] A;
    logic [31:0] B;
    logic [31:0] out;
    logic        flag;

    // -------------------------
    // Reference / counters
    // -------------------------
    logic [32:0] exp_out;

    int test_cnt  = 0;
    int pass_cnt  = 0;
    int fail_cnt  = 0;

    // -------------------------
    // DUT instantiation
    // -------------------------
    ALU32bits dut (
        .r_type(r_type),
        .i_type(i_type),
        .funct3(funct3),
        .funct7(funct7),
        .A(A),
        .B(B),
        .out(out),
        .flag(flag)
    );

    // -------------------------
    // Task: run one test
    // -------------------------
    task run_test(
        input logic [3:0] wfunct,
        input string      name
    );
        begin
            test_cnt++;

            // Decode wfunct → funct3/funct7/r_type
            r_type  = wfunct[0]; // dummy default
            funct3  = wfunct[3:1];
            funct7  = (wfunct[0]) ? 7'b0100000 : 7'b0000000;
            r_type  = 1'b1;

            // Random operands
            A = $random;
            B = $random;

            // -------------------------
            // Golden reference
            // -------------------------
            case (wfunct)
                4'b0000: exp_out = {1'b0,A} + {1'b0,B};               // ADD
                4'b0001: exp_out = {1'b0,A} - {1'b0,B};               // SUB
                4'b0010: exp_out = {1'b0,A << B[4:0]};                // SLL
                4'b0100: exp_out = {1'b0,($signed(A) < $signed(B))};  // SLT
                4'b0110: exp_out = {1'b0,(A < B)};                    // SLTU
                4'b1000: exp_out = {1'b0,A ^ B};                      // XOR
                4'b1010: exp_out = {1'b0,A >> B[4:0]};                // SRL
                4'b1011: exp_out = {1'b0,$signed(A) >>> B[4:0]};      // SRA
                4'b1100: exp_out = {1'b0,A | B};                      // OR
                4'b1110: exp_out = {1'b0,A & B};                      // AND
                default: exp_out = 33'b0;
            endcase

            #1; // allow combinational settle

            // -------------------------
            // Display
            // -------------------------
            $display("--------------------------------------------------------------------");
            $display("TEST %0d : %s", test_cnt, name);
            $display("A = 0x%08h  B = 0x%08h", A, B);
            $display("EXP = {flag=%0b, out=0x%08h}", exp_out[32], exp_out[31:0]);
            $display("DUT = {flag=%0b, out=0x%08h}", flag, out);

            if ({flag,out} === exp_out) begin
                $display("RESULT : PASS ✅");
                pass_cnt++;
            end else begin
                $display("RESULT : FAIL ❌");
                fail_cnt++;
            end
        end
    endtask

    // -------------------------
    // Test sequence
    // -------------------------
    initial begin
        // default inputs
        r_type        = 1'b1;
        i_type        = 1'b0;
        funct3        = 3'b0;
        funct7        = 7'b0;
        imm12_i_s     = 13'b0;
        op_jalr       = 1'b0;
        op_intRegImm  = 1'b0;
        op_consShf    = 1'b0;
        op_intRegReg  = 1'b1;

        $display("\n========== ALU32bits TEST START ==========\n");

        run_test(4'b0000, "ADD");
        run_test(4'b0001, "SUB");
        run_test(4'b0010, "SLL");
        run_test(4'b0100, "SLT");
        run_test(4'b0110, "SLTU");
        run_test(4'b1000, "XOR");
        run_test(4'b1010, "SRL");
        run_test(4'b1011, "SRA");
        run_test(4'b1100, "OR");
        run_test(4'b1110, "AND");

        // -------------------------
        // Summary
        // -------------------------
        $display("\n========== TEST SUMMARY ==========");
        $display("TOTAL : %0d", test_cnt);
        $display("PASS  : %0d", pass_cnt);
        $display("FAIL  : %0d", fail_cnt);
        $display("==================================\n");

        $finish;
    end

endmodule
