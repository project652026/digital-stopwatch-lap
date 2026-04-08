# **Digital Stopwatch with Lap (Verilog)**
 
## **Team Members**

- Aktilek Abylaikyzy 

- Htet Oo Khin 

- Zar Ni Tun

## **Project Description**

This project implements a **digital stopwatch with lap functionality** on the Nexys A7 FPGA board using Verilog.

The stopwatch measures time and displays it on a **seven-segment display**. Users can start/stop the timer, reset it, and store a lap value.

### **Features**

- Start / Stop control

- Reset functionality

- Lap time capture

- Real-time display on 7-segment display

### **Top-Level I/O Ports**

| **Port name** | **Direction** | **Type** | **Description** |
|:------------:|:----------:|:----------:|:----------:|
| `clk`        | input     | `wire`     | Main clock      |
| `btnd`       | input     | `wire`     | Start / Stop     |
| `btnu`       | input     | `wire`     | Reset button     |
| `btnr`       | input     | `wire`     | Lap button     |
| `btnl`       | input     | `wire`     | Display stored values button |
| `seg[6:0]`    | output     | `wire [6:0]`     | Seven-segment cathodes      |
| `an[7:0]`    | output     | `wire [7:0]`     | Seven-segment anodes     |
| `dp`         | output     | `wire`     | Decimal point     |


## **System Architecture**

The system is organized as a modular design:

- `clk_divider` → generates a slower clock for timing
- `debouncer` → processes button inputs and removes noise
- `stopwatch_counter` → tracks elapsed time
- `lap_register` → stores captured lap values
- `display_driver` → controls the 7-segment display
- `top` → connects all modules together

### **Data Flow**

Buttons → Debouncer → Control Logic → Counter → Display Driver → 7-Segment Display

## **System Overview**

The system is composed of several modules responsible for:

- Clock division
- Input processing (debouncing)  
- Time counting  
- Display control  

A block diagram will be added in the `docs/` folder and here later.

## **Project Structure**

- `src/`    → Verilog source files  

- `sim/`    → Testbenches for simulation 

- `xdc/`    → Constraint files for Nexys A7  

- `docs/`   → Block diagrams and documentation  


## **Week 1 Goals**

1. Set up GitHub repository
2. Define system architecture
3. Create block diagram
4. Prepare XDC constraints file
5. Initialize project structure
