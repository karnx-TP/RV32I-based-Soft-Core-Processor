//----------------------------------------
// File : rv32i_core.sv
// Author : Thitipong Pav
// Desc : RV32I processor cpu core
//----------------------------------------

module rv32i_core (
    clk,
    rstB,
    clkEn,

    pc,
    inst_in,

    addr,
    dataBusOut,
    wrEn,
	rdEn,
	RamMode,
    dataBusIn,
	dataBusInEn
);
//Port
    input logic     	clk;
    input logic     	rstB;
    input logic     	clkEn;
    output logic[31:0]  pc;
    input logic[31:0]   inst_in;
	output logic[31:0]  addr;
    output logic[31:0]	dataBusOut;
    output logic		wrEn;
	output logic		rdEn;
	output logic[3:0]	RamMode;
    input logic[31:0]	dataBusIn;
	input logic			dataBusInEn;
    

//BUS ID
	localparam RAM = 0;
	localparam UART = 1;

//Wire
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

    logic [31:0]    wAluOut;
    logic           wAluFlag;

//Internal Signal , Control Signal
    //PC
    logic[31:0]     wPc_int;
    // logic           rPcCondEn;
    logic[31:0]     wPcNextCond;
    logic[31:0]     wPcReturn;
	//Hazard
	logic			wHazardRs1;
	logic			wHazardRs2;
	logic			wHazard_2_Rs1;
	logic			wHazard_2_Rs2;
	logic			wHazard_3_Rs1;
	logic			wHazard_3_Rs2;
	logic			rHazardRs1;
	logic			rHazardRs2;
	logic			rHazard_2_Rs1;
	logic			rHazard_2_Rs2;
	logic			rHazard_3_Rs1;
	logic			rHazard_3_Rs2;
	logic			wHazardStall;
	//Branch&Jumo
	logic			rJumping1;
	logic			rJumping2;
	logic			wJumping;
	logic           wJmp_occur;
	logic 			rOp_jalr;
	// logic[31:0]		rAluJmpFW;
	//Test add 1 near condition decision
	logic 	wCond;
	logic	rCond;
	logic	wNEq;
	logic	wLt;
	logic	wGt;
    //ALU
    logic[31:0]     wAluA;
	// logic[31:0]		wAluAFw;
    logic[31:0]     wAluB;
	// logic[31:0]		wAluBFw;
    logic[2:0]      wFunct3_aluIn;
    logic[6:0]      wFunct7_aluIn;
    logic           wAluSextEn;
    //Reg
	wire[4:0]		wReg_s1_out;
	wire[4:0]		wReg_s2_out;
	logic[31:0]     wExeData;
    logic[31:0]     rWrData;
	logic[31:0]     rWrDataWB;
    logic           wRegWrEn;
    logic           rRegWrEn;
	logic           rRegWrEn2;
	logic[4:0]		rReg_d;
	logic[4:0]		rReg_d2;
    logic[31:0]     wRegWrData;
	logic[31:0]     rRegWrData;
	logic[31:0]     wRs1Data;
    logic[31:0]     wRs2Data;
	logic[31:0]     rRs1DataBP;
    logic[31:0]     rRs2DataBP;
    //Ram
    logic           rOp_memLd;
	logic			rOp_memLd2;
	logic		    wRamByteEn;
    logic			wRamHalfEn;
    logic			wRamWordEn;
    logic			wRamUnsignedEn;
	logic[31:0]		wForwardAddr;

    
