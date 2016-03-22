

all: clean
	vivado -mode batch -source ./tcl/netfpga-blink.tcl

clean:
	rm -f vivado*
	if test -d project/; then rm -rf ./project; fi
