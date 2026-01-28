//----------------------------------------
// File : branch_unit.sv
// Author : Thitipong Pav
// Desc : branch and jump handling logic
//----------------------------------------

module branch_unit (
	clk,
	rstB,
	stall,

	b_type,
    op_jal,
    op_jalr,
    imm21_j,
    imm12_i_s,
    imm13_b,

	funct3,
	alu_result,
	alu_flag,

	pc_current,
	link_reg_in,

    pc_return,
    pc_jmpto,
	Cond
);
//Port
	input logic			clk;
    input logic         rstB;
	input logic			stall;
	input logic			b_type;
    input logic         op_jal;
    input logic         op_jalr;
    input logic[20:0]	imm21_j;
    input logic[11:0]	imm12_i_s;
    input logic[12:0]	imm13_b;

	input logic[2:0]	funct3;
	input logic[31:0]	alu_result;
	input logic			alu_flag;

	input logic[31:0]	pc_current;
	input logic[31:0]	link_reg_in;

    output logic[31:0]	pc_return;
    output logic[31:0]	pc_jmpto;
	input logic		Cond;

//Signal
	//B/J Executing
	// logic		wJmp;
	// logic		rJumping;
	//Comparison
	// logic 	wCond;
	// logic	wNEq;
	// logic	wLt;
	// logic	wGt;
	//PC reg of currently exe instr
	logic[31:0]	rPc_current_reg1;
	logic[31:0]	rPc_current_reg2;
	logic[31:0]	rPc_current_reg3;
	//Reg for 2nd Cycle
	logic[31:0]		rAlu_result;
	logic			rOp_jal;
	logic			rOp_jalr;
	logic			rOp_b_type;
	logic[31:0]		rAdder_jal;
	logic[31:0]		rAdder_b;

//Comb Logic

	always_comb begin : uJmp
		if(rOp_jal) begin
			pc_jmpto = rPc_current_reg3 + rAdder_jal;
		end else if(rOp_jalr) begin
			pc_jmpto = {rAlu_result[31:1],1'b0}; 
		end else if (rOp_b_type & Cond) begin
			pc_jmpto = rPc_current_reg3 + rAdder_b;
		end else begin
			pc_jmpto = pc_current + 4;
		end
	end

	always_comb begin : uRET
		if(op_jal | op_jalr) begin
			pc_return = rPc_current_reg1;
		end else begin
			pc_return = 0;
		end
	end

//Sequencial
	always @(posedge clk ) begin
		if(!stall)begin
			rPc_current_reg1 <= pc_current;
			rPc_current_reg2 <= rPc_current_reg1;
			rPc_current_reg3 <= rPc_current_reg2;
		end
	end

	// always @(posedge clk) begin
	// 	if(!rstB) begin
	// 		rJumping <= 1'b0;
	// 	end else begin
	// 		rJumping <= wJmp;
	// 	end
	// end

	always @(posedge clk ) begin
		rAlu_result <= alu_result;
		rOp_jal <= op_jal;
		rOp_jalr <= op_jalr;
		rOp_b_type <= b_type;

		rAdder_jal <= {{10{imm21_j[20]}},imm21_j,1'b0};
		rAdder_b <= {{18{imm13_b[12]}},imm13_b,1'b0};
	end
    
endmodule