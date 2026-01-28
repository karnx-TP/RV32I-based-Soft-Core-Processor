//----------------------------------------
// File : inst_dec.sv
// Author : Thitipong Pav
// Desc : rv32i instruction decoder
//----------------------------------------

module inst_dec (
    clk,
    rstB,
	clkEn,
    
    instruction_in,
	stall,

    Op_code,
    r_type,
    i_type,
    s_type,
    b_type,
    j_type,
    u_type,

    funct3,
    funct7,

    reg_d,
    reg_s1,
    reg_s2,
	wReg_s1_out,
	wReg_s2_out,

    imm13_b,
    imm12_i_s,
    imm32_u,
    imm21_j,

    op_lui,
    op_auipc,
    op_jal,
    op_jalr,
    op_branch,
    op_memLd,
    op_intRegImm,
    op_memSt,
    op_consShf,
    op_intRegReg,
    op_efence,
    op_ecb,

	hazardS1,
	hazardS2,
	hazardS1_2,
	hazardS2_2,
	hazardS1_3,
	hazardS2_3

);

//Module Port Assignment
    input   logic       clk;
    input   logic       rstB;
	input 	logic		clkEn;

    input   logic[31:0]      instruction_in;
	output 	logic		stall;

    output logic[6:0]   Op_code;
    output logic        r_type;
    output logic        i_type;
    output logic        s_type;
    output logic        b_type;
    output logic        j_type;
    output logic        u_type;

    output logic[2:0]   funct3;
    output logic[6:0]   funct7;
    output logic[4:0]   reg_d;
    output logic[4:0]   reg_s1;
    output logic[4:0]   reg_s2;
	output wire[4:0]	wReg_s1_out;
	output wire[4:0]	wReg_s2_out;

    output logic[12:0]  imm13_b;
    output logic[11:0]  imm12_i_s;
    output logic[31:0]  imm32_u;
    output logic[20:0]  imm21_j;

    output logic        op_lui;
    output logic        op_auipc;
    output logic        op_jal;
    output logic        op_jalr;
    output logic        op_branch;
    output logic        op_memLd;
    output logic        op_intRegImm;
    output logic        op_memSt;
    output logic        op_consShf;
    output logic        op_intRegReg;
    output logic        op_efence;
    output logic        op_ecb;

	output logic 		hazardS1;
	output logic		hazardS2;
	output logic 		hazardS1_2;
	output logic		hazardS2_2;
	output logic 		hazardS1_3;
	output logic		hazardS2_3;

//Signal Assignment
	logic[31:0]		wInst_in;
	logic[31:0]		rInstrustion1;
	logic[31:0]		rInstrustion2;
	logic[6:0]       wOp_code;

	logic            wop_lui;
	logic            wop_auipc;
	logic            wop_jal;
	logic            wop_jalr;
	logic            wop_branch;
	logic            wop_memLd;
	logic            wop_intRegImm;
	logic            wop_memSt;
	logic            wop_consShf;
	logic            wop_intRegReg;
	logic            wop_efence;
	logic            wop_ecb;

	logic		 	 wNOP;

	logic            wr_type;
	logic            wi_type;
	logic            ws_type;
	logic            wb_type;
	logic            wj_type;
	logic            wu_type;

	logic[2:0]     	wfunct3;
	logic[6:0]     	wfunct7;
	logic[4:0]     	wreg_d;
	logic[4:0]     	wreg_s1;
	logic[4:0]     	wreg_s2;

	logic[12:0]    	wimm13_b;
	logic[11:0]    	wimm12_i_s;
	logic[31:0]    	wimm32_u;
	logic[20:0]    	wimm21_j;

	//Hazard Handle
	logic			rRegWrEn;
	logic			rRegWrEn2;
	logic			rRegWrEn3;
	logic			rOp_memLd;
    logic           wHazardRs1; //pc = i-1
    logic           wHazardRs2;
	logic           wHazard_2_Rs1; //pc = i-2
    logic           wHazard_2_Rs2;
	logic           wHazard_3_Rs1; //pc = i-3
    logic           wHazard_3_Rs2;
	logic			wHazardStall_EXE;
	logic			wHazardStall_MEM;
	logic[4:0]      rReg_d2;
	logic[4:0]      rReg_d3;
	logic			wStall;
	logic			wStall_1;
	logic			rStall;
	logic			rStall2;
	logic			rPostStall;
	logic			rStallCnt1;
	logic			rStallCnt2;
    

