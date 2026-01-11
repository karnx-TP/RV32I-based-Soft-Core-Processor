module io_port #(
	parameter DDR_ADDR = 11'h404,
	parameter PVL_ADDR = 11'h405,
	parameter PIN_ADDR = 11'h406,
	parameter PORT_SIZE = 8
)(
	clk,
    rstB,

    addr,
    wrData,
    wrEn,
	rdEn,
    dataOut,
	outEn,

	ddr,
	pvl,
	pin
);
//PORT
	input   logic       clk;
	input   logic       rstB;

	input   logic[10:0] addr;
	input   logic[31:0] wrData;
	input   logic       wrEn;
	input   logic       rdEn;
	output  logic[31:0] dataOut;
	output  logic       outEn;

	output  logic[PORT_SIZE-1:0]	ddr; //Digital Port (Also need I/O pad in top module)
	output  logic[PORT_SIZE-1:0]	pvl;
	input	logic[PORT_SIZE-1:0]	pin;
	
//Reg
	reg[7:0]		rDDR;
	reg[7:0]		rPVL;
	reg[7:0] 		rPIN; //Read Input or Write 1 for toggle rDDR

//Signal
	logic[7:0]		rDataOut;

//Synchronizer
	(* ASYNC_REG = "TRUE" *) reg[7:0]		rPin_sync1;
	(* ASYNC_REG = "TRUE" *) reg[7:0]		rPin_sync2;
	assign rPIN = rPin_sync2;
	always @(posedge clk) begin
		rPin_sync1 <= pin;
		rPin_sync2 <= rPin_sync1;
	end

//Comb logic
	assign dataOut = {{24{1'b0}},rDataOut};
	assign ddr = rDDR;
	assign pvl = rPVL;

//Read/Write Reg
	always @(posedge clk) begin
		if(!rstB)begin
			rDataOut <= 8'hff;
			outEn <= 1'b0;
		end else if(rdEn)begin
			case (addr)
				DDR_ADDR : begin
					rDataOut <= rDDR;
					outEn <= 1'b1;
				end 
				PVL_ADDR : begin
					rDataOut <= rPVL;
					outEn <= 1'b1;
				end 
				PIN_ADDR : begin
					rDataOut <= rPIN;
					outEn <= 1'b1;
				end 
				default: begin
					rDataOut <= 8'hff;
					outEn <= 1'b0;
				end
			endcase
		end else begin
			rDataOut <= 8'hff;
			outEn <= 1'b0;
		end
	end

	always @(posedge clk ) begin
		if(!rstB)begin
			rDDR <= 0;
			rPVL <= 0;
		end else if(wrEn)begin
			case (addr)
				DDR_ADDR : rDDR <= wrData[PORT_SIZE-1:0];
				PVL_ADDR : rPVL <= wrData[PORT_SIZE-1:0];
				PIN_ADDR : rDDR <= rDDR ^ wrData[PORT_SIZE-1:0]; //XOR -> Toggle
				default :;
			endcase
		end
	end

endmodule