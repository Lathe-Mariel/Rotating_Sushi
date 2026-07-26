//Copyright (C)2014-2026 GOWIN Semiconductor Corporation.
//All rights reserved.
//File Title: Timing Constraints file
//Tool Version: V1.9.12.01 (64-bit) 
//Created Time: 2026-07-26 22:12:31
create_clock -name clk -period 20 -waveform {0 10} [get_ports {clk}]
