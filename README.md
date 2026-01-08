# RV32I-based-Soft-Core-Processor
RV32I-based-Soft-Core-Processor System-On-Chip Project

Complete
  1. 3-Stage Pipeline RV32I Base CPU Core (Currently without system Instruction FENCE/ECALL/EBREAK)
      - Including Instruction Decoder, ALU, 32 GP-Registers,Branch Unit, Hazard Handling Logic
  2. RAM with Controller
      - Can be synthesized into BRAM type for FPGA
      - Have generic config for DEPTH and Word width
      - Have Byte/Halfword/Word write function
  3. UART Module
      - Simple UART peripherals with generic for BAUDRATE
      - 2 FF Buffer in both rx side and tx side
      - Can access using Load/Store Instruction at address 0x402 and 0x403

Currently Progress
- Programmer module which will be used to program the SoC through UART
