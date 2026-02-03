# RV32I-Based Soft-Core Processor and Embedded System-on-Chip
RTL Design, FPGA Prototyping (Xilinx), and ASIC Physical Design (SKY130)


---
### About Author&Project
I am a senior Electrical Engineering student with a strong interest in **VLSI and Digital IC Design**.  
This project is an individual work aimed at gaining hands-on experience in **real processor and SoC design** using open-source ISA like **RISC-V** and open-source tools.

The goal of this project is to complete the **full digital IC design flow**, including:
- Architecture definition **: RISC-V**
- RTL design and verification
- System integration
- FPGA prototyping
- ASIC physical design from RTL to GDSII

**Note**
``` 
This project documents my design and implementation journey, focusing on the learning process rather than only final results.  
It includes my work steps for those who want to learn or discuss RTL and physical design.  
Each part of the work is organized into separate directories to make the flow easy to follow and study.  
Each major directory contains its own README.md describing
design decisions, challenges, and lessons learned for that stage.

For suggestions, feedback, or technical discussions 📧 **Email:** thitipong.pav@gmail.com
```

## Overview

This project implements a custom **RISC-V based soft-core processor** integrated into a complete **Microcontroller System-on-Chip (SoC)**.

**Goal**
- Architect and verify at the RTL level
- Prototype and validate on **real FPGA hardware**
- Implemente through a **full ASIC physical design flow** using **LibreLane + SKY130**

The project emphasizes **ASIC-friendly RTL design**, modular **RISC-V SoC architecture**, and a realistic path from **FPGA prototyping to ASIC implementation**.

## Tools Used

### RTL & Verification
- **RTL Design:** SystemVerilog
- **Functional Verification:** ModelSim

### FPGA Implementation
- **FPGA Tools:** Vivado
- **UART Communication:** Tera Term

### ASIC Implementation
- **Flow:** LibreLane
- **Tools:**  
  - Yosys  
  - OpenROAD  
  - Magic  
  - KLayout

### My Design Flow
1. RTL design and microarchitecture development

2. Functional simulation using SystemVerilog testbenches (ModelSim)

3. FPGA implementation using Vivado
→ timing closure, resource utilization, and power (PPA) analysis on FPGA

4. On-board validation on target FPGA platform (Optional) 

5. ASIC implementation using the LibreLane flow → timing closure, resource utilization, and power (PPA) analysis on ASIC


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

#### For the Design Details See 📁 /rtl

## FPGA Implementation
- **Target Board:** AX7010 (Zynq-7000 series)
- **Current Operating frequency**: 66.67 MHz
#### For the Details and Design Improvement See  📁 /vivado

## ASIC Implementation (RV32I Core Only)

### Tools
- LibreLane
- Yosys
- OpenROAD
- SKY130 PDK

#### For the Details See 📁 /asic_pd

## Future Work

- Add timer/counter peripherals
- Implement AXI, AXI4-Lite, and AXI-Stream interfaces
- Enable integration with external accelerators (e.g., AI accelerators)
- Full SoC ASIC implementation:
  - Instruction SRAM
  - Data SRAM
  - FIFO SRAM macros
  - IO pad integration
