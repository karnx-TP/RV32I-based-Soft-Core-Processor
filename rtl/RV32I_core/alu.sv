//----------------------------------------
// File : alu.sv
// Author : Thitipong Pav
// Desc : alu for rv32i core
//----------------------------------------


module ALU32bits (
	r_type,
    i_type,
    b_type,

    funct3,
    funct7,

    op_consShf,

    sub_sign_extEn,
    
    A,
    B,
    out,
    flag
    
);
//Port 
	input logic        r_type;
    input logic        i_type;
    input logic        b_type;
	input logic[2:0]   funct3;
    input logic[6:0]   funct7;
    input logic        op_consShf;
    input logic        sub_sign_extEn;
    input logic[31:0]   A;
    input logic[31:0]   B;
    output logic[31:0]  out;
    output logic        flag;

//Signal Declaration
    logic[32:0]     wOut_int;
	logic[3:0]		wfunct;
    logic           wExtA;
    logic           wExtB;

//Comb
    assign out = wOut_int[31:0];
    assign flag = wOut_int[32];
	assign wfunct = (r_type | op_consShf | b_type) ? {funct3,funct7[5]} : {funct3,1'b0};
    assign wExtA = sub_sign_extEn ? A[31] : 1'b0;
    assign wExtB = sub_sign_extEn ? B[31] : 1'b0;

    always_comb begin : uOut
        case (wfunct)
            4'b0000	:	wOut_int =  {1'b0,A} + {1'b0,B}; //ADD
			4'b0001	:	wOut_int =  {wExtA,A} - {wExtB,B}; //SUB w sign-ext
			4'b0010	:	wOut_int =  {1'b0,A<<(B[4:0])}; //SLL
			4'b0100	:	wOut_int =  {{32{1'b0}},($signed(A)<$signed(B))}; //SLT
			4'b0110	:	wOut_int =  {{32{1'b0}},(A<B)}; //SLTU
			4'b1000	:	wOut_int =  {1'b0,A^B}; //XOR
            4'b1010	:	wOut_int =  {1'b0,A>>(B[4:0])}; //SRL
            4'b1011	:	wOut_int =  {1'b0,$signed(A)>>>(B[4:0])}; //SRA
            4'b1100	:	wOut_int =  {1'b0,A|B}; //OR
            4'b1110	:	wOut_int =  {1'b0,A&B}; //AND
            default :   wOut_int = 33'b0;
        endcase
    end
    
endmodule