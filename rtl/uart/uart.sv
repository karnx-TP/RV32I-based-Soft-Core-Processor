module uart #(
    parameter BAUD_CYCLE = 868,
    parameter LSB_FIRST = 1'b1,	
	parameter UDR_ADDR = 11'h502,
	parameter UCR_ADDR = 11'h503
)(
    rx,
    tx,
    
    clk,
    rstB,

    addr,
    wrData,
    wrEn,
	rdEn,
    dataOut,
	outEn
);
//Port
	input logic			rx;
	output logic		tx;
	input logic			clk;
	input logic			rstB;
	input logic[11:0]	addr;
	input logic[31:0]	wrData;
	input logic			wrEn;
	input logic			rdEn;
	output logic[31:0]	dataOut;
	output logic		outEn;

//Module wire
	logic		wRxFfDataEn;
	logic[7:0]	wRxFfDataOut;

	logic		wTxFfRdEn;
	logic[7:0]  wFFTxData;
	logic       wTxFfEmpty;
	logic       wRxFfEmpty;
	logic       wRxFfFull;
	logic		wTxFfFull;

	logic[7:0]	wFfrxDataOut;
	logic		wFfrxRdEn;

	logic[7:0]	wFftxDataIn;
	logic		wFftxWrEn;

//Module
	uart_rx #(
		.BAUD_CYCLE(BAUD_CYCLE), //BAUD_RATE = 115200 for clk=10n
		.LSB_FIRST(LSB_FIRST)
	) rx_module (
		.clk(clk),
		.rstB(rstB),

		.rx(rx),
		
		.dataEn(wRxFfDataEn),
		.dataOut(wRxFfDataOut),
		.FfFull(wRxFfFull)
	);

	sync_fifo #(
		.WIDTH(8),
		.DEPTH(256)
	) ffrx (
		.clk(clk),
		.rst(rstB),

		.data_in(wRxFfDataOut),
		.FfWrEn(wRxFfDataEn),

		.FfRdEn(wFfrxRdEn),
		.data_out(wFfrxDataOut),

		.FfEmpty(wRxFfEmpty),
		.FfFull(wRxFfFull)
	);
	
	uart_tx_ff #(
		.BAUD_CYCLE(BAUD_CYCLE), //BAUD_RATE = 115200 for clk=10n
		.LSB_FIRST(LSB_FIRST)
	) tx_module (
		.clk(clk),
		.rstB(rstB),

		.ffEmpty(wTxFfEmpty),
		.rdEn(wTxFfRdEn),
		.rdData(wFFTxData),
		
		.tx(tx)
	);

	sync_fifo #(
		.WIDTH(8),
		.DEPTH(256)
	) fftx (
		.clk(clk),
		.rst(rstB),

		.data_in(wFftxDataIn),
		.FfWrEn(wFftxWrEn),

		.FfRdEn(wTxFfRdEn),
		.data_out(wFFTxData),

		.FfEmpty(wTxFfEmpty),
		.FfFull(wTxFfFull)
	);

//Signal
	logic[31:0]		wUartDataout;
	reg[31:0]		rUCR;
	reg[31:0]		rAddr;

//Combinational
	//Read Rx,Reg
	assign dataOut = wUartDataout;
	assign wFfrxRdEn = (addr == UDR_ADDR) ? rdEn :
					   1'b0;
	always_comb begin : RdMuxDataOut
		case (rAddr)
			UDR_ADDR : begin
				wUartDataout = {{24{1'b0}},wFfrxDataOut};
			end
			UCR_ADDR : begin
				wUartDataout = {{30{1'b0}},rUCR};
			end
			default: wUartDataout = 0;
		endcase
	end

	//Write For TX
	assign wFftxWrEn = (addr == UDR_ADDR) ? wrEn :
						1'b0;
	assign wFftxDataIn = (addr == UDR_ADDR) ? wrData :
						0;

//Sequencial 
	//Read Rx,Reg
	always @(posedge clk ) begin
		if(rdEn)begin
			outEn <= 1'b1;
		end else begin
			outEn <= 1'b0;
		end
	end

	always @(posedge clk ) begin
		rUCR <= {wRxFfEmpty,wTxFfFull};
	end

	always @(posedge clk ) begin
		rAddr <= addr;
	end



    
endmodule