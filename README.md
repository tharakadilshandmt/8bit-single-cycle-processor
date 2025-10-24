# Simple 8-bit Single-Cycle Processor 

## Overview

This repository contains the full implementation of a simple 8-bit single-cycle processor designed using **Verilog HDL**. It was completed as part of the CO224 - Computer Architecture course at the Department of Computer Engineering, University of Peradeniya. The project demonstrates a step-by-step design of a functional processor — from building individual components like the ALU and Register File to integrating full instruction set support, control logic, and extended ISA.

Each part of the lab was developed, tested, and committed separately to illustrate the progressive construction of the processor.

---

## Part 1 – Arithmetic Logic Unit (ALU)

### Objective

To design and implement an **8-bit ALU** capable of executing arithmetic and logical operations required for the base instruction set.

### Implemented Instructions

* **add** – Addition of two registers.
* **sub** – Subtraction using two's complement.
* **and** – Bitwise AND.
* **or** – Bitwise OR.
* **mov** – Move data from one register to another.
* **loadi** – Load immediate value into a register.

### Features

* 8-bit inputs (`DATA1`, `DATA2`) and output (`RESULT`).
* 3-bit control signal (`SELECT`) to select operation.
* Separate submodules for each operation (ADD, AND, OR, FORWARD).
* Multiplexer used to select output based on control signal.
* Artificial operation delays introduced for realistic simulation.

### Testing

A comprehensive testbench verified all ALU operations under various input combinations. The timing diagrams were analyzed using **GTKWave**.

---

## Part 2 – Register File

### Objective

To design an **8×8 Register File** capable of reading and writing 8-bit data, serving as storage for the ALU operations.

### Features

* Eight 8-bit registers.
* One data input port (`IN`) and two output ports (`OUT1`, `OUT2`).
* Address inputs for each port (`INADDRESS`, `OUT1ADDRESS`, `OUT2ADDRESS`).
* Write control (`WRITE`) and synchronous `CLOCK` and `RESET` signals.
* Asynchronous read and synchronous write behavior.
* Artificial delays for realistic simulation (read = #2, write = #1).

### Testing

Thoroughly tested using custom testbench verifying register read/write operations and reset behavior with simulated timing using GTKWave.

---

## Part 3 – Integration & Control Logic

### Objective

To integrate the **ALU** and **Register File** into a functional CPU capable of executing the base set of instructions with proper **control logic** and a **Program Counter (PC)**.

### Components

* ALU and Register File integrated.
* Control logic implemented to decode 32-bit instructions.
* Instruction memory simulated via a hardcoded array.
* Program Counter with auto-increment by 4.
* Two’s complement operation used to support subtraction.
* Artificial timing delays included for PC update, instruction fetch, decode, and ALU operations.

### Supported Instructions

* add, sub, and, or, mov, loadi.

### Testing

A testbench with several instruction sequences was used to verify CPU operation, synchronization, and instruction timing. Timing diagrams confirmed that each instruction completed within one clock cycle (8 time units).

---

## Part 4 – Flow Control Instructions

### Objective

To extend the CPU to support **flow control instructions** — jump and branch operations.

### Newly Supported Instructions

* **j** – Unconditional jump.
* **beq** – Branch if equal.

### Modifications

* Added **ZERO** output in ALU to support branch comparisons.
* Introduced a **branch/jump adder** to compute target addresses.
* Updated control logic to manipulate the **Program Counter** based on instruction type.
* Updated datapath and timing control for j and beq.

### Testing

Testbench programs demonstrated correct jump and branch behavior. Timing diagrams were analyzed to confirm PC manipulation and synchronization with control logic.

---

## Part 5 – Extended ISA (Bonus Implementation)

### Objective

To expand the instruction set with additional operations.

### Implemented Extended Instructions

* **mult** – Multiply two register values.
* **sll** – Shift logical left.
* **srl** – Shift logical right.

### Modifications

* New functional units added inside ALU for multiplication and shift operations.
* Updated control logic to map new instructions to existing 3-bit ALUOP.
* Verified that all new instructions execute within a single clock cycle.

### Testing

All extended instructions were tested using appropriate testbench sequences and validated through waveform analysis.

---

## Tools and Environment

* **Language:** Verilog HDL
* **Simulation Tools:** ModelSim / GTKWave
* **Assembler:** CO224Assembler (C-based)
* **Platform:** Linux-based environment

---

## Folder Structure

```
├── part1/                 # ALU Design and Testbench
├── part2/                 # Register File Implementation and Tests
├── part3/                 # CPU Integration and Control Logic
├── part4/                 # Flow Control Instructions (j, beq)
├── part5/                 # Extended ISA (mult, sll, srl)
├── LICENSE                # License file
├── README.md              # Project documentation
└── Report.pdf             # Detailed report of implementation and results
```

---

## License

This project is released under the **MIT License**. See the [LICENSE](./LICENSE) file for more details.

---

## Author

**Tharaka Dilshan**
Department of Computer Engineering, University of Peradeniya

This project represents my individual design and understanding of processor architecture — from fundamental digital components to complete CPU integration. It serves as a demonstration of my technical skills in digital system design and hardware description languages, aimed at potential research opportunities in computer architecture and embedded systems.
