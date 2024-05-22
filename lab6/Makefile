all:
	compile simulate

compile:
	verilator -Wall top.v main.cpp --cc --trace --exe --build
	
simulation:
	./obj_dir/Vtop
wave:
	$(call git_commit, "sim RTL") # DO NOT REMOVE THIS LINE!!!
	gtkwave wave.vcd
	
clean:
	rm -f *.vcd
