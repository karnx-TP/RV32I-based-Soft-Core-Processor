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

- Tools Used
	- RTL Design: SystemVerilog
	- Functional Verification: ModelSim
	- FPGA Implementation: Vivado, Teraterm(for uart communication)
	- ASIC Implementation: 
		- Librelane Flow
		- Software: Yosys, OpenROAD, Magic, Klayout

---

## Completed Design

### 1. RV32I CPU Core
- 5-stage pipeline Processor Core with RV32I Base Intruction 
### 2. RAM and Memory Controller
- Design RTL of RAM and its controller focusing on BRAM-synthsized on FPGA and ASIC-friendly
### 3. UART Peripheral
- UART peripheral with generic BAUD_RATE
### 4. Instruction RAM and Programmer Module
- Instruction RAM and programmer module for wrinting instruction through uart
### 5. GPIO Peripheral
- GPIO with direction control, Input Reading, Output sending
- FPGA tri-state buffers (IOBUF) instantiated at the **SoC top-level**
### 6. RX Echo Debug Module
- Debug module for validating UART-based instruction upload

#### For the Design Details See /rtl

## FPGA Implementation
- **Target Board:** AX7010 (Zynq-7000 series)
- **Operating frequency**: 50 MHz
#### For the Details See /vivado

## ASIC Implementation (RV32I Core Only)

### Tools
- LibreLane
- Yosys
- OpenROAD
- SKY130 PDK

#### For the Details See /asic_pd

## Future Work

- Add timer/counter peripherals
- Implement AXI, AXI4-Lite, and AXI-Stream interfaces
- Enable integration with external accelerators (e.g., AI accelerators)
- Full SoC ASIC implementation:
  - Instruction SRAM
  - Data SRAM
  - FIFO SRAM macros
  - IO pad integration
