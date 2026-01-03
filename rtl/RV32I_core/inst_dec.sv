module inst_dec (
    
    instruction_in,

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
    input   logic[31:0]      instruction_in;

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
    

//Combinational Circuit
    assign Op_code      = instruction_in[6:0]; 

	assign op_lui       = (Op_code == 7'b0110111) ? 1'b1 : 1'b0;
    assign op_auipc     = (Op_code == 7'b0010111) ? 1'b1 : 1'b0;
    assign op_jal       = (Op_code == 7'b1101111) ? 1'b1 : 1'b0;
    assign op_jalr      = (Op_code == 7'b1100111) ? 1'b1 : 1'b0;
    assign op_branch    = (Op_code == 7'b1100011) ? 1'b1 : 1'b0; 
    assign op_memLd     = (Op_code == 7'b0000011) ? 1'b1 : 1'b0;
    assign op_intRegImm = (Op_code == 7'b0010011) && (funct3 != 3'b001 && funct3 != 3'b101) ? 1'b1 : 1'b0;
    assign op_consShf   = (Op_code == 7'b0010011) && (funct3 == 3'b001 || funct3 == 3'b101) ? 1'b1 : 1'b0;
    assign op_memSt     = (Op_code == 7'b0100011) ? 1'b1 : 1'b0;
    assign op_intRegReg = (Op_code == 7'b0110011) ? 1'b1 : 1'b0;
    assign op_efence    = (Op_code == 7'b0001111) ? 1'b1 : 1'b0;
    assign op_ecb     	= (Op_code == 7'b1110011) ? 1'b1 : 1'b0;


    assign r_type       = op_intRegReg;
    assign i_type       = op_jalr | op_memLd | op_intRegImm | op_consShf | op_efence | op_ecb;
    assign s_type       = op_memSt;
    assign b_type       = op_branch;
    assign j_type       = op_jal;
    assign u_type       = op_lui | op_auipc;

    assign funct3       = instruction_in[14:12];
    assign funct7       = instruction_in[31:25];
    assign reg_d        = instruction_in[11:7];
    assign reg_s1       = instruction_in[19:15];
    assign reg_s2       = instruction_in[24:20];

    assign imm12_i_s    = (i_type) ? instruction_in[31:20] :
                          (s_type) ? {instruction_in[31:25],instruction_in[11:7]} :
                          12'h000;
    assign imm13_b      = {instruction_in[31],instruction_in[7],instruction_in[30:25],instruction_in[11:8],1'b0}; //B
    assign imm32_u      = {instruction_in[31:12],12'h000}; //U
    assign imm21_j      = {instruction_in[31],instruction_in[19:12],instruction_in[20],instruction_in[30:21],1'b0}; //J          
    
endmodule