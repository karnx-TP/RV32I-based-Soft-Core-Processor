module rv32i_top_Soc(
    clk,
    rstB,
	progEnB,

    rx,
    tx,
	pin,

	statusLED,
	rx_echo
);
//Parameter
	localparam MEM_SIZE = 32767; //Byte
	localparam INSTRW = $clog2(MEM_SIZE);
	localparam RAM_DEPTH_WORD = 1024; //Word
	localparam RAM_ADDRW = $clog2(RAM_DEPTH_WORD);
	localparam XLEN = 32; //1 word = 32bit
//GenVar
	genvar i;

//Port
    input logic    	 	clk;
    input logic     	rstB;
	input logic			progEnB;
    input logic     	rx;
    output logic    	tx;
	inout logic[7:0]	pin;
	output logic		statusLED;
	output logic		rx_echo;

//BUS ID
	localparam PERI_SIZE = 3;
	localparam RAM = 0;
	localparam UART = 1;
	localparam PORT = 2;

//Wire
	logic					rCoreClkEn;
    logic[XLEN-1:0]         wCorePc;
    logic[XLEN-1:0]         wCoreInst;
	logic[XLEN-1:0]         wCoreAddr;
    logic[XLEN-1:0]         wCoreDataOut;
    logic	            	wCoreWrEn;
	logic	            	wCoreRdEn;
	logic[3:0]         		wCoreRamMode;
    logic[XLEN-1:0]	        wCoreDataIn;
	logic		        	wCoreDataInEn;
	//Uart
	logic[RAM_ADDRW:0]      wUartAddr;
	logic					wUartRdEn;
	logic[7:0]				wUartData;
	logic					wUartRxFfEmpty;
	//Prog
	logic					progEn;
	logic					wProgWrEn;
	logic[7:0]				wProgWrData;
	logic[31:0]				wProgAddr;
	logic					wProgRdEn;
	logic					wProgMemFull;
	logic[INSTRW-1:0]		wProgRamAddr;
	//IO Port
	logic[7:0]				wPort_ddr;
	logic[7:0]				wPort_pvl;
	wire[7:0]				wPort_pin;

//Output
	assign progEn = !progEnB;
	assign statusLED = progEn;

//DataBus - Peripheral
    logic[0:PERI_SIZE-1][XLEN-1:0]    	wDataBus;
    logic[0:PERI_SIZE-1]    			wDataBusEn;
	logic								wRamRdEn;
	logic								wPeriRdEn;

//DataBus
	assign wCoreDataIn = 	(wDataBusEn[RAM]) ? wDataBus[RAM] :
							(wDataBusEn[UART]) ? wDataBus[UART] :
							(wDataBusEn[PORT]) ? wDataBus[PORT] :
							0;
	assign wCoreDataInEn = |wDataBusEn;

//RAM
	assign wRamRdEn = wCoreRdEn & (wCoreAddr[XLEN-1:RAM_ADDRW] == 0);
	assign wPeriRdEn = wCoreRdEn & (|wCoreAddr[XLEN-1:RAM_ADDRW]);

//Core
	always @(posedge clk ) begin
		if(!rstB)begin
			rCoreClkEn = 1'b0;
		end else begin
			rCoreClkEn = !progEn;
		end
	end

//Module Port Map
    rv32i_core core (
        .clk(clk),
        .rstB(rstB),
        .clkEn(rCoreClkEn),

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

		.addr(wUartAddr),
        .wrData(wCoreDataOut),
        .wrEn(wCoreWrEn),
        .rdEn(wUartRdEn),
        .dataOut(wDataBus[UART]),
        .outEn(wDataBusEn[UART]),
		.rxFfEmpty(wUartRxFfEmpty)
	);
	assign wUartAddr = progEn ? {11'h402} :
						wCoreAddr[RAM_ADDRW:0];
	assign wUartRdEn =  progEn ? wProgRdEn :
						wPeriRdEn;

	programmer #(
		.MEM_SIZE(MEM_SIZE)
	) programmer_module (
		.clk(clk),
		.rstB(rstB),
		.progEn(progEn),

		.memWrEn(wProgWrEn), 
		.memAddr(wProgAddr),
		.memData(wProgWrData),

		.rxFfEmpty(wUartRxFfEmpty), 
		.rxRdEn(wProgRdEn),
		.rxData(wDataBus[UART][7:0]),
		.wMemFull(wProgMemFull)
	);

	prog_ram_w8r32	 #(
		.MEM_SIZE(MEM_SIZE)
	) prog_ram (
		.clk(clk), 
		.we(wProgWrEn), 
		.addr(wProgRamAddr), 
		.din(wProgWrData), 
		.dout(wCoreInst)
	);
	assign wProgRamAddr = 	progEn ? wProgAddr[INSTRW-1:0] :
							wCorePc[INSTRW-1:0];

	io_port #(
		.DDR_ADDR(11'h404),
		.PVL_ADDR(11'h405),
		.PIN_ADDR(11'h406),
		.PORT_SIZE(8)
	) io_port_module (
		.clk(clk),
		.rstB(rstB),

		.addr(wCoreAddr[RAM_ADDRW:0]),
		.wrData(wCoreDataOut),
		.wrEn(wCoreWrEn),
		.rdEn(wPeriRdEn),
		.dataOut(wDataBus[PORT]),
		.outEn(wDataBusEn[PORT]),

		.ddr(wPort_ddr),
		.pvl(wPort_pvl),
		.pin(wPort_pin)
	);
	generate
		for (i = 0;i<8;i=i+1) begin : GEN_PIN
			// assign pin[i] = wPort_ddr[i] ? wPort_pvl[i] : 1'bz;
			// assign wPort_pin[i] = pin[i];
			IOBUF iobuf_inst (
			.I (wPort_pvl[i]),
			.O (wPort_pin[i]),
			.T (~wPort_ddr[i]),
			.IO(pin[i])
			);
		end
	endgenerate

	single_tx rx_echo_module (
		.clk(clk),
		.rstB(rstB),

		.wrEn(wProgWrEn),
		.wrData(wProgWrData),

		.tx(rx_echo)
	);
	


endmodule