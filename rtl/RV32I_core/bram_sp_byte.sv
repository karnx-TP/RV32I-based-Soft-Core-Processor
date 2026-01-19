//----------------------------------------
// File : bram_sp_byte.sv
// Author : Thitipong Pav
// Desc : synthesizable byte_en single port BRAM
//----------------------------------------

module bram_sp_byte #(
    parameter DEPTH = 4096,
    parameter XLEN = 32
) (
    clk,
    
    enA,
    wrEn,
    addr,
    dataIn,
    byte_we,

    dataOut
);
localparam ADDRWIDTH = $clog2(DEPTH);
localparam BYTE_WIDTH = 4;
//Port
    input logic						clk;
    input logic                     enA;
    input logic						wrEn;
	input logic[ADDRWIDTH-1:0]		addr;
	input logic[XLEN-1:0]			dataIn;
    input logic[BYTE_WIDTH-1:0]     byte_we;
	output logic[XLEN-1:0]			dataOut;

//Memory
    (* ram_style = "block" *)reg[XLEN-1:0]   ram [0:DEPTH-1];
	logic[ADDRWIDTH-1:0]		rAddr;
	
//reg Addr
	always @(posedge clk ) begin
		rAddr <= addr;
	end

    //Write
	genvar i;
    generate
        for (i = 0; i < BYTE_WIDTH; i = i + 1) begin
            always @(posedge clk) begin
                if(enA & wrEn & byte_we[i])begin
                    ram[addr[ADDRWIDTH-1:2]][(i*8)+:8] <= dataIn[(i*8)+:8]; 
                end
            end
        end
    endgenerate

    //Read
    always @(posedge clk) begin
        if(enA)begin
            dataOut <= ram[rAddr[ADDRWIDTH-1:2]];
        end
    end
    
    
endmodule