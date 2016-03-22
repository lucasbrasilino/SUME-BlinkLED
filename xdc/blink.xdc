## This file is a general .xdc for the NetFPGA SUME Rev. C
## To use it in a project:
## - uncomment the lines corresponding to used pins
## - rename the used ports (in each line, after get_ports) according to the top level signal names in the project
## Note: DDR, QDR, and GTH Transceiver constraints are not included with this document. See applicable reference 
##       projects on www.netfpga.org for information on using these components

# 200MHz System Clock -- SUME
set_property PACKAGE_PIN H19 [get_ports FPGA_SYSCLK_P]
set_property VCCAUX_IO DONTCARE [get_ports FPGA_SYSCLK_P]
set_property IOSTANDARD LVDS [get_ports FPGA_SYSCLK_P]
set_property IOSTANDARD LVDS [get_ports FPGA_SYSCLK_N]

create_clock -period 5.000 -name FPGA_SYSCLK_P -waveform {0.000 2.500} [get_ports FPGA_SYSCLK_P]

set_property -dict { PACKAGE_PIN AR13  IOSTANDARD LVCMOS15 } [get_ports { reset }];
set_false_path -from [get_ports reset]

# Internal LEDs
set_property -dict { PACKAGE_PIN AR22  IOSTANDARD LVCMOS15 } [get_ports { LED[0] }]; #IO_L11N_T1_SRCC_33 Sch=led[0]
set_property -dict { PACKAGE_PIN AR23  IOSTANDARD LVCMOS15 } [get_ports { LED[1] }]; #IO_L11P_T1_SRCC_33 Sch=led[1]

# SFPs LEDs
set_property -dict { PACKAGE_PIN G13   IOSTANDARD LVCMOS15 } [get_ports { ETH_A_LED[0] }]; #IO_L12N_T1_MRCC_39 Sch=eth1_led[0]
set_property -dict { PACKAGE_PIN L15   IOSTANDARD LVCMOS15 } [get_ports { ETH_B_LED[0] }]; #IO_L18N_T2_39 Sch=eth1_led[1]
set_property -dict { PACKAGE_PIN AL22  IOSTANDARD LVCMOS15 } [get_ports { ETH_A_LED[1] }]; #IO_L6P_T0_33 Sch=eth2_led[0]
set_property -dict { PACKAGE_PIN BA20  IOSTANDARD LVCMOS15 } [get_ports { ETH_B_LED[1] }]; #IO_L22N_T3_32 Sch=eth2_led[1]
set_property -dict { PACKAGE_PIN AY18  IOSTANDARD LVCMOS15 } [get_ports { ETH_A_LED[2] }]; #IO_L13P_T2_MRCC_32 Sch=eth3_led[0]
set_property -dict { PACKAGE_PIN AY17  IOSTANDARD LVCMOS15 } [get_ports { ETH_B_LED[2] }]; #IO_L13N_T2_MRCC_32 Sch=eth3_led[1]
set_property -dict { PACKAGE_PIN P31   IOSTANDARD LVCMOS15 } [get_ports { ETH_A_LED[3] }]; #IO_L18N_T2_34 Sch=eth4_led[0]
set_property -dict { PACKAGE_PIN K32   IOSTANDARD LVCMOS15 } [get_ports { ETH_B_LED[3] }]; #IO_L12N_T1_MRCC_34 Sch=eth4_led[1]