//Combinational Circuit
	assign wReg_s1_out = rStall ? reg_s1 : wreg_s1;
	assign wReg_s2_out = rStall ? reg_s2 : wreg_s2;

	always_comb begin : uInstr
		if(!rstB)begin
			wInst_in = 0;
		end else if (rPostStall && rStallCnt2)begin
			wInst_in = rInstrustion1;
		end else if (rPostStall && !rStallCnt2)begin
			wInst_in = rInstrustion2;
		end else if(clkEn) begin
			wInst_in = instruction_in;
		end else begin
			wInst_in = 0;
		end
	end  

	always_comb begin : wDecoder
		wOp_code      = wInst_in[6:0]; 
		wfunct3       = wInst_in[14:12];
		wfunct7       = wInst_in[31:25];
		wreg_d        = wInst_in[11:7];
		wreg_s1       = wInst_in[19:15];
		wreg_s2       = wInst_in[24:20];

		wop_lui       = (wOp_code == 7'b0110111) ? 1'b1 : 1'b0;
		wop_auipc     = (wOp_code == 7'b0010111) ? 1'b1 : 1'b0;
		wop_jal       = (wOp_code == 7'b1101111) ? 1'b1 : 1'b0;
		wop_jalr      = (wOp_code == 7'b1100111) ? 1'b1 : 1'b0;
		wop_branch    = (wOp_code == 7'b1100011) ? 1'b1 : 1'b0; 
		wop_memLd     = (wOp_code == 7'b0000011) ? 1'b1 : 1'b0;
		wop_intRegImm = (wOp_code == 7'b0010011) && (wfunct3 != 3'b001 && wfunct3 != 3'b101) ? 1'b1 : 1'b0;
		wop_consShf   = (wOp_code == 7'b0010011) && (wfunct3 == 3'b001 || wfunct3 == 3'b101) ? 1'b1 : 1'b0;
		wop_memSt     = (wOp_code == 7'b0100011) ? 1'b1 : 1'b0;
		wop_intRegReg = (wOp_code == 7'b0110011) ? 1'b1 : 1'b0;
		wop_efence    = (wOp_code == 7'b0001111) ? 1'b1 : 1'b0;
		wop_ecb       = (wOp_code == 7'b1110011) ? 1'b1 : 1'b0;
		wNOP 		  = (wInst_in == 0);


		wr_type       = wop_intRegReg;
		wi_type       = wop_jalr | wop_memLd | wop_intRegImm | wop_consShf | wop_efence | wop_ecb;
		ws_type       = wop_memSt;
		wb_type       = wop_branch;
		wj_type       = wop_jal;
		wu_type       = wop_lui | wop_auipc;

		wimm12_i_s    = (wi_type) ? wInst_in[31:20] :
						(ws_type) ? {wInst_in[31:25],wInst_in[11:7]} :
						12'h000;
		wimm13_b      = {wInst_in[31],wInst_in[7],wInst_in[30:25],wInst_in[11:8],1'b0}; //B
		wimm32_u      = {wInst_in[31:12],12'h000}; //U
		wimm21_j      = {wInst_in[31],wInst_in[19:12],wInst_in[20],wInst_in[30:21],1'b0}; //J 
	end
             

//Sequencial
	always @(posedge clk ) begin
		rInstrustion1 <= instruction_in;
		rInstrustion2 <= rInstrustion1;

		rOp_memLd <= op_memLd;

		rRegWrEn <= (rstB) & (op_jalr | op_jal | op_memLd | op_intRegImm | op_intRegReg | op_consShf | op_lui | op_auipc) ; 
		rRegWrEn2 <= rRegWrEn;
		rRegWrEn3 <= rRegWrEn2;

		rReg_d2 <= reg_d;
		rReg_d3 <= rReg_d2;

		if(!rStall)begin
			Op_code <= wOp_code;
			op_lui <= wop_lui;
			op_auipc <= wop_auipc;
			op_jal <= wop_jal;
			op_jalr <= wop_jalr;
			op_branch <= wop_branch;
			op_memLd <= wop_memLd;
			op_intRegImm <= wop_intRegImm;
			op_memSt <= wop_memSt;
			op_consShf <= wop_consShf;
			op_intRegReg <= wop_intRegReg;
			op_efence <= wop_efence;
			op_ecb <= wop_ecb;	
			r_type <= wr_type;
			i_type <= wi_type;
			s_type <= ws_type;
			b_type <= wb_type;
			j_type <= wj_type;
			u_type <= wu_type;
			funct3 <= wfunct3;
			funct7 <= wfunct7;
			reg_d <= wreg_d;
			reg_s1 <= wreg_s1;
			reg_s2 <= wreg_s2;
			imm13_b <= wimm13_b;
			imm12_i_s <= wimm12_i_s;
			imm32_u <= wimm32_u;
			imm21_j <= wimm21_j;
		end
	end

	

//Hazard Handle
	assign stall = rStall;

    assign wHazardRs1 = rRegWrEn && (reg_d == wreg_s1) && (reg_d != 0);
    assign wHazardRs2 = rRegWrEn && (reg_d == wreg_s2) && (reg_d != 0);
	assign wHazardStall_EXE = (wHazardRs1 || wHazardRs2) && (wop_memLd);
	assign hazardS1 = wHazardRs1;
	assign hazardS2 = wHazardRs2;
	
	assign wHazard_2_Rs1 = rRegWrEn2 && (rReg_d2 == wreg_s1) && (rReg_d2 != 0);
    assign wHazard_2_Rs2 = rRegWrEn2 && (rReg_d2 == wreg_s2) && (rReg_d2 != 0);
	assign wHazardStall_MEM = (wHazard_2_Rs1 || wHazard_2_Rs2) && (op_memLd);
	assign hazardS1_2 = wHazard_2_Rs1;
	assign hazardS2_2 = wHazard_2_Rs2; 

	assign wHazard_3_Rs1 = rRegWrEn3 && (rReg_d3 == wreg_s1) && (rReg_d3 != 0);
    assign wHazard_3_Rs2 = rRegWrEn3 && (rReg_d3 == wreg_s2) && (rReg_d3 != 0);
	assign hazardS1_3 = wHazard_3_Rs1;
	assign hazardS2_3 = wHazard_3_Rs2;

	assign wStall = wStall_1 | rStall2;
	assign wStall_1 = clkEn && (wHazardStall_EXE || wHazardStall_MEM) && (!rStall);

	always @(posedge clk ) begin
		if(!rstB)begin
			rStall <= 1'b0;
			rStall2 <= 1'b0;
		end else begin
			rStall <= wStall;
			rStall2 <= wStall_1 & !wHazardStall_MEM;	
		end

		rStallCnt1 <= wStall_1;
		rStallCnt2 <= rStallCnt1;	

		rPostStall <=  !wStall & rStall;
	
	end

endmodule