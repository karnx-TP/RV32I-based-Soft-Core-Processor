module ram_ByteController #(
    parameter DEPTH = 1024,
	parameter XLEN = 32
) (
    clk,

    addr,
    wrData,
    wrEn,
    dataOut,

    byteEn,
    halfEn,
    wordEn,
    unsignedEn
    
);

localparam ADDRWIDTH = $clog2(1024);

//Port
    input logic						clk;
	input logic[ADDRWIDTH-1:0]		addr;
	input logic[XLEN-1:0]			wrData;
	input logic						wrEn;
	output logic[XLEN-1:0]			dataOut;

	input logic						byteEn;
    input logic						halfEn;
    input logic						wordEn;
    input logic						unsignedEn;

//Signal
	reg[0:DEPTH][7:0]		mem;

//Read
	assign dataOut = (byteEn) ? {{(XLEN-8){(!unsignedEn)&mem[addr][7]}},mem[addr]} :
					 (halfEn) ? {{(XLEN/2){(!unsignedEn)&mem[addr+1][7]}},mem[addr+1],mem[addr]} :
					 {mem[addr+3],mem[addr+2],mem[addr+1],mem[addr]};
					 
//Write
    always @(posedge clk) begin
        if(wrEn) begin
            if(byteEn) begin
                mem[addr] <= wrData[7:0];
            end else if (halfEn) begin
                mem[addr] <= wrData[7:0];
                mem[addr+1] <= wrData[15:8];
            end else begin
                mem[addr] <= wrData[7:0];
                mem[addr+1] <= wrData[15:8];
                mem[addr+2] <= wrData[23:16];
                mem[addr+3] <= wrData[31:24];
            end
            
        end
    end

    
endmodule