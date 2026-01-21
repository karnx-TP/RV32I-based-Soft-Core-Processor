# RTL Design Description

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

