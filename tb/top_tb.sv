`timescale 1ns/1ps
module top_tb ();


parameter CLK_PERIOD = 10;

//Wire
    logic            clk;
    logic            rstB;
    logic           progEn;
    logic           rx;
    logic           tx;


rv32i_top_Soc dut(
    .clk(clk),
    .rstB(rstB),
    .progEn(progEn),

    .rx(rx),
    .tx(tx)
);

//Test Signal
logic[7:0]  data;
logic[9:0]  data_ss;
integer file,code;
logic [7:0] rammem [0:32767];
    
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
        progEn = 1;
        rstB = 0;
        rx = 1'b1;
        #(CLK_PERIOD + 0.5*CLK_PERIOD);
        rstB = 1;
        #(2 * CLK_PERIOD);
    end
    endtask

	initial begin
		file = $fopen("../../software/tiny-risc-v-main/program.bin" , "rb");
		if (file == 0) begin
                $display("Could not open file");
            end
		code = $fread(rammem,file);  
        $displayh(rammem);        
        $fclose(file);
	end

    initial begin
        init();
		for (int i = 0;i<256; i++) begin
			data = rammem[i];
			data_ss = {1'b1,data,1'b0};
			for(int j=0;j<10;j++)
			begin
				rx = data_ss[j];
				#(868*CLK_PERIOD);
			end
		end

		progEn = 1'b0;

        #((100)*CLK_PERIOD);

        $stop;
    end

//Monitor
// initial begin
//     $monitor ("[monitor] time=%0t pc_current=%0d pc_this=%0d Instr=0x%08h", $time, (dut.wPc_int)/4,(dut.wPc_int)/4 - 1,dut.dec.rInstrustion);
// end
    

endmodule