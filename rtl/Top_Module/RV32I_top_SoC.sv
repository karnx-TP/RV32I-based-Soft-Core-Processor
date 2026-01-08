module rv32i_top_Soc(
    clk,
    rstB,
    clkEn,

    rx,
    tx
);
//Parameter
	localparam MEM_SIZE = 32767; //Byte
	localparam INSTRW = $clog2(MEM_SIZE);
	localparam RAM_DEPTH_WORD = 1024; //Word
	localparam RAM_ADDRW = $clog2(RAM_DEPTH_WORD);
	localparam XLEN = 32; //1 word = 32bit
//Port
    input logic     clk;
    input logic     rstB;
    input logic     clkEn;
    input logic     rx;
    output logic    tx;

//BUS ID
	localparam RAM = 0;
	localparam UART = 1;

//Wire
    logic[XLEN-1:0]         wCorePc;
    logic[XLEN-1:0]         wCoreInst;
	logic[XLEN-1:0]         wCoreAddr;
    logic[XLEN-1:0]         wCoreDataOut;
    logic	            wCoreWrEn;
	logic	            wCoreRdEn;
	logic[3:0]         wCoreRamMode;
    logic[XLEN-1:0]	        wCoreDataIn;
	logic		        wCoreDataInEn;

//DataBus - Peripheral
    logic[0:1][XLEN-1:0]    wDataBus;
    logic[0:1]    		wDataBusEn;
	logic				wRamRdEn;
	logic				wPeriRdEn;

//DataBus
	assign wCoreDataIn = 	(wDataBusEn[RAM]) ? wDataBus[RAM] :
							(wDataBusEn[UART]) ? wDataBus[UART] :
							0;
	assign wCoreDataInEn = |wDataBusEn;

//RAM
	assign wRamRdEn = wCoreRdEn & (wCoreAddr[XLEN-1:RAM_ADDRW] == 0);
	assign wPeriRdEn = wCoreRdEn & (|wCoreAddr[XLEN-1:RAM_ADDRW]);

//Module Port Map
    rv32i_core core (
        .clk(clk),
        .rstB(rstB),
        .clkEn(clkEn),

        .pc(wCorePc),
        .inst_in(wCoreInst),

        .addr(wCoreAddr),
        .dataBusOut(wCoreDataOut),
        .wrEn(wCoreWrEn),
        .rdEn(wCoreRdEn),
        .RamMode(wCoreRamMode),
        .dataBusIn(wCoreDataIn),
        .dataBusInEn(wCoreDataInEn)
    );
	Program_Mem #(
		.MEM_SIZE(MEM_SIZE)
	) mem (
    .clk(clk), .we(1'b0), .addr(wCorePc[INSTRW-1:0]), .din({32{1'b0}}), .dout(wCoreInst)
	);
	ram_Controller #(
        .DEPTH(RAM_DEPTH_WORD),
        .XLEN(XLEN)
    ) ram (
        .clk(clk),

        .addr(wCoreAddr[RAM_ADDRW-1:0]),
        .wrData(wCoreDataOut),
        .wrEn(wCoreWrEn),
        .rdEn(wRamRdEn),
        .dataOut(wDataBus[RAM]),
        .outEn(wDataBusEn[RAM]),

        .byteEn(wCoreRamMode[3]),
        .halfEn(wCoreRamMode[2]),
        .wordEn(wCoreRamMode[1]),
        .unsignedEn(wCoreRamMode[0])
    );
	uart #(
    	.BAUD_CYCLE(868),
    	.LSB_FIRST(1'b1),	
		.UDR_ADDR(11'h402),
		.UCR_ADDR(11'h403)
	) uart_module (
		.rx(rx),
		.tx(tx),
		
		.clk(clk),
		.rstB(rstB),

		.addr(wCoreAddr[RAM_ADDRW:0]),
        .wrData(wCoreDataOut),
        .wrEn(wCoreWrEn),
        .rdEn(wPeriRdEn),
        .dataOut(wDataBus[UART]),
        .outEn(wDataBusEn[UART])
	);

endmodule