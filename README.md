# SUME-BlinkLED
NetFPGA-SUME blinking LEDs design

## Introduction
This design was created to help some programming issues on NetFPGA-SUME board.
Our boards are installed in server cluster, that are mounted in a 48U's rack.
It blinks the SFP/Ethernet LEDs in two different patterns, so it is easy to 
check if the boards were programmed by standing behind the rack and watch the
LEDs blinking pattern.

## Compiling
The design was tested and synthesized with Vivado 2014.4 and 2015.4. Just do:

    $ source /opt/Xilinx/SDK/2015.4/settings64.sh
    $ make

The bitfiles will be saved on `bitfiles` directory.
 