//Module Declaration
    pc_reg rpc(
        .clk(clk),
        .rstB(rstB),
        .clkEn(clkEn),
		.stall(wStall),
        
        .condEn(rJumping1),
        .next_pc_cond(wPcNextCond),
        .pc_out(wPc_int)

    );
    inst_dec dec (       
        .clk(clk),
        .rstB(rstB),
		.clkEn(clkEn),

        .instruction_in(inst_in),
        .jmp(wJumping),
		.stall(wStall),

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
		.wReg_s1_out(wReg_s1_out),
		.wReg_s2_out(wReg_s2_out),

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
        .op_ecb(op_ecb),

		.hazardS1(wHazardRs1),
		.hazardS2(wHazardRs2),
		.hazardS1_2(wHazard_2_Rs1),
		.hazardS2_2(wHazard_2_Rs2),
		.hazardS1_3(wHazard_3_Rs1),
		.hazardS2_3(wHazard_3_Rs2)
    );
	reg_file_sky130sram reg_module (
        .clk(clk),
        .rstB(rstB),

        .wrEn(wRegWrEn),
        .wrData(wRegWrData),
        .wrAddr(rReg_d2),

        .rdR1Addr(wReg_s1_out),
        .rdR2Addr(wReg_s2_out),

        .r1out(wRs1Data),
        .r2out(wRs2Data)
    );
    ALU32bits alu (
        .r_type(r_type),
        .i_type(i_type),
        .b_type(b_type),
        .funct3(wFunct3_aluIn),
        .funct7(wFunct7_aluIn),
        .op_consShf(op_consShf),
        .sub_sign_extEn(wAluSextEn),
        .A(wAluA),
        .B(wAluB),
        .out(wAluOut),
        .flag(wAluFlag)
    );
    branch_unit brancher (
        .clk(clk),
	    .rstB(rstB),
		.stall(wStall),
        .b_type(b_type),
        .op_jal(op_jal),
        .op_jalr(op_jalr),
        .imm21_j(imm21_j),
        .imm12_i_s(imm12_i_s),
        .imm13_b(imm13_b),

        .funct3(funct3),
        .alu_result(wAluOut),
	    .alu_flag(wAluFlag),

        .pc_current(wPc_int),
        .link_reg_in(wRs1Data),

        .pc_return(wPcReturn),
        .pc_jmpto(wPcNextCond),
		.Cond(rCond)
    );

//PC
    assign pc = wPc_int;

//Bypass
	always @(posedge clk ) begin
		rHazardRs1 <= wHazardRs1;
		rHazardRs2 <= wHazardRs2;
		rHazard_2_Rs1 <= wHazard_2_Rs1;
		rHazard_2_Rs2 <= wHazard_2_Rs2;
		rHazard_3_Rs1 <= wHazard_3_Rs1;
		rHazard_3_Rs2 <= wHazard_3_Rs2;
	end
	always @(posedge clk) begin
		if(wHazardRs1 & !wStall)begin
			rRs1DataBP <= wExeData;
		end else if(wHazard_2_Rs1 & !wStall) begin
			rRs1DataBP <= rWrData;
		end else if(wHazard_3_Rs1 | wStall) begin
			rRs1DataBP <= rWrDataWB;
		end else begin
			rRs1DataBP <= rRs1DataBP;
		end
	end

	always @(posedge clk) begin
		if(wHazardRs2 & !wStall)begin
			rRs2DataBP <= wExeData;
		end else if(wHazard_2_Rs2 & !wStall) begin
			rRs2DataBP <= rWrData;
		end else if(wHazard_3_Rs2 | wStall) begin
			rRs2DataBP <= wRegWrData;
		end else begin
			rRs2DataBP <= rRs2DataBP;
		end
	end
	

//Reg file
	always @(posedge clk) begin
        rReg_d <= reg_d;
		rReg_d2 <= rReg_d;
		rRegWrData <= wRegWrData;
    end

    assign wRegWrData = (rOp_memLd2) ? dataBusIn : rWrDataWB;
	assign wRegWrEn = rRegWrEn2;

	always @(posedge clk ) begin
		rWrData <= wExeData;
		rWrDataWB <= rWrData; //rWrData = MEM
	end
    always_comb begin
        if(op_intRegImm | op_intRegReg | op_consShf | op_auipc) begin //ALU
			wExeData = wAluOut;
		end else if(op_lui) begin //Load upper imm
			wExeData = imm32_u;
        end else if (op_jal | op_jalr) begin
            wExeData = wPcReturn;
        end else begin	
			wExeData = 0;
		end
    end
	always @(posedge clk ) begin
		rRegWrEn2 <= rRegWrEn;
	end
    always @(posedge clk) begin
        if(!rstB)begin
            rRegWrEn <= 1'b0;
        end else begin
            rRegWrEn <= (rstB) & (op_jalr | op_jal | op_memLd | op_intRegImm | op_intRegReg | op_consShf | op_lui | op_auipc) ; 
        end
    end

