
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

### Version 2 — 5-Stage Pipeline (Current)

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

---