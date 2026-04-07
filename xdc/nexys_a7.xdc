# Clock
set_property -dict { PACKAGE_PIN E3 IOSTANDARD LVCMOS33 } [get_ports {clk}]
create_clock -add -name sys_clk_pin -period 10.00 [get_ports {clk}]

# Buttons
set_property PACKAGE_PIN M18 [get_ports {btnU}]
set_property PACKAGE_PIN N17 [get_ports {btnC}]
set_property PACKAGE_PIN P18 [get_ports {btnD}]
set_property IOSTANDARD LVCMOS33 [get_ports {btnU btnC btnD}]

# 7-segment
set_property PACKAGE_PIN T10 [get_ports {seg[6]}]
set_property PACKAGE_PIN R10 [get_ports {seg[5]}]
set_property PACKAGE_PIN K16 [get_ports {seg[4]}]
set_property PACKAGE_PIN K13 [get_ports {seg[3]}]
set_property PACKAGE_PIN P15 [get_ports {seg[2]}]
set_property PACKAGE_PIN T11 [get_ports {seg[1]}]
set_property PACKAGE_PIN L18 [get_ports {seg[0]}]
set_property PACKAGE_PIN H15 [get_ports {dp}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg[*] dp}]

# Anodes
set_property PACKAGE_PIN J17 [get_ports {an[0]}]
set_property PACKAGE_PIN J18 [get_ports {an[1]}]
set_property PACKAGE_PIN T9  [get_ports {an[2]}]
set_property PACKAGE_PIN J14 [get_ports {an[3]}]
set_property PACKAGE_PIN P14 [get_ports {an[4]}]
set_property PACKAGE_PIN T14 [get_ports {an[5]}]
set_property PACKAGE_PIN K2  [get_ports {an[6]}]
set_property PACKAGE_PIN U13 [get_ports {an[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {an[*]}]
