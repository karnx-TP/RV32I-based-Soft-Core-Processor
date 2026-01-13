# RV32I-based Soft-Core Processor
FPGA System-on-Chip (SoC) Project

## Overview
This project implements a custom **RV32I-based soft-core processor** integrated into a complete System-on-Chip (SoC) on FPGA.  
The system includes a pipelined RISC-V CPU core, on-chip memories, UART-based programming, and memory-mapped peripherals.  
The design has been synthesized and validated on real FPGA hardware.

---

## Completed Design

### 1. RV32I CPU Core
- 4-stage pipelined RV32I processor  
  **Pipeline:** IF → ID → EXE/MEM → WB
- Instruction Decoder, ALU, Branch Unit, and 32 General-Purpose Registers
- Hazard handling logic:
  - Data bypassing
  - Pipeline bubbling
- System instructions **FENCE / ECALL / EBREAK** are currently not implemented

---

### 2. RAM and Memory Controller
- Parameterized memory depth and word width
- Supports:
  - Byte
  - Halfword
  - Word accesses
- Synthesizable into FPGA **Block RAM (BRAM)**

---

### 3. UART Peripheral
- Simple UART peripheral
- Independent RX and TX FIFOs
- Memory-mapped access via Load/Store instructions:
  - `0x402` : RX
  - `0x403` : TX

---

### 4. Instruction RAM and Programmer Module
- Instruction memory implemented using **Block RAM**
- UART-based programming interface
- Instruction memory can be written externally when `progEn` is asserted low
- Enables program upload without re-synthesizing the FPGA bitstream

---

### 5. GPIO Peripheral
- Memory-mapped GPIO with the following registers:
  - `DDR` : Direction control (input/output)
  - `PVL` : Output value register
  - `PIN` : Input read and output toggle (write `1` to toggle)
- Address mapping:
  - `0x404` : DDR
  - `0x405` : PVL
  - `0x406` : PIN
- FPGA tri-state buffers are instantiated at the SoC top-level module

---

### 6. RX Echo Debug Module
- Debug module for verifying instruction upload via UART
- Samples data written to instruction memory
- Echoes data through a dedicated output pin

---

## FPGA Implementation History

### Version 1 — 3-Stage Pipeline  
**Pipeline:** IF → ID/EXE/MEM → WB  
**Target Board:** AX7010 (Zynq-7000 series)

#### Resource Utilization
- LUTs: 2948  
- FFs: 3292  
- BRAMs: 11.5  
- (Includes Chipscope)

#### Power
- 0.125 W

#### Timing
- Operating frequency: 50 MHz
- WNS:
  - Setup: 0.425 ns
  - Hold: 0.011 ns
  - Pulse width: 8.75 ns

#### Functionality
- Assembly programs compiled to binary
- Program upload via UART (verified using echo pin)
- Correct UART transmission via software
- GPIO output verified using LED display

---

### Version 2 — 4-Stage Pipeline (Current)
**Target Board:** AX7010 (Zynq-7000 series)

#### Resource Utilization
- LUTs: 1719  
- FFs: 1428  
- BRAMs: 11.5  
- (No Chipscope)

#### Power
- 0.125 W

#### Timing
- Operating frequency: 50 MHz
- WNS:
  - Setup: 2.725 ns
  - Hold: 0.051 ns
  - Pulse width: 9.5 ns

#### Functionality
- Fully functional and equivalent to Version 1
- Improved timing margin
- Reduced resource utilization

---

## Future Work
- Add timer/counter peripherals
- Implement AXI, AXI4-Lite, and AXI-Stream interfaces
- Enable integration with external accelerators (e.g., AI accelerators)
