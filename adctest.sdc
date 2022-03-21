## Generated SDC file "adctest.sdc"

## Copyright (C) 2021  Intel Corporation. All rights reserved.
## Your use of Intel Corporation's design tools, logic functions 
## and other software and tools, and any partner logic 
## functions, and any output files from any of the foregoing 
## (including device programming or simulation files), and any 
## associated documentation or information are expressly subject 
## to the terms and conditions of the Intel Program License 
## Subscription Agreement, the Intel Quartus Prime License Agreement,
## the Intel FPGA IP License Agreement, or other applicable license
## agreement, including, without limitation, that your use is for
## the sole purpose of programming logic devices manufactured by
## Intel and sold by Intel or its authorized distributors.  Please
## refer to the applicable agreement for further details, at
## https://fpgasoftware.intel.com/eula.


## VENDOR  "Altera"
## PROGRAM "Quartus Prime"
## VERSION "Version 21.1.0 Build 842 10/21/2021 SJ Lite Edition"

## DATE    "Tue Mar 15 12:19:13 2022"

##
## DEVICE  "EP4CE22F17C6"
##


#**************************************************************
# Time Information
#**************************************************************

set_time_format -unit ns -decimal_places 3



#**************************************************************
# Create Clock
#**************************************************************

create_clock -name {CLOCK_50} -period 20.000 -waveform { 0.000 10.000 } [get_ports {CLOCK_50}]
create_clock -name {ADC_CLK} -period 640.000 -waveform { 0.000 320.000 } [get_nets {logicPLL|adcClk_out logicPLL|adcClk_ext}]
create_clock -name {SCLK} -period 82000.000 -waveform { 0.000 41000.000 } [get_nets {logicPLL|sClk_out}]


#**************************************************************
# Create Generated Clock
#**************************************************************



#**************************************************************
# Set Clock Latency
#**************************************************************



#**************************************************************
# Set Clock Uncertainty
#**************************************************************

set_clock_uncertainty -rise_from [get_clocks {CLOCK_50}] -rise_to [get_clocks {CLOCK_50}]  0.020  
set_clock_uncertainty -rise_from [get_clocks {CLOCK_50}] -fall_to [get_clocks {CLOCK_50}]  0.020  
set_clock_uncertainty -rise_from [get_clocks {CLOCK_50}] -rise_to [get_clocks {ADC_CLK}]  0.030  
set_clock_uncertainty -rise_from [get_clocks {CLOCK_50}] -fall_to [get_clocks {ADC_CLK}]  0.030  
set_clock_uncertainty -rise_from [get_clocks {CLOCK_50}] -rise_to [get_clocks {SCLK}]  0.030  
set_clock_uncertainty -rise_from [get_clocks {CLOCK_50}] -fall_to [get_clocks {SCLK}]  0.030  
set_clock_uncertainty -fall_from [get_clocks {CLOCK_50}] -rise_to [get_clocks {CLOCK_50}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {CLOCK_50}] -fall_to [get_clocks {CLOCK_50}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {CLOCK_50}] -rise_to [get_clocks {ADC_CLK}]  0.030  
set_clock_uncertainty -fall_from [get_clocks {CLOCK_50}] -fall_to [get_clocks {ADC_CLK}]  0.030  
set_clock_uncertainty -fall_from [get_clocks {CLOCK_50}] -rise_to [get_clocks {SCLK}]  0.030  
set_clock_uncertainty -fall_from [get_clocks {CLOCK_50}] -fall_to [get_clocks {SCLK}]  0.030  
set_clock_uncertainty -rise_from [get_clocks {ADC_CLK}] -rise_to [get_clocks {ADC_CLK}]  0.020  
set_clock_uncertainty -rise_from [get_clocks {ADC_CLK}] -fall_to [get_clocks {ADC_CLK}]  0.020  
set_clock_uncertainty -rise_from [get_clocks {ADC_CLK}] -rise_to [get_clocks {SCLK}]  0.020  
set_clock_uncertainty -rise_from [get_clocks {ADC_CLK}] -fall_to [get_clocks {SCLK}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {ADC_CLK}] -rise_to [get_clocks {ADC_CLK}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {ADC_CLK}] -fall_to [get_clocks {ADC_CLK}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {ADC_CLK}] -rise_to [get_clocks {SCLK}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {ADC_CLK}] -fall_to [get_clocks {SCLK}]  0.020  
set_clock_uncertainty -rise_from [get_clocks {SCLK}] -rise_to [get_clocks {CLOCK_50}]  0.030  
set_clock_uncertainty -rise_from [get_clocks {SCLK}] -fall_to [get_clocks {CLOCK_50}]  0.030  
set_clock_uncertainty -rise_from [get_clocks {SCLK}] -rise_to [get_clocks {ADC_CLK}]  0.020  
set_clock_uncertainty -rise_from [get_clocks {SCLK}] -fall_to [get_clocks {ADC_CLK}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {SCLK}] -rise_to [get_clocks {CLOCK_50}]  0.030  
set_clock_uncertainty -fall_from [get_clocks {SCLK}] -fall_to [get_clocks {CLOCK_50}]  0.030  
set_clock_uncertainty -fall_from [get_clocks {SCLK}] -rise_to [get_clocks {ADC_CLK}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {SCLK}] -fall_to [get_clocks {ADC_CLK}]  0.020  
set_clock_uncertainty -rise_from [get_clocks {ADC_CLK}] -rise_to [get_clocks {CLOCK_50}]  0.030  
set_clock_uncertainty -rise_from [get_clocks {ADC_CLK}] -fall_to [get_clocks {CLOCK_50}]  0.030  
set_clock_uncertainty -fall_from [get_clocks {ADC_CLK}] -rise_to [get_clocks {CLOCK_50}]  0.030  
set_clock_uncertainty -fall_from [get_clocks {ADC_CLK}] -fall_to [get_clocks {CLOCK_50}]  0.030  


#**************************************************************
# Set Input Delay
#**************************************************************

set_input_delay -add_delay  -clock_fall -clock [get_clocks {ADC_CLK}]  2.000 [get_ports {ADC_SDAT}]
set_input_delay -add_delay  -clock [get_clocks {CLOCK_50}]  2.000 [get_ports {KEY_0}]
set_input_delay -add_delay  -clock [get_clocks {CLOCK_50}]  2.000 [get_ports {KEY_1}]


#**************************************************************
# Set Output Delay
#**************************************************************

set_output_delay -add_delay  -clock_fall -clock [get_clocks {ADC_CLK}]  2.000 [get_ports {ADC_CS_N}]
set_output_delay -add_delay  -clock_fall -clock [get_clocks {ADC_CLK}]  2.000 [get_ports {ADC_SADDR}]
set_output_delay -add_delay  -clock [get_clocks {CLOCK_50}]  1.000 [get_ports {ADC_SCLK}]
set_output_delay -add_delay  -clock [get_clocks {CLOCK_50}]  1.000 [get_ports {GPIO_09}]


#**************************************************************
# Set Clock Groups
#**************************************************************



#**************************************************************
# Set False Path
#**************************************************************



#**************************************************************
# Set Multicycle Path
#**************************************************************



#**************************************************************
# Set Maximum Delay
#**************************************************************



#**************************************************************
# Set Minimum Delay
#**************************************************************



#**************************************************************
# Set Input Transition
#**************************************************************

