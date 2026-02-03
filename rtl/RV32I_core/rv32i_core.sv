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

//MARK: DEC Wire
	wire[6:0]       wOp_code;

	wire            wop_lui;
	wire            wop_auipc;
	wire            wop_jal;
	wire            wop_jalr;
	wire            wop_branch;
	wire            wop_memLd;
	wire            wop_intRegImm;
	wire            wop_memSt;
	wire            wop_consShf;
	wire            wop_intRegReg;
	wire            wop_efence;
	wire            wop_ecb;

	wire		 	 wNOP;

	wire            wr_type;
	wire            wi_type;
	wire            ws_type;
	wire            wb_type;
	wire            wj_type;
	wire            wu_type;

	wire[2:0]     	wfunct3;
	wire[6:0]     	wfunct7;
	wire[4:0]     	wreg_d;
	wire[4:0]     	wreg_s1;
	wire[4:0]     	wreg_s2;

	wire[12:0]    	wimm13_b;
	wire[11:0]    	wimm12_i_s;
	wire[31:0]    	wimm32_u;
	wire[20:0]    	wimm21_j;

    logic[6:0]   Op_code;
    logic        r_type;
    logic        i_type;
    logic        s_type;
    logic        b_type;
    logic        j_type;
    logic        u_type;

    logic[2:0]   funct3;
    logic[6:0]   funct7;
    logic[4:0]   reg_d;
    logic[4:0]   reg_s1;
    logic[4:0]   reg_s2;

    logic[12:0]  imm13_b;
    logic[11:0]  imm12_i_s;
    logic[31:0]  imm32_u;
    logic[20:0]  imm21_j;

    logic        op_lui;
    logic        op_auipc;
    logic        op_jal;
    logic        op_jalr;
    logic        op_branch;
    logic        op_memLd;
    logic        op_intRegImm;
    logic        op_memSt;
    logic        op_consShf;
    logic        op_intRegReg;
    logic        op_efence;
    logic        op_ecb;

//MARK: Data, Control Signal
    //PC
    logic[31:0]     wPc_int;
    // logic           rPcCondEn;
    logic[31:0]     wPcNextCond;
    logic[31:0]     wPcReturn;
	//Hazard
	logic			wHazardRs1_toFlush;
	logic			wHazardRs2_toFlush;
	logic			wHazard_2_Rs1_toFlush;
	logic			wHazard_2_Rs2_toFlush;
	logic			wHazard_3_Rs1_toFlush;
	logic			wHazard_3_Rs2_toFlush;
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
	logic			wStall;
	//Branch&Jump
	logic           wJmp_occur;
	logic			rJumping1;
	logic			rJumping2;
	logic			rJumping3;
	logic			wFlush;
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
    logic[31:0]     wAluB;
    logic[2:0]      wFunct3_aluIn;
    logic[6:0]      wFunct7_aluIn;
    logic           wAluSextEn;
	logic [31:0]    wAluOut;
    logic           wAluFlag;
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
	logic[31:0]     wRs1Data_toFlush;
    logic[31:0]     wRs2Data_toFlush;
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

//Data Path Logic    

//-----------------------------------------------------------------------------------------------------
//MARK: IF
	//PC
    assign pc = wPc_int;
    pc_reg rpc(
        .clk(clk),
        .rstB(rstB),
        .clkEn(clkEn),
		.stall(wStall),
        
        .condEn(rJumping1),
        .next_pc_cond(wPcNextCond),
        .pc_out(wPc_int)

    );

//-----------------------------------------------------------------------------------------------------
//MARK: ID
    inst_dec dec (       
        .clk(clk),
        .rstB(rstB),
		.clkEn(clkEn),

        .instruction_in(inst_in),
		.stall(wStall),

        .Op_code(wOp_code),
        .r_type(wr_type),
        .i_type(wi_type),
        .s_type(ws_type),
        .b_type(wb_type),
        .j_type(wj_type),
        .u_type(wu_type),

        .funct3(wfunct3),
        .funct7(wfunct7),

        .reg_d(wreg_d),
        .reg_s1(wreg_s1),
        .reg_s2(wreg_s2),
		.wReg_s1_out(wReg_s1_out),
		.wReg_s2_out(wReg_s2_out),

        .imm13_b(wimm13_b),
        .imm12_i_s(wimm12_i_s),
        .imm32_u(wimm32_u),
        .imm21_j(wimm21_j),

        .op_lui(wop_lui),
        .op_auipc(wop_auipc),
        .op_jal(wop_jal),
        .op_jalr(wop_jalr),
        .op_branch(wop_branch),
        .op_memLd(wop_memLd),
        .op_intRegImm(wop_intRegImm),
        .op_memSt(wop_memSt),
        .op_consShf(wop_consShf),
        .op_intRegReg(wop_intRegReg),
        .op_efence(wop_efence),
        .op_ecb(wop_ecb),

		.hazardS1(wHazardRs1_toFlush),
		.hazardS2(wHazardRs2_toFlush),
		.hazardS1_2(wHazard_2_Rs1_toFlush),
		.hazardS2_2(wHazard_2_Rs2_toFlush),
		.hazardS1_3(wHazard_3_Rs1_toFlush),
		.hazardS2_3(wHazard_3_Rs2_toFlush)
    );
	reg_file_sky130sram reg_module (
        .clk(clk),
        .rstB(rstB),

        .wrEn(wRegWrEn),
        .wrData(wRegWrData),
        .wrAddr(rReg_d2),

        .rdR1Addr(wReg_s1_out),
        .rdR2Addr(wReg_s2_out),

        .r1out(wRs1Data_toFlush),
        .r2out(wRs2Data_toFlush)
    );

