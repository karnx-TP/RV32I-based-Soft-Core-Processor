module Program_Mem

    (clk, we, addr, din, dout);

    input clk;
	input we;
	input [13:0] addr;
	input [31:0] din;
	output [31:0] dout;

	reg [0:32767][7:0] ram ;
	logic [31:0] d_out;

    assign dout = d_out;
    assign d_out[7:0] = ram[addr];
    assign d_out[15:8] = ram[addr+1];
    assign d_out[23:16] = ram[addr+2];
    assign d_out[31:24] = ram[addr+3];

	initial begin
        // Progmem default = FF
        foreach (ram[i]) begin
            ram[i] = 8'hff;
        end

        //Test ALU RegImm,LUI
        ram[3] = 8'h00;         ram[2] = 8'h00;       ram[1] = 8'h10;        ram[0] = 8'hB7;    //LUI r1,1          
        ram[1*4 + 3] = 8'h00;   ram[1*4 + 2] = 8'h80; ram[1*4 + 1] = 8'h80;  ram[1*4 + 0] = 8'h93;   //ADDI r1,r1,0x08 

        ram[2*4 + 3] = 8'h00;   ram[2*4 + 2] = 8'h0F; ram[2*4 + 1] = 8'hF1;  ram[2*4 + 0] = 8'h37;    //LUI r2,FF          
        ram[3*4 + 3] = 8'h0A;   ram[3*4 + 2] = 8'hB1; ram[3*4 + 1] = 8'h01;  ram[3*4 + 0] = 8'h13;   //ADDI r2,r2,0xAB
           
        ram[4*4 + 3] = 8'h80;   ram[4*4 + 2] = 8'h00; ram[4*4 + 1] = 8'h01;  ram[4*4 + 0] = 8'hB7;   //LUI x3,-1   
        
        ram[5*4 + 3] = 8'h02;   ram[5*4 + 2] = 8'h81; ram[5*4 + 1] = 8'hA2;  ram[5*4 + 0] = 8'h13;   //SLTI x4,x3,40
        ram[6*4 + 3] = 8'h02;   ram[6*4 + 2] = 8'h81; ram[6*4 + 1] = 8'hB2;  ram[6*4 + 0] = 8'h13;   //SLTIU x4,x3,40

        ram[7*4 + 3] = 8'hFF;   ram[7*4 + 2] = 8'hF1; ram[7*4 + 1] = 8'hC2;  ram[7*4 + 0] = 8'h93;   //XORI x5,x3,4095(all 1)
        ram[8*4 + 3] = 8'hFF;   ram[8*4 + 2] = 8'hF1; ram[8*4 + 1] = 8'hE3;  ram[8*4 + 0] = 8'h13;   //ORI x6,x3,4095(all 1)
        ram[9*4 + 3] = 8'hFF;   ram[9*4 + 2] = 8'hF1; ram[9*4 + 1] = 8'hF3;  ram[9*4 + 0] = 8'h93;   //ANDI x7,x3,4095(all 1)

        //Test Cons Shf
        ram[10*4 + 3] = 8'h00;   ram[10*4 + 2] = 8'hC1; ram[10*4 + 1] = 8'h14;  ram[10*4 + 0] = 8'h13;   //SLLI x8,x2,12
        ram[11*4 + 3] = 8'h40;   ram[11*4 + 2] = 8'h44; ram[11*4 + 1] = 8'h54;  ram[11*4 + 0] = 8'h13;   //SRAI x8,x8,4
        ram[12*4 + 3] = 8'h00;   ram[12*4 + 2] = 8'h44; ram[12*4 + 1] = 8'h54;  ram[12*4 + 0] = 8'h13;   //SRLI x8,x8,4

        //Test ALU RegReg
        ram[13*4 + 3] = 8'h00;   ram[13*4 + 2] = 8'h20; ram[13*4 + 1] = 8'h84;  ram[13*4 + 0] = 8'hB3;   //ADD x9,x1,x2
        ram[14*4 + 3] = 8'h40;   ram[14*4 + 2] = 8'h20; ram[14*4 + 1] = 8'h84;  ram[14*4 + 0] = 8'hB3;   //SUB x9,x1,x2

        ram[15*4 + 3] = 8'h00;   ram[15*4 + 2] = 8'h20; ram[15*4 + 1] = 8'h94;  ram[15*4 + 0] = 8'hB3;   //SLL x9,x1,x2
        ram[16*4 + 3] = 8'h00;   ram[16*4 + 2] = 8'h21; ram[16*4 + 1] = 8'hA5;  ram[16*4 + 0] = 8'h33;   //SLT x10,x3,x2
        ram[17*4 + 3] = 8'h00;   ram[17*4 + 2] = 8'h21; ram[17*4 + 1] = 8'hB5;  ram[17*4 + 0] = 8'h33;   //SLTU x10,x3,x2

        ram[18*4 + 3] = 8'h00;   ram[18*4 + 2] = 8'h11; ram[18*4 + 1] = 8'hd5;  ram[18*4 + 0] = 8'hB3;   //SRL x11,x6,x1
        ram[19*4 + 3] = 8'h40;   ram[19*4 + 2] = 8'h11; ram[19*4 + 1] = 8'hd5;  ram[19*4 + 0] = 8'hB3;   //SRA x11,x6,x1

        ram[20*4 + 3] = 8'h00;   ram[20*4 + 2] = 8'h61; ram[20*4 + 1] = 8'hF6;  ram[20*4 + 0] = 8'h33;   //AND x12,x3,x6
        ram[21*4 + 3] = 8'h00;   ram[21*4 + 2] = 8'h61; ram[21*4 + 1] = 8'hE6;  ram[21*4 + 0] = 8'h33;   //OR x12,x3,x6
        ram[22*4 + 3] = 8'h00;   ram[22*4 + 2] = 8'h61; ram[22*4 + 1] = 8'hC6;  ram[22*4 + 0] = 8'h33;   //XOR x12,x3,x6

        //Ld,St
        ram[23*4 + 3] = 8'h00;   ram[23*4 + 2] = 8'h22; ram[23*4 + 1] = 8'h21;  ram[23*4 + 0] = 8'ha3;   //SW x2,3(x4)
        ram[24*4 + 3] = 8'h00;   ram[24*4 + 2] = 8'h22; ram[24*4 + 1] = 8'h13;  ram[24*4 + 0] = 8'h23;   //SH x2,6(x4)
        ram[25*4 + 3] = 8'h00;   ram[25*4 + 2] = 8'h22; ram[25*4 + 1] = 8'h05;  ram[25*4 + 0] = 8'h23;   //SB x2,10(x4)

        ram[26*4 + 3] = 8'h00;   ram[26*4 + 2] = 8'h32; ram[26*4 + 1] = 8'h08;  ram[26*4 + 0] = 8'h03;   //LB x16,3(x4)
        ram[27*4 + 3] = 8'h00;   ram[27*4 + 2] = 8'h32; ram[27*4 + 1] = 8'h18;  ram[27*4 + 0] = 8'h03;   //LH x16,3(x4)
        ram[28*4 + 3] = 8'h00;   ram[28*4 + 2] = 8'h32; ram[28*4 + 1] = 8'h28;  ram[28*4 + 0] = 8'h03;   //LW x16,3(x4)

        ram[29*4 + 3] = 8'h00;   ram[29*4 + 2] = 8'h32; ram[29*4 + 1] = 8'h48;  ram[29*4 + 0] = 8'h03;   //LBU x16,3(x4)
        ram[30*4 + 3] = 8'h00;   ram[30*4 + 2] = 8'h32; ram[30*4 + 1] = 8'h58;  ram[30*4 + 0] = 8'h03;   //LHU x16,3(x4)

        //JAL
        ram[31*4 + 3] = 8'h00;   ram[31*4 + 2] = 8'ha0; ram[31*4 + 1] = 8'h08;  ram[31*4 + 0] = 8'hEF;   //JAL x17,10
        ram[32*4 + 3] = 8'hFF;   ram[32*4 + 2] = 8'hFF; ram[32*4 + 1] = 8'hFB;  ram[32*4 + 0] = 8'hB7;   //LUI x23,-1 (Should be skipped)

        //JALR
        ram[36*4 + 3] = 8'h02;   ram[36*4 + 2] = 8'h08; ram[36*4 + 1] = 8'h89;  ram[36*4 + 0] = 8'h67;   //JALR x18,32(x17)

        //NOP
        ram[40*4 + 3] = 8'h00;   ram[40*4 + 2] = 8'h00; ram[40*4 + 1] = 8'h00;  ram[40*4 + 0] = 8'h13;   //(NOP)>ADDI r0,r0,0x00 

        //BEQ
        ram[41*4 + 3] = 8'h01;   ram[41*4 + 2] = 8'h39; ram[41*4 + 1] = 8'h02;  ram[41*4 + 0] = 8'h63;   //BEQ x18,x19,4
        ram[42*4 + 3] = 8'h01;   ram[42*4 + 2] = 8'h3a; ram[42*4 + 1] = 8'h02;  ram[42*4 + 0] = 8'h63;   //BEQ x20,x19,4
        
        ram[44*4 + 3] = 8'h01;   ram[44*4 + 2] = 8'h28; ram[44*4 + 1] = 8'h92;  ram[44*4 + 0] = 8'h63;   //BNE x17,x18,4

        ram[46*4 + 3] = 8'h00;   ram[46*4 + 2] = 8'hA4; ram[46*4 + 1] = 8'hC2;  ram[46*4 + 0] = 8'h63;   //BLT x9,x10,4
        ram[47*4 + 3] = 8'h00;   ram[47*4 + 2] = 8'hA5; ram[47*4 + 1] = 8'hC2;  ram[47*4 + 0] = 8'h63;   //BLT x11,x10,4
        ram[49*4 + 3] = 8'h00;   ram[49*4 + 2] = 8'hA5; ram[49*4 + 1] = 8'hE2;  ram[49*4 + 0] = 8'h63;   //BLTU x11,x10,4
        ram[50*4 + 3] = 8'h00;   ram[50*4 + 2] = 8'hB5; ram[50*4 + 1] = 8'h62;  ram[50*4 + 0] = 8'h63;   //BLTU x10,x11,4
        ram[52*4 + 3] = 8'h01;   ram[52*4 + 2] = 8'hFF; ram[52*4 + 1] = 8'h62;  ram[52*4 + 0] = 8'h63;   //BLTU x30,x31,4

        ram[54*4 + 3] = 8'h00;   ram[54*4 + 2] = 8'h95; ram[54*4 + 1] = 8'h52;  ram[54*4 + 0] = 8'h63;   //BGE x10,x9,4
        ram[55*4 + 3] = 8'h00;   ram[55*4 + 2] = 8'hB5; ram[55*4 + 1] = 8'h52;  ram[55*4 + 0] = 8'h63;   //BGE x10,x11,4
        ram[57*4 + 3] = 8'h00;   ram[57*4 + 2] = 8'hB5; ram[57*4 + 1] = 8'h72;  ram[57*4 + 0] = 8'h63;   //BGEU x10,x11,4
        ram[58*4 + 3] = 8'h00;   ram[58*4 + 2] = 8'hA5; ram[58*4 + 1] = 8'hF2;  ram[58*4 + 0] = 8'h63;   //BGEU x11,x10,4

        //AUIPC
        ram[60*4 + 3] = 8'h00;   ram[60*4 + 2] = 8'h00; ram[60*4 + 1] = 8'h1f;  ram[60*4 + 0] = 8'h97;   //AUIPC x31,1
                 
	end

	always @(negedge clk)
	begin
		if (we) begin
			ram[addr] = din;
		end 
	end

	
endmodule
