module core_tb ();


parameter CLK_PERIOD = 10;

//Wire
    logic            clk;
    logic            rstB;
    logic           clkEn;
    wire[31:0]      pc;
    logic[31:0]      instruction_in;


rv32i_core dut (
    .clk(clk),
    .rstB(rstB),
    .clkEn(clkEn),

    .pc(pc),
    .inst_in(instruction_in)
);

Program_Mem mem (
    .clk(clk), .we(1'b0), .addr(pc[13:0]), .din({32{1'b0}}), .dout(instruction_in)
);
    
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
        #(CLK_PERIOD + 0.5*CLK_PERIOD);
        rstB = 1;
        clkEn = 1;
        #(2 * CLK_PERIOD);
    end
    endtask

    initial begin
        init();
        #(80*CLK_PERIOD);

        $stop;
    end

//Monitor
initial begin
    $monitor ("[monitor] time=%0t pc_current=%0d pc_this=%0d Instr=0x%08h", $time, (dut.wPc_int)/4,(dut.wPc_int)/4 - 1,dut.dec.rInstrustion);
end
    

endmodule