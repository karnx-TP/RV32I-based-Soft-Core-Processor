module prog_ram_w8r32
	#(parameter MEM_SIZE = 32767)
    (clk, we, addr, din, dout);

	localparam ADDRW = $clog2(MEM_SIZE);

    input clk;
	input we;
	input [ADDRW-1:0] addr;
	input [7:0] din;
	output [31:0] dout;

	reg [0:MEM_SIZE][7:0] ram ;
	logic [31:0] d_out;

    assign dout = d_out;

    always @(posedge clk ) begin
        d_out[7:0] = ram[addr];
        d_out[15:8] = ram[addr+1];
        d_out[23:16] = ram[addr+2];
        d_out[31:24] = ram[addr+3];
    end

	always @(negedge clk)
	begin
		if (we) begin
			ram[addr] = din;
		end 
	end

	
endmodule
