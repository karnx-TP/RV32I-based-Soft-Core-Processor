//----------------------------------------
// File : reg_file_sky130sram.sv
// Author : Thitipong Pav
// Desc : SRAM based register, BRAM synthesizable on FPGA, Sky130-compatible interface
//----------------------------------------

module reg_file_sky130sram (
    clk,
    rstB,

    wrEn,
    wrData,
    wrAddr,

    rdR1Addr,
    rdR2Addr,

    r1out,
    r2out
);
//Port
    input logic             clk;
    input logic             rstB;
    input logic             wrEn;
    input logic[31:0]       wrData;
    input logic[4:0]        wrAddr;

    input logic[4:0]        rdR1Addr;
    input logic[4:0]        rdR2Addr;

    output logic[31:0]      r1out;
    output logic[31:0]      r2out;

//Signal
	logic[4:0]        		rRdR1Addr;
	logic[4:0]        		rRdR2Addr;
	logic[31:0]				wR1out;
	logic[31:0]				wR2out;
	logic					wWrEn;

//Port Map
	sky130_sram_1kbyte_1rw1r_32x256_8 #(
		.NUM_WMASKS(4),
		.DATA_WIDTH(32),
		.ADDR_WIDTH(8)
	) sram_reg1 (
		// Port 0: RW
		.clk0(clk),
		.csb0(1'b0),
		.web0(wWrEn),
		.wmask0(4'b1111),
		.addr0({3'b000,wrAddr}),
		.din0(wrData),
		.dout0(),
		// Port 1: R
		.clk1(!clk),
		.csb1(1'b0),
		.addr1({3'b000,rdR1Addr}),
		.dout1(wR1out)
	);

	sky130_sram_1kbyte_1rw1r_32x256_8 #(
		.NUM_WMASKS(4),
		.DATA_WIDTH(32),
		.ADDR_WIDTH(8)
	) sram_reg2 (
		// Port 0: RW
		.clk0(clk),.csb0(1'b0),.web0(wWrEn),.wmask0(4'b1111),.addr0({3'b000,wrAddr}),.din0(wrData),.dout0(),
		// Port 1: R
		.clk1(!clk),.csb1(1'b0),.addr1({3'b000,rdR2Addr}),.dout1(wR2out)
	);

//Comb
	assign r1out = (rRdR1Addr == 0) ? 32'h00000000 : wR1out;
	assign r2out = (rRdR2Addr == 0) ? 32'h00000000 : wR2out;
	assign wWrEn = (wrAddr == 0) ? 1'b1 : !wrEn;

//Sequencial
	always @(posedge clk) begin
		rRdR1Addr <= rdR1Addr;
		rRdR2Addr <= rdR2Addr;
	end

    
endmodule