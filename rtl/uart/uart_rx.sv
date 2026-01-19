//----------------------------------------
// File : uart_rx.sv
// Author : Thitipong Pav
// Desc : RX side for uart module
//----------------------------------------

module uart_rx #(
	parameter BAUD_CYCLE = 868, //BAUD_RATE = 115200 for clk=10n
	parameter LSB_FIRST = 1'b1
)(
    clk,
    rstB,

    rx,
    
    dataEn,
    dataOut,
	FfFull
);
//Param
localparam IDLE = 2'b00;
localparam RECV = 2'b01;
localparam DOUT = 2'b10;

//Port
    input logic			clk;
	input logic			rstB;
	input logic			rx;
	
	output logic		dataEn;
	output logic[7:0]	dataOut;
	input  logic		FfFull;

//Signal
	logic[1:0]		wState_next;
	reg[1:0]		rState_current;
	reg[9:0]		rParData;
	reg[9:0]		rBaudCnt;
	reg[9:0]		rBitInCnt;
	reg				rRx_1;
	reg				rRx;
	logic			wMidBaud;

//FSM
	always_comb begin : FSM
		case (rState_current)
			IDLE : begin
				if(rRx == 1'b0 && FfFull == 1'b0) begin
					wState_next = RECV;
				end else begin
					wState_next = rState_current;
				end
			end 
			RECV : begin
				if(rBitInCnt[9] == 1'b1)begin
					wState_next = DOUT;
				end else begin
					wState_next = rState_current;
				end
			end
			DOUT : wState_next = IDLE;
			default: wState_next = rState_current;
		endcase	
	end

	always @(posedge clk) begin
		if(!rstB) begin
			rState_current <= IDLE;
		end else begin
			rState_current <= wState_next;
		end 
	end

//Combinational
	assign wMidBaud = (rBaudCnt == BAUD_CYCLE/2);
	assign dataOut = (wState_next == DOUT) ? rParData[8:1] : 8'h00;
	assign dataEn = (wState_next == DOUT && rParData[9]);

//Sequencial
	always @(posedge clk) begin
		rRx_1 <= rx;
		rRx <= rRx_1;
	end

	always @(posedge clk) begin
		if(!rstB)begin
			rBaudCnt = 0;
		end else if(rBaudCnt == BAUD_CYCLE)begin
			rBaudCnt = 0;
		end else if(rState_current == RECV)begin
			rBaudCnt = rBaudCnt + 1;
		end else begin
			rBaudCnt = 0;
		end
	end

	always @(posedge clk) begin
		if(wMidBaud) begin
			rParData <= {rRx,rParData[9:1]};
		end
	end

	always @(posedge clk) begin
		if(wState_next == RECV && rState_current == IDLE)begin
			rBitInCnt <= 0;
		end else if(wMidBaud) begin
			rBitInCnt <= {rBitInCnt[8:0],1'b1};
		end
	end

    
endmodule