//----------------------------------------
// File : prog_ram_w8r32.sv
// Author : Thitipong Pav
// Desc : fpga synthesizable insruction ram 
//----------------------------------------

module prog_ram_w8r32
	#(parameter MEM_SIZE = 1024)
    (clk, we, addr, din, dout);

	localparam ADDRW = $clog2(MEM_SIZE);
	localparam WORD_DEPTH = MEM_SIZE/4;

    input clk;
	input we;
	input [ADDRW-1:0] addr;
	input [7:0] din;
	output reg[31:0] dout;

	(* ram_style = "block" *) reg [31:0] ram [0:WORD_DEPTH-1];
	logic [31:0] d_out;

    always @(posedge clk ) begin
		if (we) begin
			case (addr[1:0])
				2'b00 : ram[addr[ADDRW-1:2]][7:0] <= din;
				2'b01 : ram[addr[ADDRW-1:2]][15:8] <= din;
				2'b10 : ram[addr[ADDRW-1:2]][23:16] <= din;
				2'b11 : ram[addr[ADDRW-1:2]][31:24] <= din;  
			endcase
		end 

        dout <= ram[addr[ADDRW-1:2]];
    end

	
endmodule
