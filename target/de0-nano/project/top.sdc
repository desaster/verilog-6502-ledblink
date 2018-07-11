# Clock constraints

create_clock -name "CLOCK_50" -period 20 [get_ports {CLOCK_50}]
create_generated_clock -divide_by 50 -source [get_ports CLOCK_50] -name clk [get_registers clk_div_1|clk_out]
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
