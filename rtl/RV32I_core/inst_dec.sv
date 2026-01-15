module inst_dec (
    clk,
    rstB,
	clkEn,
    
    instruction_in,
    jmp,
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
    op_ecb

);

//Module Port Assignment
    input   logic       clk;
    input   logic       rstB;
	input 	logic		clkEn;

    input   logic[31:0]      instruction_in;
    input   logic       jmp;
	input 	logic		stall;

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

//Signal Assignment
	logic[31:0]		wInst_in;
	logic[31:0]		rInstrustion;
	logic			rStall;
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
    

//Combinational Circuit
	always_comb begin : uInstr
		if(!rstB)begin
			wInst_in = 0;
		end else if(jmp) begin
			wInst_in = 0;
		end else if (rStall)begin
			wInst_in = rInstrustion;
		end else if(clkEn) begin
			wInst_in = instruction_in;
		end else begin
			wInst_in = 0;
		end
	end  

    assign wOp_code      = wInst_in[6:0]; 

	assign wop_lui       = (wOp_code == 7'b0110111) ? 1'b1 : 1'b0;
    assign wop_auipc     = (wOp_code == 7'b0010111) ? 1'b1 : 1'b0;
    assign wop_jal       = (wOp_code == 7'b1101111) ? 1'b1 : 1'b0;
    assign wop_jalr      = (wOp_code == 7'b1100111) ? 1'b1 : 1'b0;
    assign wop_branch    = (wOp_code == 7'b1100011) ? 1'b1 : 1'b0; 
    assign wop_memLd     = (wOp_code == 7'b0000011) ? 1'b1 : 1'b0;
    assign wop_intRegImm = (wOp_code == 7'b0010011) && (wfunct3 != 3'b001 && wfunct3 != 3'b101) ? 1'b1 : 1'b0;
    assign wop_consShf   = (wOp_code == 7'b0010011) && (wfunct3 == 3'b001 || wfunct3 == 3'b101) ? 1'b1 : 1'b0;
    assign wop_memSt     = (wOp_code == 7'b0100011) ? 1'b1 : 1'b0;
    assign wop_intRegReg = (wOp_code == 7'b0110011) ? 1'b1 : 1'b0;
    assign wop_efence    = (wOp_code == 7'b0001111) ? 1'b1 : 1'b0;
    assign wop_ecb     	= (wOp_code == 7'b1110011) ? 1'b1 : 1'b0;


    assign wr_type       = wop_intRegReg;
    assign wi_type       = wop_jalr | wop_memLd | wop_intRegImm | wop_consShf | wop_efence | wop_ecb;
    assign ws_type       = wop_memSt;
    assign wb_type       = wop_branch;
    assign wj_type       = wop_jal;
    assign wu_type       = wop_lui | wop_auipc;

    assign wfunct3       = wInst_in[14:12];
    assign wfunct7       = wInst_in[31:25];
    assign wreg_d        = wInst_in[11:7];
    assign wreg_s1       = wInst_in[19:15];
    assign wreg_s2       = wInst_in[24:20];

    assign wimm12_i_s    = (wi_type) ? wInst_in[31:20] :
				           (ws_type) ? {wInst_in[31:25],wInst_in[11:7]} :
                          12'h000;
    assign wimm13_b      = {wInst_in[31],wInst_in[7],wInst_in[30:25],wInst_in[11:8],1'b0}; //B
    assign wimm32_u      = {wInst_in[31:12],12'h000}; //U
    assign wimm21_j      = {wInst_in[31],wInst_in[19:12],wInst_in[20],wInst_in[30:21],1'b0}; //J          

//Sequencial
	always @(posedge clk ) begin
		rInstrustion <= instruction_in;
		rStall <= stall;

		if(!stall)begin
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

endmodule