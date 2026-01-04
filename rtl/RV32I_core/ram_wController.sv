module ram_Controller #(
    parameter DEPTH = 4096,
	parameter XLEN = 32
) (
    clk,

    addr,
    wrData,
    wrEn,
    dataOut,

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
	output logic[XLEN-1:0]			dataOut;

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

//reg for ByteEn
	always @(posedge clk) begin
		rByteEn <= byteEn;
		rHalfEn <= halfEn;
		rUnsignedEn <= unsignedEn;
	end

//DataOut
	assign dataOut = (rByteEn) ? {{(XLEN-8){(!rUnsignedEn)&RamDataOut[7]}},RamDataOut[7:0]} :
					 (rHalfEn) ? {{(XLEN/2){(!rUnsignedEn)&RamDataOut[15]}},RamDataOut[15:0]} :
					 RamDataOut;
					 
//Byte Enable
	assign wRamByte_we = byteEn ? 4'b0001 :
						halfEn ? 4'b0011 :
						4'b1111;

    
endmodule