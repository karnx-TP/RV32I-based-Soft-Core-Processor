//----------------------------------------
// File : sync_fifo.sv
// Author : Thitipong Pav
// Desc : synthesizable Synchronous 8 bits FIFO
//----------------------------------------

module sync_fifo 
#(
    parameter WIDTH = 8,
    parameter DEPTH = 256
) 
(
    input   logic       clk,
    input   logic       rst,

    input   logic[WIDTH-1:0]      data_in,
    input   logic           FfWrEn,
    input   logic           FfRdEn,

    output   logic[WIDTH-1:0]     data_out,
    output   logic          FfEmpty,
    output   logic          FfFull
);

localparam ADDRW = $clog2(DEPTH);

reg [WIDTH-1:0]     buffer[0:DEPTH-1];

reg [ADDRW-1:0]     RdAddr;
reg [ADDRW-1:0]     WrAddr;
integer n;
integer i;
//Output Assignment
    assign FfEmpty = (RdAddr == WrAddr) ? 1'b1 : 1'b0;
    assign FfFull  = (RdAddr == WrAddr + 1) ? 1'b1 : 1'b0;

//Process Block
always @(posedge clk ) begin
    if(FfRdEn && !FfEmpty) begin
        data_out <= buffer[RdAddr];
    end else begin
        data_out <= 8'hFF;
    end
end

always @(posedge clk) begin : WriteFF
    if(FfWrEn == 1'b1 && FfFull == 1'b0) begin
        buffer[WrAddr] <= data_in;
    end
end

always @(posedge clk) begin : u_WrAddr
    if(!rst) begin
        for(n=0;n<ADDRW;n=n+1) begin
            WrAddr[n] <= 1'b0;
        end
    end else begin
        if(FfWrEn == 1'b1 && FfFull == 1'b0) begin
            WrAddr <= WrAddr + 1;
        end else begin
            WrAddr <= WrAddr;
        end
    end 
end

always @(posedge clk) begin : u_RdAddr
    if(!rst) begin
        for(n=0;n<ADDRW;n=n+1) begin
    	    RdAddr[n] <= 1'b0;
        end
    end else begin
        if(FfRdEn == 1'b1 && FfEmpty == 1'b0) begin
            RdAddr <= RdAddr + 1;
        end else begin
            RdAddr <= RdAddr;
        end
    end 
end



endmodule