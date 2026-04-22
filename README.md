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

- `clk_en` → generates a slower clock for timing
- `debounce` → processes button inputs and removes noise
- `stopwatch_counter` → tracks elapsed time
- `lap_register` → stores captured lap values
- `display_driver` → controls the 7-segment display
- `top` → connects all modules together

## **Parameter Definition**
```
N = 32
CLK_FREQ = 100_000_000
MAX = 1_000_000
TICK_MS = 10
```
**Description**

- `N` – Bit-width of time and lap counters (`time[N-1:0]`, `lap[N-1:0]`)
- `CLK_FREQ` – FPGA system clock frequency (100 MHz)
- `MAX` – Clock divider value used to generate a 10 ms enable pulse
- `TICK_MS` – Time resolution of the stopwatch (each count = 10 ms)


### **Data Flow**

Buttons → Debouncer → Control Logic → Counter → Display Driver → 7-Segment Display

## **System Overview**

The system is composed of several modules responsible for:

- Clock division
- Input processing (debouncing)  
- Time counting  
- Display control
   
## **Block Diagram**

<img width="1337" height="783" alt="image" src="https://github.com/user-attachments/assets/90c30d9b-7fc8-414e-bf7a-84d13e2acd8d" />


## **Block Diagram Explanation**
 
#### STEP 1 — clk (Main Clock)
 
The `clk` signal enters from the left.
It is the **100 MHz** system clock from the FPGA board — it ticks 100 million times per second.
 
It fans out to **every single module** — you can see it branch at the junction dots (●) and reach `clk_en`, `debouncer`, `stopwatch_counter`, `lap_register`, and `display_driver`.
 
---
 
#### STEP 2 — clk_en (Clock Divider)
 
100 MHz is **way too fast** to count human time directly.
 
`clk_en` counts up to **1,000,000** then fires a single pulse called `en_10ms`.
 
```
100,000,000 ÷ 1,000,000 = 100 pulses/sec → one pulse every 10ms
```
 
This `en_10ms` signal is sent to `debouncer`, `stopwatch_counter`, and `display_driver` so they all tick at the same slow rate.
 
---
 
#### STEP 3 — Buttons (Raw Input)
 
Four buttons enter from the left:
 
| Button | Function |
|:------:|:--------:|
| `btnd` | Start / Stop |
| `btnu` | Reset |
| `btnr` | Capture lap |
| `btnl` | Switch display to lap view |
 
---
 
#### STEP 4 — debouncer (Button Cleaner)
 
The `debouncer` samples each button every **10ms** (using `en_10ms`).
 
By only checking once every 10ms, the bounce noise is ignored and you get a **clean single pulse** per press.
 
Output signals:
- `start_stop` → to counter's `en`
- `rst_btn` → to counter's `rst`
- `lap_btn` → to lap register
- `disp_btn` → to display driver
 
---
 
#### STEP 5 — stopwatch_counter (Time Tracker)
 
This module tracks elapsed time using a counter of width `N` bits.
- `time[N-1:0]` → current time value
- `N = 32` (parameter defining counter size)

The counter increments on every `en_10ms` pulse:
 
| Signal | Condition | Effect |
|:------:|:---------:|:------:|
| `en = 1` | start_stop active | counting |
| `en = 0` | — | paused |
| `rst = 1` | — | reset to zero |
 
Each increment corresponds to **10 ms**, so total time is:
```
time × 10 ms
```
The `time[N-1:0]` signal is sent to:
- display_driver
- lap_register
 
---
 
#### STEP 6 — lap_register (Lap Memory)
 
When you press `btnr`, the debouncer fires `lap_btn`.
 
The `lap_register` **freezes a copy** of the current `time[N-1:0]` value and holds it as `lap[N-1:0]`.
 
The main counter **keeps running** — the lap register just takes a snapshot.
 
The stored lap value is sent to the `display_driver` and shown when `disp_btn` is pressed.
 
---
 
#### STEP 7 — display_driver (7-Segment Output)
 
The `display_driver` receives both `time[N-1:0]` and `lap[N-1:0]`.
 
| `disp_btn` | Display shows |
|:----------:|:-------------:|
| `0` | Live running time |
| `1` | Stored lap time |
 
It converts the binary number to **decimal digits** and drives the display by:
- Cycling `an[7:0]` — selecting which digit is ON
- Setting `seg[6:0]` — which segments light up (a–g)
- `dp` — decimal point between seconds and ms
 
---

## **Project Structure**

- `src/`    → Verilog source files  

- `sim/`    → Testbenches for simulation 

- `xdc/`    → Constraint files for Nexys A7  

- `docs/`   → Block diagrams and documentation


## **Lab 1 Goals: Architecture**

1. Set up GitHub repository
2. Define system architecture
3. Create block diagram
4. Prepare XDC constraints file
5. Initialize project structure


## **Lab 2 Goals: Unit Design**

1. Develop individual modules
2. Implement core unit functionality
3. Create and run testbenches
4. Verify modules through simulation
5. Debug and refine unit behavior
6. Commit progress and updates to Git

