`timescale 1ns/1ns
module top_tb ();


parameter CLK_PERIOD = 10;

//Wire
    logic            clk;
    logic            rstB;
    logic           progEn;
    logic           rx;
    logic           tx;
	wire[7:0]		pin;
	logic			echo;


rv32i_top_Soc dut(
    .clk(clk),
    .rstB(rstB),
    .progEnB(!progEn),

    .rx(rx),
    .tx(tx),
	.pin(pin),
	.rx_echo(echo)
);

genvar i;
generate
	for (i = 0;i<8;i=i+1) begin : GEN_PULLUP
		pullup (pin[i]);
	end
endgenerate


//Tester Module
logic	wUserRxDataEn;
logic[7:0]	wUserRxData;
uart_rx #(
	.BAUD_CYCLE(868)
) uart_rx_inst (
	.clk(clk),
	.rstB(rstB),

	.rx(tx),
	
	.dataEn(wUserRxDataEn),
	.dataOut(wUserRxData),
	.FfFull(1'b0)
);

//Test Signal
logic[7:0]  data;
logic[9:0]  data_ss;
integer file,code;
logic [7:0] rammem [0:32767];
logic[7:0] Pn;

assign pin[0] = Pn[0];
    
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
		Pn = 0;
        #(CLK_PERIOD + 0.5*CLK_PERIOD);
        rstB = 1;
        #(2 * CLK_PERIOD);
    end
    endtask

	initial begin
		file = $fopen("../../software/risv-v-sw/program.bin" , "rb");
		if (file == 0) begin
                $display("Could not open file");
            end
		code = $fread(rammem,file);  
        $displayh(rammem);        
        $fclose(file);
	end

    initial begin
        init();
		for (int i = 0;i<508; i++) begin
			data = rammem[i];
			data_ss = {1'b1,data,1'b0};
			for(int j=0;j<10;j++)
			begin
				rx = data_ss[j];
				#(868*CLK_PERIOD);
			end
		end
		rx = 1'b1;

		progEn = 1'b0;
		Pn[0] = 1'b1;
		$display("Programmed");

        #((100)*CLK_PERIOD);
		while(1)
		begin
			if(wUserRxDataEn == 1'b1)
			begin
				$display("DataOut = %0h",wUserRxData);
				break;
			end
			#(CLK_PERIOD);
		end

		//Dump Register
		$display("Register Dump:");
		for (int i = 0; i < 32; i++) begin
			$display("x%0d = %0h", i, dut.core.reg_module.sram_reg1.mem[i]);
		end

		# (10*CLK_PERIOD);

		rstB = 1'b0;

		#(2*CLK_PERIOD);

		rstB = (1'b1);

		# (100*CLK_PERIOD);



		$display("Testbench End");
        $stop;
    end
	
	initial begin
		# (60000000*CLK_PERIOD);
		$display("Testbench End");
        $stop;
	end

//Monitor
// initial begin
//     $monitor ("[monitor] time=%0t pc_current=%0d pc_this=%0d Instr=0x%08h", $time, (dut.wPc_int)/4,(dut.wPc_int)/4 - 1,dut.dec.rInstrustion);
// end
    

endmodule