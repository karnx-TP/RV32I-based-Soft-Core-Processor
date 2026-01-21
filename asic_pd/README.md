
# ASIC Implementation (RV32I Core Only)

### Tools
- LibreLane
- Yosys
- OpenROAD
- SKY130 PDK

## Baseline: Librelane default config with CLK_PERIOD: 30ns

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
- Max Cap Violation: 2
- Max Slew Violation: 165

### Power
- **4 mW** (core-only, estimated)

### Design Statistics
- Wires: 7,383
- Ports: 12
- Cells: 7,473


## Improvement 1

### **Configuration**
- SYNTH_HIERARCHY_MODE = **keep**
- MAX_FANOUT_CONSTRAINT = **6**

### Results
- Remain No setup & hold time violations
- Pass DRC,LVS
- Improve Setup WNS
- Reduce Slew violation

### Area
- **199,807 µm²**

### Timing
- Clock period: **30 ns**
- Operating frequency: **33 MHz**
- WNS:
  - Setup: 3.32 ns
  - Hold: 0.0454 ns
- Max Cap Violation: 2
- Max Slew Violation: 96

### Power
- **3.79 mW** (core-only, estimated)

### Design Statistics
- Wires: 7,383
- Ports: 12
- Cells: 7,473

---
