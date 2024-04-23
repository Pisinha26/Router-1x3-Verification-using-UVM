#Makefile for UVM Testbench - Lab 06

# SIMULATOR = Questa for Mentor's Questasim
# SIMULATOR = VCS for Synopsys's VCS

SIMULATOR = VCS

FSDB_PATH=/home/cad/eda/SYNOPSYS/VERDI_2022/verdi/T-2022.06-SP1/share/PLI/VCS/LINUX64

RTL= ../rtl/*
work= work #library name
SVTB1= ../top/Router_top.sv
INC = +incdir+../top +incdir+../test +incdir+../source_agent_top +incdir+../destination_agent_top 
SVTB2 = ../test/router_test_pkg.sv
VSIMOPT= -vopt -voptargs=+acc 
VSIMCOV= -coverage -sva 
VSIMBATCH1= -c -do  " log -r /* ;coverage save -onexit mem_cov1;run -all; exit"
VSIMBATCH2= -c -do  " log -r /* ;coverage save -onexit mem_cov2;run -all; exit"
VSIMBATCH3= -c -do  " log -r /* ;coverage save -onexit mem_cov3;run -all; exit"
VSIMBATCH4= -c -do  " log -r /* ;coverage save -onexit mem_cov4;run -all; exit"
VSIMBATCH5= -c -do  " log -r /* ;coverage save -onexit mem_cov5;run -all; exit"
VSIMBATCH6= -c -do  " log -r /* ;coverage save -onexit mem_cov6;run -all; exit"


help:
	@echo =============================================================================================================
	@echo "! USAGE   	--  make target                             							                                            !"
	@echo "! clean   	=>  clean the earlier log and intermediate files.       					                                    !"
	@echo "! sv_cmp    	=>  Create library and compile the code.                   					                                !"
	@echo "! run_test	=>  clean, compile & run the simulation for ram_signle_adddr_test in batch mode.		                  !" 
	@echo "! run_test1	=>  clean, compile & run the simulation for ram_ten_addr_test in batch mode.			                  !" 
	@echo "! run_test2	=>  clean, compile & run the simulation for ram_odd_addr_test in batch mode.			                  !"
	@echo "! run_test3	=>  clean, compile & run the simulation for ram_even_addr_test in batch mode.		                    !" 
	@echo "! view_wave1 =>  To view the waveform of ram_signle_addr_test                                                    !"
	@echo "! view_wave2 =>  To view the waveform of ram_ten_addr_test                                                       !" 
	@echo "! view_wave3 =>  To view the waveform of ram_odd_addr_test                                                       !" 
	@echo "! view_wave4 =>  To view the waveform of ram_even_addr_test                                                      !" 
	@echo ====================================================================================================================

clean : clean_$(SIMULATOR)
sv_cmp : sv_cmp_$(SIMULATOR)
run_test : run_test_$(SIMULATOR)
run_test1 : run_test1_$(SIMULATOR)
run_test2 : run_test2_$(SIMULATOR)
run_test3 : run_test3_$(SIMULATOR)
run_test4 : run_test4_$(SIMULATOR)
run_test5 : run_test5_$(SIMULATOR)
view_wave1 : view_wave1_$(SIMULATOR)
view_wave2 : view_wave2_$(SIMULATOR)
view_wave3 : view_wave3_$(SIMULATOR)
view_wave4 : view_wave4_$(SIMULATOR)
view_wave5 : view_wave5_$(SIMULATOR)
view_wave6 : view_wave6_$(SIMULATOR)
regress : regress_$(SIMULATOR)
report : report_$(SIMULATOR)
cov : cov_$(SIMULATOR)

# ----------------------------- Start of Definitions for Mentor's Questa Specific Targets -------------------------------#

sv_cmp_Questa:
	vlib $(work)
	vmap work $(work)
	vlog -work $(work) $(RTL) $(INC) $(SVTB2) $(SVTB1) 	
	
run_test_Questa: clean sv_cmp_Questa
	vsim  $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH1)  -wlf wave.wlf -l test1.log  -sv_seed random  Router_top +UVM_TESTNAME=router_small_wr_test
	
run_test1_Questa: clean sv_cmp
	vsim  $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH2)  -wlf wave1.wlf -l test2.log  -sv_seed random  work.top +UVM_TESTNAME=ram_ten_addr_test
	
run_test2_Questa: clean sv_cmp
	vsim  $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH3)  -wlf wave2.wlf -l test3.log  -sv_seed random  work.top +UVM_TESTNAME=ram_odd_addr_test
	
run_test3_Questa: clean sv_cmp
	vsim  $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH4)  -wlf wave3.wlf -l test4.log  -sv_seed random  work.top +UVM_TESTNAME=ram_even_addr_test
	
clean_Questa: 
	rm -rf transcript* *log* fcover* covhtml* mem_cov* *.wlf modelsim.ini work
	clear


view_wave1_Questa: 
	vsim -view wave.wlf

view_wave2_Questa: 
	vsim -view wave1.wlf

view_wave3_Questa: 
	vsim -view wave2.wlf

view_wave4_Questa: 
	vsim -view wave3.wlf


# ----------------------------- End of Definitions for Mentor's Questa Specific Targets -------------------------------#


# ----------------------------- Start of Definitions for Synopsys's VCS Specific Targets -------------------------------#

sv_cmp_VCS:
	vcs -l vcs.log -timescale=1ns/1ps -sverilog -ntb_opts uvm -debug_access+all -full64 -kdb -lca -P $(FSDB_PATH)/novas.tab $(FSDB_PATH)/pli.a $(RTL) $(INC) $(SVTB2) $(SVTB1) 
	      
run_test_VCS:	clean  sv_cmp_VCS
	./simv -a vcs.log +fsdbfile+wave.fsdb -cm_dir ./mem_cov1 +ntb_random_seed=2466253730 +UVM_TESTNAME=router_base_test +UVM_VERBOSITY = UVM_LOW
	urg -dir mem_cov1.vdb -format both -report urgReport1

run_test1_VCS: clean  sv_cmp_VCS	
	./simv -a vcs.log +fsdbfile+wave1.fsdb -cm_dir ./mem_cov2 +ntb_random_seed=166782711 +UVM_TESTNAME=router_small_wr_test +UVM_VERBOSITY = UVM_NONE	
	urg -dir mem_cov2.vdb -format both -report urgReport2

run_test2_VCS: clean  sv_cmp_VCS	
	./simv -a vcs.log +fsdbfile+wave2.fsdb -cm_dir ./mem_cov3 +ntb_random_seed=2533310536 +UVM_TESTNAME=router_medium_wr_test +UVM_VERBOSITY = UVM_NONE
	urg -dir mem_cov3.vdb -format both -report urgReport3

run_test3_VCS: clean  sv_cmp_VCS	
	./simv -a vcs.log +fsdbfile+wave3.fsdb -cm_dir ./mem_cov4 +ntb_random_seed=2666472349 +UVM_TESTNAME=router_big_wr_test +UVM_VERBOSITY = UVM_LOW
	urg -dir mem_cov4.vdb -format both -report urgReport4

run_test4_VCS: clean  sv_cmp_VCS	
	./simv -a vcs.log +fsdbfile+wave4.fsdb -cm_dir ./mem_cov5 +ntb_random_seed=3359817822 +UVM_TESTNAME=router_random_wr_test +UVM_VERBOSITY = UVM_LOW
	urg -dir mem_cov5.vdb -format both -report urgReport5

run_test5_VCS: clean  sv_cmp_VCS	
	./simv -a vcs.log +fsdbfile+wave5.fsdb -cm_dir ./mem_cov6 +ntb_random_seed=1767073523 +UVM_TESTNAME=router_error_wr_test +UVM_VERBOSITY = UVM_LOW			
	urg -dir mem_cov6.vdb -format both -report urgReport6

clean_VCS:
	rm -rf simv* csrc* *.tmp *.vpd *.vdb *.key *.log *hdrs.h urgReport* *.fsdb novas* verdi*
	clear

view_wave1_VCS: 
	verdi -ssf wave.fsdb
        
view_wave2_VCS: 
	verdi -ssf wave1.fsdb

view_wave3_VCS: 
	verdi -ssf wave2.fsdb

view_wave4_VCS: 
	verdi -ssf wave3.fsdb
  
view_wave5_VCS: 
	verdi -ssf wave4.fsdb
  
view_wave6_VCS: 
	verdi -ssf wave5.fsdb 

report_VCS:
	urg -dir mem_cov1.vdb mem_cov2.vdb mem_cov3.vdb mem_cov4.vdb mem_cov5.vdb mem_cov6.vdb -dbname merged_dir/merged_test -format both -report urgReport

regress_VCS: clean_VCS sv_cmp_VCS run_test_VCS run_test1_VCS run_test2_VCS run_test3_VCS run_test4_VCS run_test5_VCS report_VCS

cov_VCS:
	verdi -cov -covdir merged_dir.vdb  

# ----------------------------- END of Definitions for Synopsys's VCS Specific Targets -------------------------------#