//-----------------------------------------------------------------------------------------------------
//MARK: EXE
	//Flush if Jmp (in EXE Stage)
	always_comb begin : FlushMUX
		if(wFlush)begin
			Op_code      = 0; 
			op_lui       = 1'b0;
			op_auipc     = 1'b0;
			op_jal       = 1'b0;
			op_jalr      = 1'b0;
			op_branch    = 1'b0; 
			op_memLd     = 1'b0;
			op_intRegImm = 1'b0;
			op_consShf   = 1'b0;
			op_memSt     = 1'b0;
			op_intRegReg = 1'b0;
			op_efence    = 1'b0;
			op_ecb       = 1'b0;
			r_type       = 1'b0;
			i_type       = 1'b0;
			s_type       = 1'b0;
			b_type       = 1'b0;
			j_type       = 1'b0;
			u_type       = 1'b0;
			funct3       = 3'b000;
			funct7       = 7'b0000000;
			reg_d        = 5'b00000;
			reg_s1       = 5'b00000;
			reg_s2       = 5'b00000;
			imm12_i_s    = 12'h000;
			imm13_b      = 13'h0000;
			imm32_u      = 32'h00000000;
			imm21_j      = 21'h00000;

			wHazardRs1 = 1'b0;
			wHazardRs2 = 1'b0;
			wHazard_2_Rs1 = 1'b0;
			wHazard_2_Rs2 = 1'b0;
			wHazard_3_Rs1 = 1'b0;
			wHazard_3_Rs2 = 1'b0;

		end else begin
			Op_code	  = wOp_code;
			op_lui       = wop_lui;
			op_auipc     = wop_auipc;
			op_jal       = wop_jal;
			op_jalr      = wop_jalr;
			op_branch    = wop_branch;
			op_memLd     = wop_memLd;
			op_intRegImm = wop_intRegImm;
			op_consShf   = wop_consShf;
			op_memSt     = wop_memSt;
			op_intRegReg = wop_intRegReg;
			op_efence    = wop_efence;
			op_ecb       = wop_ecb;
			r_type       = wr_type;
			i_type       = wi_type;
			s_type       = ws_type;
			b_type       = wb_type;
			j_type       = wj_type;
			u_type       = wu_type;
			funct3       = wfunct3;
			funct7       = wfunct7;
			reg_d        = wreg_d;
			reg_s1       = wreg_s1;
			reg_s2       = wreg_s2;
			imm12_i_s    = wimm12_i_s;
			imm13_b      = wimm13_b;
			imm32_u      = wimm32_u;
			imm21_j      = wimm21_j;

			wHazardRs1 = wHazardRs1_toFlush;
			wHazardRs2 = wHazardRs2_toFlush;
			wHazard_2_Rs1 = wHazard_2_Rs1_toFlush;
			wHazard_2_Rs2 = wHazard_2_Rs2_toFlush;
			wHazard_3_Rs1 = wHazard_3_Rs1_toFlush;
			wHazard_3_Rs2 = wHazard_3_Rs2_toFlush;

		end
	end
	assign wRs1Data = (wFlush) ? 0 : wRs1Data_toFlush;
	assign wRs2Data = (wFlush) ? 0 : wRs2Data_toFlush;

	//MARK: EXE : Hazard Handling
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
	
	//MARK: EXE : ALU
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
	
	//MARK: EXE : Branch Cond
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

	assign wJmp_occur = (!clkEn) ? 1'b0 :
					b_type | op_jal | op_jalr;
	assign wNEq = |{wAluFlag,wAluOut};
	assign wLt = wAluFlag & wNEq;
	assign wGt = !wAluFlag & wNEq;

	always @(posedge clk ) begin
		if(!rstB)begin
			rJumping1 <= 1'b0;
			rJumping2 <= 1'b0;
			rJumping3 <= 1'b0;
			rCond <= 1'b0;
		end else begin
			if(wCond | op_jal | op_jalr)begin
				rJumping1 <= wJmp_occur;
			end else begin
				rJumping1 <= 1'b0;
			end
			
			rJumping2 <= rJumping1;
			rJumping3 <= rJumping2;
			rCond <= wCond;
		end
	end

	assign wFlush = rJumping1 | rJumping2 | rJumping3;

	//MARK: EXE : Branch+1
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

        .pc_return(wPcReturn),
        .pc_jmpto(wPcNextCond),
		.Cond(rCond)
    );

//----------------------------------------------------------------------------------------------------------
//MARK: MEM
	always @(posedge clk) begin
		rOp_memLd <= op_memLd;
		rOp_jalr <= op_jalr;
	end

	always @(posedge clk) begin
        if(!rstB)begin
            rRegWrEn <= 1'b0;
        end else begin
            rRegWrEn <= (rstB) & (op_jalr | op_jal | op_memLd | op_intRegImm | op_intRegReg | op_consShf | op_lui | op_auipc) ; 
        end
    end

	always @(posedge clk ) begin
		rWrData <= wExeData;
	end
    

	always @(posedge clk) begin
        rReg_d <= reg_d;
		rRegWrData <= wRegWrData;
    end

	//MARK: MEM : Mem/Ram Dbus
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

//----------------------------------------------------------------------------------------------------
//MARK: WB 
	always @(posedge clk ) begin
		rWrDataWB <= rWrData; //rWrData = MEM
	end
	always @(posedge clk ) begin
		rRegWrEn2 <= rRegWrEn;
	end
	always @(posedge clk) begin
		rReg_d2 <= rReg_d;
    end
	always @(posedge clk) begin
		rOp_memLd2 <= rOp_memLd;
	end

	assign wRegWrData = (rOp_memLd2) ? dataBusIn : rWrDataWB;
	assign wRegWrEn = rRegWrEn2;
	

endmodule