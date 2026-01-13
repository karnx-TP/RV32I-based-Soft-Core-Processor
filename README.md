# RV32I-based-Soft-Core-Processor
RV32I-based-Soft-Core-Processor System-On-Chip Project

Design Complete
  1. 5-Stage Pipeline RV32I Base CPU Core (Currently without system Instruction FENCE/ECALL/EBREAK)
      - Including Instruction Decoder, ALU, 32 GP-Registers,Branch Unit
	  - Pipeline stages : IF->ID->EXE->MEM->WB
	  - Including Hazard Handling Logic (Bypass, Bubbling)
  2. RAM with Controller
      - Can be synthesized into BRAM type for FPGA
      - Have generic config for DEPTH and Word width
      - Have Byte/Halfword/Word write function
  3. UART Module
      - Simple UART peripherals with generic for BAUDRATE
      - 2 FIFO Buffer in both rx side and tx side
      - Can access using Load/Store Instruction at address 0x402 and 0x403
  4. Programmer Module & Instruction RAM
	  - Instruction memory : synthesized into Block Ram for FPGA
	  - Programmer Module : Use for writing instruction memory through UART interface (*TX*,*RX* port) while *progEn* port is being pulled to low
  5. I/O Port
	  - GPIO for read/write signal of the SoC i/o pin by register: DDR,PVL,PIN 
	  - DDR for control signal direction (in/out), PVL for writing output signal, PIN for reading input signal and toggle output signal by writing '1' to PIN
	  - Accessed by Risc-v Core using Load/Store Instruction at 0x404, 0x405, 0x406
	  - Implemented IO_BUFF at SoC top level module to connect I/O Port module with the FPGA tri-state buffer cell
  6. RX echo (for Debug)
	  - Module implemented for **debugging system** to see is the SoC recieve program uploading transmission
	  - Simple TX module sampling data that are writing to instruction ram, then send it through echo pin

On-board Test
> **Version1** : Tested on AX7010 FPGA Board (Zynq 7000 series)
- Resources Used (including some chipscope) : 2948 LUTs, 3292 FFs, 11.5 BRAMs
- Power Used : 0.125 W
- Timing
	- Current Operating Frequency = 50 MHz
	- WNS = 0.425ns(setup), 0.011ns(hold), 8.75ns(pulse width)
- Functional
 	- Writing software using assembly language them complie to binary 
   - Can be uploaded complied code uart interface (can see echo through echo pin)
   - Correct sent data through uart peripherals by software(load/store instruction)
   - Correct i/o port value display using l/s intruction (see at led dispaly)


Currently Progress
(Plan)
- Add another peripherals
- Implement AXI to Support AXI, AXI4-Lite, AXI-Stream protocol for further improvement like AI Accelerator