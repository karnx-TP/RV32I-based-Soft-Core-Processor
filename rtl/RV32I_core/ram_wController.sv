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
	logic[XLEN-1:0]				rDataOut;
	logic						rByteEn;
	logic						rHalfEn;
	logic						rUnsignedEn;
	logic						rByteEn2;
	logic						rHalfEn2;
	logic						rUnsignedEn2;
	logic						rRdEn;
	logic[3:0]					wByteSel;
	logic[3:0]					wHalfSel;
	logic[XLEN-1:0]				wDataIn;

//RAM
	bram_sp_byte #(
		.DEPTH(DEPTH),
		.XLEN(XLEN)
	) BRAM (
		.clk(clk),
		.enA(1'b1),
		.wrEn(wrEn),
		.addr(addr),
		.dataIn(wDataIn),
		.byte_we(wRamByte_we),
		.dataOut(RamDataOut)
	);
					 
//Byte Enable Wr
	always_comb begin : ByteSelDec
		case (addr[1:0])
			2'b00 : wByteSel <= 4'b0001;
			2'b01 : wByteSel <= 4'b0010;
			2'b10 : wByteSel <= 4'b0100;
			2'b11 : wByteSel <= 4'b1000;
			default: wByteSel <= 4'b0001;
		endcase
	end
	always_comb begin : HalfSelDec
		case (addr[1:0])
			2'b00 : wHalfSel <= 4'b0011;
			2'b01 : wHalfSel <= 4'b0110;
			2'b10 : wHalfSel <= 4'b1100;
			2'b11 : wHalfSel <= 4'b1100;
			default: wHalfSel <= 4'b0011;
		endcase
	end
	assign wRamByte_we = byteEn ? wByteSel :
						halfEn ? wHalfSel :
						4'b1111;

//Data In
	always_comb begin : DataInByte
		if(byteEn)begin
			case (addr[1:0])
				2'b00 : wDataIn <= wrData;
				2'b01 : wDataIn <= {16'h0000,wrData[7:0],8'h00};
				2'b10 : wDataIn <= {8'h00,wrData[7:0],16'h0000};
				2'b11 : wDataIn <= {wrData[7:0],24'h000000};
				default: wDataIn <= wrData;
			endcase
		end else if(halfEn)begin
			case (addr[1:0])
				2'b00 : wDataIn <= wrData;
				2'b01 : wDataIn <= {8'h00,wrData[15:0],8'h00};
				2'b10 : wDataIn <= {wrData[15:0],16'h0000};
				2'b11 : wDataIn <= {wrData[15:0],16'h0000};
				default: wDataIn <= wrData;
			endcase
		end else begin
			wDataIn <= wrData;
		end
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
	assign dataOut = rDataOut;
	always @(posedge clk) begin
		rDataOut <= (rByteEn2) ? {{(XLEN-8){(!rUnsignedEn2)&RamDataOut[7]}},RamDataOut[7:0]} :
					 (rHalfEn2) ? {{(XLEN/2){(!rUnsignedEn2)&RamDataOut[15]}},RamDataOut[15:0]} :
					 RamDataOut;
	end
	
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