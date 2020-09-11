set_property PACKAGE_PIN M19 [get_ports sw1]
set_property IOSTANDARD LVCMOS18 [get_ports sw1]

set_property PACKAGE_PIN M20 [get_ports sw0]
set_property IOSTANDARD LVCMOS18 [get_ports sw0]

set_property PACKAGE_PIN N15 [get_ports sum]
set_property IOSTANDARD LVCMOS18 [get_ports sum]

set_property PACKAGE_PIN M15 [get_ports carry]
set_property IOSTANDARD LVCMOS18 [get_ports carry]

set_property PACKAGE_PIN D19 [get_ports rst_n]
set_property IOSTANDARD LVCMOS18 [get_ports rst_n]

set_property PACKAGE_PIN R14 [get_ports triggerbit]
set_property IOSTANDARD LVCMOS18 [get_ports triggerbit]

set_property -dict {PACKAGE_PIN H16 IOSTANDARD LVCMOS18} [get_ports clk]
create_clock -period 20.000 -name clk_pin -waveform {0.000 10.000} -add [get_ports clk]
