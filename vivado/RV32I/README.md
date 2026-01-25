
# FPGA Implementation

### Version 1 — 3-Stage Pipeline

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

### Version 2 — 5-Stage Pipeline

**Target Board:** AX7010 (Zynq-7000 series)
**Synthesis Config** Keep Hierarchy

#### Resource Utilization
- LUTs: 1799
- FFs: 1536
- BRAMs: 10
- No Chipscope

#### Power
- 0.114 W

#### Timing
- Operating frequency: **50 MHz**
- WNS:
  - Setup: 2.103 ns
  - Hold: 0.075 ns
  - Pulse width: 9.5 ns

#### Improvements over Version 1
- Improved timing margin
- Reduced resource utilization
- Equivalent functionality

#### Critical Path
- Peripheral DataOut -> Hazard Bypassing -> Comparison(ALU) -> jmp_en -> PC Adder (Branch Unit) -> PC_next

---


### Version 3 — Timing Optimization (Current)

**Target Board:** AX7010 (Zynq-7000 series)
**Synthesis Config** Keep Hierarchy

#### Optimization
- Change Branch Execution into 2 cycle
- Move Branch Condition Lt/Gt in Top module (Near ALU)
- Change Stall Mechanism for memLd : Stall until data load into reg (no bypass) -> Stall 2 cycle
	- Fixing : Delete *Peripheral DataOut -> Hazard Bypassing* from the path then *Rd Reg -> Comparison(ALU) -> jmp_en* -> (reg) -> *PC Adder (Branch Unit) -> PC_next*
- Some Logic adjustment (more mux style for tools to cut critical path) and move some logic 
- Current Critical Path : Reg Rd->ALU (SUB for comparison)->Condition summary logic->jmp_en signal 


#### Resource Utilization
- LUTs: 1882
- FFs: 1676
- BRAMs: 10
- No Chipscope

#### Power
- 0.124 W

#### Timing
- Operating frequency: **66.67 MHz**
- WNS:
  - Setup: 0.354 ns
  - Hold: 0.034 ns
  - Pulse width: 7.0 ns

#### Improvements over Version 1
- Improved timing margin
- Reduced resource utilization
- Equivalent functionality

---

## CPI and MIPS Calculation for FPGA (Current Version)

### Assumptions
- Base CPI (ideal pipeline): 0.65  
- 20% of instructions incur a branching (2-cycle execution)
- 15% of instructions incur a 3-cycle stall (load-use hazard)  
- Clock frequency: 66.67 MHz  

### CPI Calculation
```
CPI = 0.65 + (0.20 × 2) + (0.15 × 3)
    = 0.65 + 0.40 + 0.45
    = 1.50
```

### MIPS Calculation
```
MIPS = Clock Frequency / CPI
     = 66.67 MHz / 1.50
     ≈ 44.44 MIPS
```