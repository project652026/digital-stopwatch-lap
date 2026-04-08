# **Digital Stopwatch with Lap (Verilog)**
 
### **Team Members**

- Aktilek Abylaikyzy 

- Htet Oo Khin 

- Zar Ni Tun

## **Project Description**

This project implements a digital stopwatch with lap functionality on the Nexys A7 FPGA board using Verilog.

The stopwatch measures time and displays it on a 7-segment display. Users can start/stop the timer, reset it, and store a lap value.

**Features**

Start / Stop control

Reset functionality

Lap time capture

Real-time display on 7-segment display

| **Port name** | **Direction** | **Type** | **Description** |
|:------------:|:----------:|:----------:|:----------:|
| `clk`        | input     | `wire`     | Main clock      |
| `btnd`       | input     | `wire`     | Start / Stop     |
| `btnu`       | input     | `wire`     | High-active synchronous reset     |
| `btnr`       | input     | `wire`     | Lap     |
| `seg[6:0]`    | output     | `wire [6:0]`     | Seven-segment cathodes      |
| `an[7:0]`    | output     | `wire [7:0]`     | Seven-segment anodes     |
| `dp`         | output     | `wire`     | Seven-segment decimal point     |



**Planned Modules**

top → top-level module

clk_divider → generates slower clock signals

debouncer → cleans button inputs

stopwatch_counter → counts time

lap_register → stores lap value

display_driver → controls 7-segment display


**System Overview**

The system is composed of several modules responsible for clock division, input processing, time counting, and display control.

A block diagram will be added in the docs/ folder.

**Project Structure**

src/    → Verilog source files  

sim/    → testbenches  

xdc/    → FPGA constraints  

docs/   → diagrams and documentation  


**Week 1 Goals:**

1. Set up GitHub repository
2. Define system architecture
3. Create block diagram
4. Prepare XDC constraints file
5. Initialize project structure