//ALU
    assign wFunct3_aluIn = b_type ? 3'b000 : //Use SUB in ALU for Branch
                           op_auipc ? 3'b000 : //Add AUIPC
                           funct3; 
    assign wFunct7_aluIn = b_type ? 7'b0100000 : 
                           op_auipc ? 7'b0000000 : 
                           funct7;
    assign wAluSextEn = (b_type & (funct3[2:1] == 2'b11)) ? 1'b0 : 1'b1;

    always_comb begin : MuxForAlu
		//A
        if(r_type | op_consShf | op_intRegImm | b_type | op_jalr) begin
			wAluA = (rHazardRs1 | rHazard_2_Rs1 | rHazard_3_Rs1 | wStall) ? rRs1DataBP : wRs1Data; 
		end else if (op_auipc) begin
            wAluA = wPc_int;
        end else begin
			wAluA = 0;
		end

		//B
		if(r_type | b_type) begin
			wAluB = (rHazardRs2 | rHazard_2_Rs2 | rHazard_3_Rs2 | wStall) ? rRs2DataBP : wRs2Data; 
		end else if(op_consShf | op_intRegImm | op_jalr) begin
			wAluB = {{20{imm12_i_s[11]}},imm12_i_s}; //Sign-Extended
        end else if (op_auipc) begin
            wAluB = imm32_u;
        end else begin
			wAluB = 0;
		end
    end

//Branch
	
	always_comb begin : uCond
		case (funct3)
			3'b000 : wCond = !wNEq;
			3'b001 : wCond = wNEq;
			3'b100 : wCond = wLt;
			3'b101 : wCond = wGt;
			3'b110 : wCond = wLt|(!wNEq);
			3'b111 : wCond = wGt;
			default: wCond = 1'b0;
		endcase
	end

	// assign wJmp_occur = clkEn ? op_jal | op_jalr | (b_type & wCond) : 1'b0;
	assign wJmp_occur = (!clkEn) ? 1'b0 :
					b_type ? wCond :
					op_jal | op_jalr;

	assign wJumping = rJumping2 | rJumping1 | wJmp_occur;
	assign wNEq = |{wAluFlag,wAluOut};
	assign wLt = wAluFlag & wNEq;
	assign wGt = !wAluFlag & wNEq;

	always @(posedge clk ) begin
		rJumping1 <= wJmp_occur;
		rJumping2 <= rJumping1;
		rCond <= wCond;
	end

//Mem/RAM
	assign wForwardAddr =  (rHazardRs1 | rHazard_2_Rs1 | rHazard_3_Rs1 | wStall) ? rRs1DataBP : wRs1Data; 
    assign addr = (op_memLd | op_memSt) ? wForwardAddr + imm12_i_s : {32{1'b0}};
    assign wrEn = (rstB) & (op_memSt);
	assign rdEn = (rstB) & (op_memLd);
    assign dataBusOut = (rHazardRs2 | rHazard_2_Rs2 | rHazard_3_Rs2 | wStall) ? rRs2DataBP : wRs2Data; 
	assign RamMode = {wRamByteEn,wRamHalfEn,wRamWordEn,wRamUnsignedEn};
    assign wRamByteEn = (funct3[1:0] == 2'b00);
    assign wRamHalfEn = (funct3[1:0] == 2'b01);
    assign wRamWordEn = (funct3[1:0] == 2'b10);
    assign wRamUnsignedEn = funct3[2];

    always @(posedge clk) begin
        rOp_memLd <= op_memLd;
		rOp_memLd2 <= rOp_memLd;
		rOp_jalr <= op_jalr;
    end

endmodule