# RV32I-Based Soft-Core Processor and Embedded System-on-Chip
RTL Design, FPGA Prototyping (Xilinx), and ASIC Physical Design (SKY130)


---
### About Author&Project
I am a senior Electrical Engineering student with a strong interest in **VLSI and Digital IC Design**.  
This project is an individual learning-oriented work aimed at gaining hands-on experience in **real processor and SoC design**.

The goal of this project is to complete the **full digital IC design flow**, including:
- Architecture definition
- RTL design and verification
- System integration
- FPGA prototyping
- ASIC physical design from RTL to GDSII

If you use or reference this design, proper credit would be greatly appreciated.  
For suggestions, feedback, or technical discussions, feel free to contact me.

📧 **Email:** thitipong.pav@gmail.com


## Overview

This project implements a custom **RV32I-based soft-core processor** integrated into a complete **Microcontroller System-on-chip (SoC)**.

The design has been:
- Architected and verified at RTL level
- Prototyped and validated on **real FPGA hardware**
- Implemented through a **full ASIC physical design flow** (core-only) using **LibreLane + SKY130**

The project emphasizes **ASIC-friendly RTL design**, modular SoC architecture, and a realistic path from **FPGA prototyping to ASIC implementation**.

---

## Completed Design

### 1. RV32I CPU Core

- **5-stage pipelined RV32I processor**
  
  **Pipeline stages:**  
  IF → ID → EXE → MEM → WB

- Implements:
  - Instruction Decoder
  - ALU
  - Branch Unit
  - 32 General-Purpose Registers

- Hazard handling:
  - Data forwarding (bypassing)
  - Pipeline stalling
  - Pipeline bubbling

- Not implemented (current scope):
  - `FENCE`
  - `ECALL`
  - `EBREAK`

---

### 2. RAM and Memory Controller

- Parameterized memory depth and word width
- Supports:
  - Byte access
  - Halfword access
  - Word access
- Synthesizable into FPGA **Block RAM (BRAM)**
- Designed to be replaceable by **SRAM macros** in ASIC flow

---

### 3. UART Peripheral

- Simple UART peripheral
- Independent RX and TX FIFOs
- Memory-mapped interface via Load/Store instructions:

| Address | Function |
|------|---------|
| `0x402` | UART Data Register|
| `0x403` | UART Control Register |
- TX : Write Data via UDR address
- RX : Read Data via UDR address
- Start TX and RX Valid via UCR Address

---

### 4. Instruction RAM and Programmer Module

- Instruction memory implemented using **Block RAM**
- UART-based programming interface
- Instruction memory writable externally when `progEn` is asserted low
- Enables program upload **without re-synthesizing FPGA bitstream**

---

### 5. GPIO Peripheral

- Memory-mapped GPIO registers:
  - `DDR` — Direction control (input/output)
  - `PVL` — Output value register
  - `PIN` — Input read / output toggle (write `1` toggles output)

- Address mapping:

| Address | Register |
|------|----------|
| `0x404` | DDR |
| `0x405` | PVL |
| `0x406` | PIN |

- FPGA tri-state buffers instantiated at the **SoC top-level**

---

### 6. RX Echo Debug Module

- Debug module for validating UART-based instruction upload
- Samples instruction memory write data
- Echoes data through a dedicated output pin
- Used to confirm programming correctness on hardware

---

## FPGA Implementation

### 3.1 Version 1 — 3-Stage Pipeline

**Pipeline:** IF → ID/EXE/MEM → WB  
**Target Board:** AX7010 (Zynq-7000 series)

#### Resource Utilization
- LUTs: 2948
- FFs: 3292
- BRAMs: 11.5  
- Includes Chipscope

#### Power
- 0.125 W

#### Timing
- Operating frequency: **50 MHz**
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

### 3.2 Version 2 — 5-Stage Pipeline (Current)

**Target Board:** AX7010 (Zynq-7000 series)

#### Resource Utilization
- LUTs: 1885
- FFs: 1530
- BRAMs: 10
- No Chipscope

#### Power
- 0.120 W

#### Timing
- Operating frequency: **50 MHz**
- WNS:
  - Setup: 2.262 ns
  - Hold: 0.050 ns
  - Pulse width: 9.5 ns

#### Improvements over Version 1
- Improved timing margin
- Reduced resource utilization
- Equivalent functionality

---

## ASIC Implementation (RV32I Core Only)

### Tools
- LibreLane
- Yosys
- OpenROAD
- SKY130 PDK

### Results
- Full synthesis, placement, and routing completed
- Passed DRC and LVS
- No setup or hold violations across **TT / SS / FF corners**

### Area
- **192,824 µm²**

### Timing
- Clock period: **30 ns**
- Operating frequency: **33 MHz**
- WNS:
  - Setup: 0.713 ns
  - Hold: 0.104 ns

### Power
- **4 mW** (core-only, estimated)

### Design Statistics
- Wires: 7,383
- Ports: 12
- Cells: 7,473

---

## Future Work

- Add timer/counter peripherals
- Implement AXI, AXI4-Lite, and AXI-Stream interfaces
- Enable integration with external accelerators (e.g., AI accelerators)
- Full SoC ASIC implementation:
  - Instruction SRAM
  - Data SRAM
  - FIFO SRAM macros
  - IO pad integration
