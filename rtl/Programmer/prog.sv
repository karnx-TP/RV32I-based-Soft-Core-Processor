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

//Signal
    logic           rRxRdEn;
	logic			wMemFull;
	

//Combinational
	assign wMemFull = (rMemAddr == MEM_SIZE);
    assign rxRdEn = progEn & rxFfEmpty;
	assign memWrEn = rRxRdEn & !wMemFull;
	assign memAddr = rMemAddr;
	assign memData = {8{progEn}} & rxData; 

//Sequencial
	always @(posedge clk ) begin
		rRxRdEn <= rxRdEn & !wMemFull;
	end

	always @(posedge clk ) begin
		if(!progEn)begin
			rMemAddr <= 0;
		end else if(rRxRdEn)begin
			rMemAddr <= rMemAddr + 1;
		end
	end


endmodule