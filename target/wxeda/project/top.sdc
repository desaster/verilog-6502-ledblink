#************************************************************
# THIS IS A WIZARD-GENERATED FILE.                           
#
# Version 11.1 Build 259 01/25/2012 Service Pack 2 SJ Web Edition
#
#************************************************************

# Copyright (C) 1991-2011 Altera Corporation
# Your use of Altera Corporation's design tools, logic functions 
# and other software and tools, and its AMPP partner logic 
# functions, and any output files from any of the foregoing 
# (including device programming or simulation files), and any 
# associated documentation or information are expressly subject 
# to the terms and conditions of the Altera Program License 
# Subscription Agreement, Altera MegaCore Function License 
# Agreement, or other applicable license agreement, including, 
# without limitation, that your use is for the sole purpose of 
# programming logic devices manufactured by Altera and sold by 
# Altera or its authorized distributors.  Please refer to the 
# applicable agreement for further details.



# Clock constraints

create_clock -name "CLOCK_48" -period 20.833ns [get_ports {CLOCK_48}]
create_generated_clock -divide_by 48 -source [get_ports CLOCK_48] -name clk [get_registers clk_div_1|clk_out]
# clk_div:clk_div_1|clk_out
# clk_div:clk_div_1|clk_out~reg0
# clk_div:clk_div_q
# clk_div_1|clk_out


# Automatically constrain PLL and other generated clocks
#derive_pll_clocks -create_base_clocks

# Automatically calculate clock uncertainty to jitter and other effects.
derive_clock_uncertainty

# tsu/th constraints

# tco constraints

# tpd constraints

