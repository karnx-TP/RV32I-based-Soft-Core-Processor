module branch_unit (
	clk,
	rstB,

	b_type,
    op_jal,
    op_jalr,
    imm21_j,
    imm12_i_s,
    imm13_b,

	funct3,
	sub_result,
	sub_sign,

	pc_current,
	link_reg_in,

    pc_return,
    pc_jmpto,
	jmp_occur
);
//Port
	input logic			clk;
    input logic         rstB;
	input logic			b_type;
    input logic         op_jal;
    input logic         op_jalr;
    input logic[20:0]	imm21_j;
    input logic[11:0]	imm12_i_s;
    input logic[12:0]	imm13_b;

	input logic[2:0]	funct3;
	input logic[31:0]	sub_result;
	input logic			sub_sign;

	input logic[31:0]	pc_current;
	input logic[31:0]	link_reg_in;

    output logic[31:0]	pc_return;
    output logic[31:0]	pc_jmpto;
	output logic		jmp_occur;

//Signal
	//B/J Executing
	logic		wJmp;
	logic		rJumping;
	//Comparison
	logic 	wCond;
	logic	wNEq;
	logic	wLt;
	logic	wGt;
	//PC reg of currently exe instr
	logic[31:0]	rPc_current_reg1;
	logic[31:0]	rPc_current_reg2;

//Comb Logic
	assign wNEq = |{sub_sign,sub_result};
	assign wLt = sub_sign & wNEq;
	assign wGt = !sub_sign & wNEq;
	
	assign wJmp = op_jal | op_jalr | (b_type & wCond);
	assign jmp_occur = wJmp | rJumping;

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

	always_comb begin : uJmp
		if(op_jal) begin
			pc_jmpto = rPc_current_reg2 + {{10{imm21_j[20]}},imm21_j,1'b0};
		end else if(op_jalr) begin
			pc_jmpto = (link_reg_in + {{20{imm12_i_s[11]}},imm12_i_s}) & {{31{1'b1}},1'b0}; 
		end else if (b_type & wCond) begin
			pc_jmpto = rPc_current_reg2 + {{10{imm13_b[12]}},imm13_b,1'b0};
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
		rPc_current_reg1 <= pc_current;
		rPc_current_reg2 <= rPc_current_reg1;
	end

	always @(posedge clk) begin
		if(!rstB) begin
			rJumping <= 1'b0;
		end else begin
			rJumping <= wJmp;
		end
	end

    
endmodule