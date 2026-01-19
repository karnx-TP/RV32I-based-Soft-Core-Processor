//----------------------------------------
// File : io_buf.sv
// Author : Thitipong Pav
// Desc : Behavioral sim model of IOBUF Xilinx FPGA Primitive
//----------------------------------------

module IOBUF (
	I,
	O,
	T,
	IO
);
//Ports
	input  I;
	output O;
	input  T;
	inout  IO;

	assign IO = T ? 1'bz : I;
	assign O  = IO;
	
endmodule