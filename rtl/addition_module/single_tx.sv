module single_tx (
	clk,
	rstB,

	wrEn,
	wrData,

	tx
);
//Port	
	input	logic			clk;
	input	logic			rstB;

	input	logic			wrEn;
	input	logic[7:0]		wrData;

	output	logic			tx;

//Module wire
	logic			wTxFfRdEn;
	logic[7:0]		wFFTxData;
	logic			wTxFfFull;
	logic			wFfEmpty;
	
//Module
	sync_fifo #(
		.WIDTH(8),
		.DEPTH(256)
	) tx_fifo (
		.clk(clk),
		.rst(rstB),

		.data_in(wrData),
		.FfWrEn(wrEn),

		.data_out(wFFTxData),
		.FfRdEn(wTxFfRdEn),
		.FfEmpty(wFfEmpty),
		.FfFull(wTxFfFull)
	);
	uart_tx_ff #(
		.BAUD_CYCLE(868) //BAUD_RATE = 115200 for clk=10n
	) tx_module (
		.clk(clk),
		.rstB(rstB),


		.ffEmpty(wFfEmpty),
		.rdEn(wTxFfRdEn),
		.rdData(wFFTxData),

		.tx(tx)
	);
	
endmodule