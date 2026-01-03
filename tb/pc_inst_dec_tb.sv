`timescale 1ns/1ps

module pc_inst_dec_tb ();

parameter CLK_PERIOD = 10;

//Wire
    logic            clk;
    logic            rstB;
    logic           clkEn;
    wire[13:0]      pc;
    logic[31:0]      instruction_in;

    wire[6:0]   Op_code;
    wire        r_type;
    wire        i_type;
    wire        s_type;
    wire        b_type;
    wire        j_type;
    wire        u_type;

    wire[2:0]   funct3;
    wire[6:0]   funct7;
    wire[4:0]   reg_d;
    wire[4:0]   reg_s1;
    wire[4:0]   reg_s2;

    wire[12:0]  imm13_b;
    wire[11:0]  imm12_i_s;
    wire[31:0]  imm32_u;
    wire[20:0]  imm21_j;

    wire        op_lui;
    wire        op_auipc;
    wire        op_jal;
    wire        op_jalr;
    wire        op_branch;
    wire        op_memLd;
    wire        op_intRegImm;
    wire        op_memSt;
    wire        op_consShf;
    wire        op_intRegReg;
    wire        op_efence;
    wire        op_ecb;

//Testbench signal
   

//Module Declaration
    pc_reg rpc(
        .clk(clk),
        .rstB(rstB),
        .clkEn(clkEn),

        .pc_out(pc)
    );

    inst_dec dut (       
        .instruction_in(instruction_in),

        .Op_code(Op_code),
        .r_type(r_type),
        .i_type(i_type),
        .s_type(s_type),
        .b_type(b_type),
        .j_type(j_type),
        .u_type(u_type),

        .funct3(funct3),
        .funct7(funct7),

        .reg_d(reg_d),
        .reg_s1(reg_s1),
        .reg_s2(reg_s2),

        .imm13_b(imm13_b),
        .imm12_i_s(imm12_i_s),
        .imm32_u(imm32_u),
        .imm21_j(imm21_j),

        .op_lui(op_lui),
        .op_auipc(op_auipc),
        .op_jal(op_jal),
        .op_jalr(op_jalr),
        .op_branch(op_branch),
        .op_memLd(op_memLd),
        .op_intRegImm(op_intRegImm),
        .op_memSt(op_memSt),
        .op_consShf(op_consShf),
        .op_intRegReg(op_intRegReg),
        .op_efence(op_efence),
        .op_ecb(op_ecb)
    );
    

//Task
    always 
    begin : clock
      #(CLK_PERIOD / 2) 
      clk = 0;
      #(CLK_PERIOD / 2) 
      clk = 1;
    end

    task init;
    begin
        clkEn = 0;
        rstB = 0;
        #(2 * CLK_PERIOD);
        rstB = 1;
        clkEn = 1;
        #(2 * CLK_PERIOD);
    end
    endtask

    logic [6:0] Exp_op = 0;
    logic [4:0] Exp_rd = 0;
    logic [4:0] Exp_rs1 = 0;
    logic [4:0] Exp_rs2 = 0;
    logic [2:0] Exp_funct3 = 0;
    logic [6:0] Exp_funct7 = 0;

    int wrong_cnt = 0;

//Automate Task
    task automatic rand_regs(
        output logic [4:0] rd,
        output logic [4:0] rs1,
        output logic [4:0] rs2
    );
        rd  = $random % 32;
        rs1 = $random % 32;
        rs2 = $random % 32;
    endtask

    task automatic check_common(
        input logic check_ok
    );
        if (check_ok) begin
            $display("PASS");
        end else begin
            $display("FAIL");
            wrong_cnt++;
        end
        $display("----------------------------------------------------");
    endtask



    initial begin
        init();
        #(CLK_PERIOD);
        
        
        // ---------------- R-Type ----------------
        Exp_op = 7'b0110011;
        $display("|--------------------R-Type Decoder test-----------------|");
        $display("<Exp>|--Funct7--|\t|--rs2--|\t|--rs1--|\t|--funct3--|\t|--rd--|\t|--op--|");
        for (int i = 0; i < 8; i++) begin
            Exp_funct3 = i;
            Exp_funct7 = 7'b0000000; // ADD, AND, OR, etc.
            rand_regs(Exp_rd, Exp_rs1, Exp_rs2);

            instruction_in = {Exp_funct7, Exp_rs2, Exp_rs1, Exp_funct3, Exp_rd, Exp_op};
            #(CLK_PERIOD);

            $display("<Exp>|  %07h  |\t|  %05h  |\t|  %05h  |\t|  %03h  |\t|  %05h  |\t  %07h  |",Exp_funct7,Exp_rs2,Exp_rs1,Exp_funct3,Exp_rd,Exp_op);
            $display("<Res>|  %07h  |\t|  %05h  |\t|  %05h  |\t|  %03h  |\t|  %05h  |\t  %07h  |",funct7,reg_s2,reg_s1,funct3,reg_d,Op_code);
            check_common(
                {Exp_funct7,Exp_rs2,Exp_rs1,Exp_funct3,Exp_rd,Exp_op} ==
                {funct7,reg_s2,reg_s1,funct3,reg_d,Op_code}
                && r_type
            );
        end

        // ---------------- I-Type ----------------
        $display("|--------------------I-Type Decoder test-----------------|");
        $display("<Ins>|--Imm12--|\t|--rs1--|\t|--funct3--|\t|--rd--|\t|--op--|");
        Exp_op = 7'b0010011; // ADDI, ANDI, ORI
        for (int i = 0; i < 8; i++) begin
            logic [11:0] imm;
            imm = $random;

            Exp_funct3 = i;
            rand_regs(Exp_rd, Exp_rs1, Exp_rs2);

            instruction_in = {imm, Exp_rs1, Exp_funct3, Exp_rd, Exp_op};
            #(CLK_PERIOD);

            $display("<Exp>|--%0h--|\t|--%0h--|\t|--%0h--|\t|--%0h--|\t|--%0h--|",imm,Exp_rs1,Exp_funct3,Exp_rd,Exp_op);
            $display("<Res>|--%0h--|\t|--%0h--|\t|--%0h--|\t|--%0h--|\t|--%0h--|",imm12_i_s,reg_s1,funct3,reg_d,Op_code);
            check_common(
                imm      == imm12_i_s &&
                Exp_rs1  == reg_s1 &&
                Exp_rd   == reg_d &&
                Exp_funct3 == funct3 &&
                Exp_op   == Op_code &&
                i_type
            );
        end

        // ---------------- S-Type ----------------
        $display("|--------------------S-Type Decoder test-----------------|");
        $display("<Ins>|--Imm[11:5]--|\t|--rs2--|\t|--rs1--|\t|--funct3--|\t|--Imm[4:0]--|\t|--op--|");
        Exp_op = 7'b0100011; // SB, SH, SW

        for (int i = 0; i < 3; i++) begin
            logic [11:0] imm;
            imm = $random;

            Exp_funct3 = i;
            rand_regs(Exp_rd, Exp_rs1, Exp_rs2);

            instruction_in = {imm[11:5], Exp_rs2, Exp_rs1,
                            Exp_funct3, imm[4:0], Exp_op};
            #(CLK_PERIOD);

            $display("<Exp>|--%0h--|\t|--%0h--|\t|--%0h--|\t|--%0h--|\t|--%0h--|\t|--%0h--|",imm[11:5],Exp_rs2,Exp_rs1,Exp_funct3,imm[4:0],Exp_op);
            $display("<Res>|--%0h--|\t|--%0h--|\t|--%0h--|\t|--%0h--|\t|--%0h--|\t|--%0h--|",imm12_i_s[11:5],reg_s2,reg_s1,funct3,imm12_i_s[4:0],Op_code);
            check_common(
                imm == imm12_i_s &&
                Exp_rs1 == reg_s1 &&
                Exp_rs2 == reg_s2 &&
                Exp_funct3 == funct3 &&
                Exp_op   == Op_code &&
                s_type
            );
        end

        // ---------------- B-Type ----------------
        $display("|--------------------B-Type Decoder test-----------------|");
        $display("<Ins>|Imm[12]|Imm[10:5]|\t|--rs2--|\t|--rs1--|\t|--funct3--|\t|Imm[4:1]|Imm[11]|\t|--op--|");
        Exp_op = 7'b1100011; // BEQ, BNE

        for (int i = 0; i < 2; i++) begin
            logic [12:0] imm;
            imm = $random;

            Exp_funct3 = i;
            rand_regs(Exp_rd, Exp_rs1, Exp_rs2);

            instruction_in = {
                imm[12], imm[10:5],
                Exp_rs2, Exp_rs1,
                Exp_funct3,
                imm[4:1], imm[11],
                Exp_op
            };
            #(CLK_PERIOD);

            $display("<Exp>|--%0h--|--%0h--|\t|--%0h--|\t|--%0h--|\t|--%0h--|\t|--%0h--|--%0h--|\t|--%0h--|",
                    imm[12], imm[10:5], Exp_rs2, Exp_rs1, Exp_funct3, imm[4:1], imm[11], Exp_op);
            $display("<Res>|--%0h--|--%0h--|\t|--%0h--|\t|--%0h--|\t|--%0h--|\t|--%0h--|--%0h--|\t|--%0h--|",
                    imm13_b[12], imm13_b[10:5], reg_s2, reg_s1, funct3, imm13_b[4:1], imm13_b[11], Op_code);

            check_common(
                imm == imm13_b &&
                Exp_rs1 == reg_s1 &&
                Exp_rs2 == reg_s2 &&
                Exp_funct3 == funct3 &&
                Exp_op == Op_code &&
                b_type
            );
        end


        // ---------------- U-Type ----------------
        $display("|--------------------U-Type Decoder test-----------------|");
        $display("<Ins>|---------Imm[31:12]---------|\t|--rd--|\t|--op--|");
        for (int t = 0; t < 2; t++) begin
            logic [19:0] imm;
            logic [31:0] imm32;

            Exp_op = (t == 0) ? 7'b0110111 : 7'b0010111; // LUI / AUIPC
            imm = $random;
            imm32 = {imm,{12{1'b0}}};
            Exp_rd = $random % 32;

            instruction_in = {imm, Exp_rd, Exp_op};
            #(CLK_PERIOD);

            $display("<Exp>|---------0x%0h---------|\t|--%0h--|\t|--%0h--|",
                    imm32[31:12], Exp_rd, Exp_op);
            $display("<Res>|---------0x%0h---------|\t|--%0h--|\t|--%0h--|",
                    imm32_u[31:12], reg_d, Op_code);

            check_common(
                imm32 == imm32_u &&
                Exp_rd == reg_d &&
                u_type
            );
        end

        // ---------------- J-Type ----------------
        $display("|--------------------J-Type Decoder test-----------------|");
        $display("<Ins>|Imm[20]|Imm[10:1]|Imm[11]|Imm[19:12]|\t|--rd--|\t|--op--|");
        Exp_op = 7'b1101111;

        for (int i = 0; i < 5; i++) begin
            logic [20:0] imm;
            imm = $random;
            Exp_rd = $random % 32;
            imm[0] = 1'b0;
            
            instruction_in = {
                imm[20],
                imm[10:1],
                imm[11],
                imm[19:12],
                Exp_rd,
                Exp_op
            };
            #(CLK_PERIOD);

            $display("<Exp>|--%0h--|--%0h--|--%0h--|--%0h--|\t|--%0h--|\t|--%0h--|",
                    imm[20], imm[10:1], imm[11], imm[19:12], Exp_rd, Exp_op);
            $display("<Res>|--%0h--|--%0h--|--%0h--|--%0h--|\t|--%0h--|\t|--%0h--|",
                    imm21_j[20], imm21_j[10:1], imm21_j[11], imm21_j[19:12], reg_d, Op_code);

            check_common(
                imm == imm21_j &&
                Exp_rd == reg_d &&
                j_type
            );
        end


        $display("------Testbench Done.--------");
        $display("Wrong Cnt = %0d",wrong_cnt);
        $stop;
        
    end


endmodule