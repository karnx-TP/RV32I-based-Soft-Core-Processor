//----------------------------------------
// File : pc_reg.sv
// Author : Thitipong Pav
// Desc : program counter register
//----------------------------------------

module pc_reg (
    clk,
    rstB,
    clkEn,
	stall,

    condEn,
    next_pc_cond,
    pc_out
);
//Port
    input logic clk;
    input logic rstB;
    input logic clkEn;
	input logic stall;
    input logic condEn;
    input logic[31:0] next_pc_cond;
    output logic[31:0] pc_out;

//Signal Declaration
    reg[31:0]   rPC_current;
    logic[31:0]  wPC_next;

//Combiantion
    assign pc_out = rPC_current;

    always_comb begin : uPC_next
        if(clkEn & !stall) begin
            if(condEn) begin
                wPC_next = next_pc_cond;
            end else begin
                wPC_next = rPC_current + 4;
            end
        end else begin
            wPC_next = rPC_current;
        end
    end

//D-FF
    always @(posedge clk) begin 
        if(!rstB) begin
            rPC_current <= 0;
        end else begin
            rPC_current <= wPC_next;
        end
    end
endmodule