module core_tb ();


parameter CLK_PERIOD = 10;

//Wire
    logic            clk;
    logic            rstB;
    logic           clkEn;
    wire[31:0]      pc;
    logic[31:0]      instruction_in;
    logic           rx;
    logic           tx;


rv32i_core dut (
    .clk(clk),
    .rstB(rstB),
    .clkEn(clkEn),

    .pc(pc),
    .inst_in(instruction_in),

    .rx(rx),
    .tx(tx)
);

Program_Mem mem (
    .clk(clk), .we(1'b0), .addr(pc[13:0]), .din({32{1'b0}}), .dout(instruction_in)
);

//Test Signal
logic[7:0]  data;
logic[9:0]  data_ss;
    
//Task
    always 
    begin : clock
      #(CLK_PERIOD / 2) 
      clk = 0;
      #(CLK_PERIOD / 2) 
      clk = 1;
    end

    task init;
    begin
        clkEn = 0;
        rstB = 0;
        rx = 1'b1;
        #(CLK_PERIOD + 0.5*CLK_PERIOD);
        rstB = 1;
        clkEn = 1;
        #(2 * CLK_PERIOD);
    end
    endtask

    initial begin
        init();
        data = 8'h51;
		data_ss = {1'b1,data,1'b0};
		for(int i=0;i<10;i++)
		begin
			rx = data_ss[i];
			#(868*CLK_PERIOD);
		end
        #((7000)*CLK_PERIOD);

        $stop;
    end

//Monitor
// initial begin
//     $monitor ("[monitor] time=%0t pc_current=%0d pc_this=%0d Instr=0x%08h", $time, (dut.wPc_int)/4,(dut.wPc_int)/4 - 1,dut.dec.rInstrustion);
// end
    

endmodule