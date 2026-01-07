module rv32i_core (
    clk,
    rstB,
    clkEn,

    pc,
    inst_in,

	rx,
	tx
);
//Port
    input logic     clk;
    input logic     rstB;
    input logic     clkEn;
    output logic[31:0]  pc;
    input logic[31:0]   inst_in;
	input logic		rx;
	output logic	tx;

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
    logic           wPcCondEn;
    logic[31:0]     wPcNextCond;
    logic[31:0]     wPcReturn;
    logic           wJmp_occur;
    //Hazard Handle
    logic           wHazardRs1;
    logic           wHazardRs2;
    logic[4:0]      rReg_d;
    //ALU
    logic[31:0]     wAluA;
    logic[31:0]     wAluB;
    logic[2:0]      wFunct3_aluIn;
    logic[6:0]      wFunct7_aluIn;
    logic           wAluSextEn;
    //Reg
    logic[31:0]     rWrData;
    logic           wRegWrEn;
    logic           rRegWrEn;
    logic[31:0]     wRegWrData;
	logic[31:0]     wRs1Data;
    logic[31:0]     wRs2Data;
    //Ram
    logic           rOp_memLd;
	logic[31:0]		wRamAddr;
	logic[31:0]		wRamWrData;
	logic			wRamWrEn;
    logic			wRamRdEn;
	logic[31:0]		wRamDataOut;
	logic		    wRamByteEn;
    logic			wRamHalfEn;
    logic			wRamWordEn;
    logic			wRamUnsignedEn;
	//UART
	logic[31:0]		wUartDataOut;

    //DataBus - Peripheral
    logic[0:1][31:0]    wDataBus;
    logic[0:1]    		wDataBusEn;
	logic				wPeriRdEn;

//Module Declaration
    pc_reg rpc(
        .clk(clk),
        .rstB(rstB),
        .clkEn(clkEn),
        
        .condEn(wPcCondEn),
        .next_pc_cond(wPcNextCond),
        .pc_out(wPc_int)

    );
    inst_dec dec (       
        .clk(clk),
        .rstB(rstB),

        .instruction_in(inst_in),
        .jmp(wJmp_occur),

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
    reg_file reg_module (
        .clk(clk),
        .rstB(rstB),

        .wrEn(wRegWrEn),
        .wrData(wRegWrData),
        .wrAddr(rReg_d),

        .rdR1Addr(reg_s1),
        .rdR2Addr(reg_s2),

        .r1out(wRs1Data),
        .r2out(wRs2Data)
    );
    branch_unit brancher (
        .clk(clk),
	    .rstB(rstB),
        .b_type(b_type),
        .op_jal(op_jal),
        .op_jalr(op_jalr),
        .imm21_j(imm21_j),
        .imm12_i_s(imm12_i_s),
        .imm13_b(imm13_b),

        .funct3(funct3),
        .sub_result(wAluOut),
	    .sub_sign(wAluFlag),

        .pc_current(wPc_int),
        .link_reg_in(wRs1Data),

        .pc_return(wPcReturn),
        .pc_jmpto(wPcNextCond),
        .jmp_occur(wJmp_occur)
    );
	ram_Controller #(
        .DEPTH(1024),
        .XLEN(32)
    ) ram (
        .clk(clk),

        .addr(wRamAddr[9:0]),
        .wrData(wRamWrData),
        .wrEn(wRamWrEn),
        .rdEn(wRamRdEn),
        .dataOut(wRamDataOut),
        .outEn(wDataBusEn[RAM]),

        .byteEn(wRamByteEn),
        .halfEn(wRamHalfEn),
        .wordEn(wRamWordEn),
        .unsignedEn(wRamUnsignedEn)
    );
	uart #(
    	.BAUD_CYCLE(868),
    	.LSB_FIRST(1'b1),	
		.UDR_ADDR(11'h502),
		.UCR_ADDR(11'h503)
	) uart_module (
		.rx(rx),
		.tx(tx),
		
		.clk(clk),
		.rstB(rstB),

		.addr(wRamAddr[11:0]),
        .wrData(wRamWrData),
        .wrEn(wRamWrEn),
        .rdEn(wPeriRdEn),
        .dataOut(wUartDataOut),
        .outEn(wDataBusEn[UART])
	);

//DataBus
	assign wDataBus = 	(wDataBusEn[RAM]) ? wRamDataOut :
						(wDataBusEn[UART]) ? wUartDataOut :
						0;

//Comb Logic
    //PC
    assign pc = wPc_int;
    assign wPcCondEn = op_jal | op_jalr | b_type;

    //Hazard Handle
    assign wHazardRs1 = (rReg_d == reg_s1);
    assign wHazardRs2 = (rReg_d == reg_s2);

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
        if(r_type | b_type | op_consShf | op_intRegImm) begin
			wAluA = wHazardRs1 ? rWrData : wRs1Data;
        end else if (op_auipc) begin
            wAluA = wPc_int;
        end else begin
			wAluA = 0;
		end

		//B
		if(r_type | b_type) begin
			wAluB = wHazardRs2 ? rWrData : wRs2Data;
		end else if(op_consShf | op_intRegImm) begin
			wAluB = {{20{imm12_i_s[11]}},imm12_i_s}; //Sign-Extended
        end else if (op_auipc) begin
            wAluB = imm32_u;
        end else begin
			wAluB = 0;
		end
    end

    //Reg
	always_comb begin : u_wrReg
		if (rOp_memLd) begin
            wRegWrData = wDataBus;
        end else begin
            wRegWrData = rWrData;
        end 
	end
	assign wRegWrEn = rRegWrEn;

    //Mem RAM
    assign wRamAddr = (op_memLd | op_memSt) ? wRs1Data + imm12_i_s : {32{1'b0}};
    assign wRamWrEn = (rstB) & (op_memSt);
    assign wRamWrData = wHazardRs2 ? rWrData : wRs2Data;
	assign wRamRdEn = op_memLd & (wRamAddr[31:10] == 0);
	assign wPeriRdEn = op_memLd & (|wRamAddr[31:10]);
    assign wRamByteEn = (funct3[1:0] == 2'b00);
    assign wRamHalfEn = (funct3[1:0] == 2'b01);
    assign wRamWordEn = (funct3[1:0] == 2'b10);
    assign wRamUnsignedEn = funct3[2];

//Sequencial
    //Hazard Handle
    always @(posedge clk) begin
        rReg_d <= reg_d;
    end

    //Reg
    always @(posedge clk) begin
        if(op_intRegImm | op_intRegReg | op_consShf | op_auipc) begin //ALU
			rWrData <= wAluOut;
		end else if(op_lui) begin //Load upper imm
			rWrData <= imm32_u;
        end else if (op_jal | op_jalr) begin
            rWrData <= wPcReturn;
        end else begin	
			rWrData <= 0;
		end
    end

    always @(posedge clk) begin
        if(!rstB)begin
            rRegWrEn <= 1'b0;
        end else begin
            rRegWrEn <= (rstB) & (op_jalr | op_memLd | op_intRegImm | op_intRegReg | op_consShf | op_lui | op_jal | op_auipc); 
        end
    end

    always @(posedge clk) begin
        rOp_memLd <= op_memLd;
    end

endmodule