module uart_tx_ff #(
    parameter BAUD_CYCLE = 868, //BAUD_RATE = 115200 for clk=10n
	parameter LSB_FIRST = 1'b1
) (
    clk,
    rstB,

    ffEmpty,
    rdEn,
    rdData,
    
    tx
);
//Param
localparam IDLE = 2'b00;
localparam RDFF = 2'b01;
localparam TRAN = 2'b10;

//Port
    input logic			clk;
	input logic			rstB;
	input logic			ffEmpty;
    
    output logic		rdEn;
    input logic[7:0]	rdData;
	output logic		tx;

//Signal
	logic[1:0]		wState_next;
	reg[1:0]		rState_current;
	reg[9:0]		rParData;
	reg[9:0]		rBaudCnt;
	reg[9:0]		rBitInCnt;
	reg				rRdEn;


//FSM
	always_comb begin : FSM
		case (rState_current)
			IDLE : begin
				if(ffEmpty == 1'b0) begin
					wState_next = RDFF;
				end else begin
					wState_next = rState_current;
				end
			end 
			RDFF : begin
				if(rRdEn) begin
					wState_next = TRAN;
				end else begin
					wState_next = rState_current;
				end
			end
			TRAN: begin
				if(rBitInCnt[9] == 1'b1)begin
					wState_next = IDLE;
				end else begin
					wState_next = rState_current;
				end
			end
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
	assign rdEn = (rState_current == IDLE) ? !ffEmpty : 1'b0;
	assign tx = rParData[0];

//Sequencial
	
	always @(posedge clk) begin
		if(!rstB)begin
			rBaudCnt = 0;
		end else if(rBaudCnt == BAUD_CYCLE)begin
			rBaudCnt = 0;
		end else if(rState_current == TRAN)begin
			rBaudCnt = rBaudCnt + 1;
		end else begin
			rBaudCnt = 0;
		end
	end

	always @(posedge clk ) begin
		rRdEn <= rdEn;
	end

	always @(posedge clk) begin
		if(!rstB) begin
			rParData <= 8'hFF;
		end else if(rRdEn) begin
			rParData <= {1'b1,rdData,1'b0};
		end else if(rBaudCnt == BAUD_CYCLE) begin
			rParData <= {1'b1,rParData[9:1]};
		end
	end

	always @(posedge clk) begin
		if(wState_next == RDFF && rState_current == IDLE)begin
			rBitInCnt <= 0;
		end else if(rBaudCnt == BAUD_CYCLE) begin
			rBitInCnt <= {rBitInCnt[8:0],1'b1};
		end
	end
    
endmodule