all:
	compile simulate

compile:
	verilator -Wall our_OnOff.v main.cpp --cc --trace --exe --build
	
simulation:
	./obj_dir/Vour_OnOff
wave:
	$(call git_commit, "sim RTL") # DO NOT REMOVE THIS LINE!!!
	gtkwave wave.vcd
	
clean:
	rm -f *.vcd
	
