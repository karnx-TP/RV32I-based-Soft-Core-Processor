//----------------------------------------
// File : reg_file.sv
// Author : Thitipong Pav
// Desc : 32-depth register file
//----------------------------------------

module reg_file (
    clk,
    rstB,

    wrEn,
    wrData,
    wrAddr,

    rdR1Addr,
    rdR2Addr,

    r1out,
    r2out
);
//Port
    input logic             clk;
    input logic             rstB;
    input logic             wrEn;
    input logic[31:0]       wrData;
    input logic[4:0]        wrAddr;

    input logic[4:0]        rdR1Addr;
    input logic[4:0]        rdR2Addr;

    output logic[31:0]      r1out;
    output logic[31:0]      r2out;

//Signal Decclaration
    reg[0:31][31:0]     gprf;
	reg[4:0]			rRs1;
	reg[4:0]			rRs2;

//Comb Logic
    assign r1out = gprf[rRs1];
    assign r2out = gprf[rRs2];

//Sequencial Logic
	always @(posedge clk ) begin
		if(!rstB)begin
			rRs1 <= 0;
			rRs2 <= 0;
		end else begin
			rRs1 <= rdR1Addr;
			rRs2 <= rdR2Addr;
		end
	end

	always @(posedge clk) begin
		if(!rstB)begin
			for (int i = 0;i<32;i=i+1) begin
				gprf[i] <= 0;
			end
		end else if(wrEn) begin
			if(wrAddr != 0) begin
				gprf[wrAddr] <= wrData;
			end
		end
	end

    
endmodule