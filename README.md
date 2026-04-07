 Digital Stopwatch with Lap (Verilog)
 
Team Members

- Aktilek Abylaikyzy 

- Htet Oo Khin 

- Zar Ni Tun

Project Description

This project implements a digital stopwatch with lap functionality on the Nexys A7 FPGA board using Verilog.

The stopwatch measures time and displays it on a 7-segment display. Users can start/stop the timer, reset it, and store a lap value.

 Features

Start / Stop control

Reset functionality

Lap time capture

Real-time display on 7-segment display

 Inputs

clk → system clock (100 MHz)

btnu → Start / Stop

btnc → Reset

btnd → Lap

 Outputs

seg[6:0] → 7-segment segments

an[7:0] → display enable signals

dp → decimal point

 Planned Modules

top → top-level module

clk_divider → generates slower clock signals

debouncer → cleans button inputs

stopwatch_counter → counts time

lap_register → stores lap value

display_driver → controls 7-segment display

 System Overview

The system is composed of several modules responsible for clock division, input processing, time counting, and display control.

A block diagram will be added in the docs/ folder.

Project Structure

src/    → Verilog source files  

sim/    → testbenches  

xdc/    → FPGA constraints  

docs/   → diagrams and documentation  

 Week 1 Goals

Set up GitHub repository/
Define system architecture/
Create block diagram/
Prepare XDC constraints file/
Initialize project structure
