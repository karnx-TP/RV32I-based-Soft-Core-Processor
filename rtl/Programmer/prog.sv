module programmer #(
	parameter MEM_SIZE = 32767
)(
    clk,
    rstB,
    progEn,

    memWrEn,
    memAddr,
    memData,

    rxFfEmpty,
    rxRdEn,
    rxData,
	uartOutEn,
	wMemFull
);

//Port
    input   logic       clk;
    input   logic       rstB;
    input   logic       progEn;

    output  logic       memWrEn;
    output  logic[31:0]	memAddr;
    output  logic[7:0]	memData;

    input   logic       rxFfEmpty;
    output  logic       rxRdEn;
    input   logic[7:0]  rxData;
	input	logic		uartOutEn;
	output logic		wMemFull;

//Signal
    logic           rRxRdEn;
	logic[31:0]		rMemAddr;
	
	

//Combinational
	assign wMemFull = (rMemAddr == MEM_SIZE);
    assign rxRdEn = progEn & !rxFfEmpty & !rRxRdEn; //No Burst Read
	assign memWrEn = uartOutEn & !wMemFull;
	assign memAddr = rMemAddr;
	assign memData = {8{progEn}} & rxData; 

//Sequencial
	always @(posedge clk ) begin
		rRxRdEn <= rxRdEn & !wMemFull;
	end

	always @(posedge clk ) begin
		if(!progEn | !rstB)begin
			rMemAddr <= 0;
		end else if(uartOutEn & !wMemFull)begin
			rMemAddr <= rMemAddr + 1;
		end
	end


endmodule