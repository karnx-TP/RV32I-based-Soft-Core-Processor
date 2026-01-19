//----------------------------------------
// File : ram_Controller.sv
// Author : Thitipong Pav
// Desc : ram controller module
//----------------------------------------

module ram_Controller #(
    parameter DEPTH = 4096,
	parameter XLEN = 32
) (
    clk,

    addr,
    wrData,
    wrEn,
	rdEn,
    dataOut,
	outEn,

    byteEn,
    halfEn,
    wordEn,
    unsignedEn
    
);

localparam ADDRWIDTH = $clog2(DEPTH);
//Port
    input logic						clk;
	input logic[ADDRWIDTH-1:0]		addr;
	input logic[XLEN-1:0]			wrData;
	input logic						wrEn;
	input logic						rdEn;
	output logic[XLEN-1:0]			dataOut;
	output logic					outEn;

	input logic						byteEn;
    input logic						halfEn;
    input logic						wordEn;
    input logic						unsignedEn;

//Signal
	//RAM I/F
	logic[3:0]					wRamByte_we;
    logic[XLEN-1:0]				RamDataOut;
	logic						rByteEn;
	logic						rHalfEn;
	logic						rUnsignedEn;
	logic						rByteEn2;
	logic						rHalfEn2;
	logic						rUnsignedEn2;
	logic						rRdEn;
	logic						rWrEn;

//RAM
	bram_sp_byte #(
		.DEPTH(DEPTH),
		.XLEN(XLEN)
	) BRAM (
		.clk(clk),
		.enA(1'b1),
		.wrEn(wrEn),
		.addr(addr),
		.dataIn(wrData),
		.byte_we(wRamByte_we),
		.dataOut(RamDataOut)
	);

//reg wrEn
	always @(posedge clk ) begin
		rWrEn <= wrEn;
	end

//reg for ByteEn
	always @(posedge clk) begin
		rByteEn <= byteEn;
		rHalfEn <= halfEn;
		rUnsignedEn <= unsignedEn;

		rByteEn2 <= rByteEn;
		rHalfEn2 <= rHalfEn;
		rUnsignedEn2 <= rUnsignedEn;
	end

//DataOut
	assign dataOut = (rByteEn2) ? {{(XLEN-8){(!rUnsignedEn2)&RamDataOut[7]}},RamDataOut[7:0]} :
					 (rHalfEn2) ? {{(XLEN/2){(!rUnsignedEn2)&RamDataOut[15]}},RamDataOut[15:0]} :
					 RamDataOut;
					 
//Byte Enable
	assign wRamByte_we = byteEn ? 4'b0001 :
						halfEn ? 4'b0011 :
						4'b1111;

//OutEn
	always @(posedge clk ) begin
		rRdEn <= rdEn;
		if(rRdEn)begin
			outEn <= 1'b1;
		end else begin
			outEn <= 1'b0;
		end
		
	end

    
endmodule