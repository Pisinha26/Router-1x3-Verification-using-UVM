class router_base_test extends uvm_test;
	
	//factory registeration
	`uvm_component_utils(router_base_test);

	// handle for the env and env_config class
	router_tb router_envh;
    	router_env_config r_tb_cfg;


	router_wr_agent_config r_wr_cfg;
	router_rd_agent_config r_rd_cfg[];

	bit has_wagent=1;
	bit has_ragent=1;
	bit has_scoreboard=1;
	bit has_virtual_sequencer = 1;
	int no_of_dest = 3;
	int no_of_score = 1;	
	
	
	extern function new(string name="router_base_test",uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern function void config_router();
	extern function void connect_phase(uvm_phase phase);
	extern function void end_of_elaboration_phase(uvm_phase phase);
	extern task run_phase(uvm_phase phase);
endclass


	function router_base_test::new(string name = "router_base_test",uvm_component parent);
		super.new(name,parent);
	endfunction


	function void router_base_test::build_phase(uvm_phase phase);
		super.build_phase(phase);
		r_tb_cfg = router_env_config::type_id::create("r_tb_cfg");

		if(has_ragent)
			r_tb_cfg.r_rd_cfg=new[no_of_dest];
		config_router();

		uvm_config_db #(router_env_config)::set(this,"*","router_env_config",r_tb_cfg);
		router_envh = router_tb::type_id::create("router_envh",this);

	endfunction

	function void router_base_test::config_router();
//creating write & rd agent 
if(has_wagent)
	begin
			r_wr_cfg=router_wr_agent_config::type_id::create("r_wr_cfg");

			if(!uvm_config_db#(virtual router_if)::get(this,"","vif_0",r_wr_cfg.vif))
				`uvm_fatal("VIF CONFIG","cannot get()interface vif_0 from uvm_config_db. Have you set() it?")
			r_wr_cfg.is_active = UVM_ACTIVE;
			r_tb_cfg.r_wr_cfg = r_wr_cfg;
	end



 if(has_ragent)
          begin
          r_rd_cfg=new[no_of_dest];
          foreach(r_rd_cfg[i])
                 	begin
                    			r_rd_cfg[i]=router_rd_agent_config::type_id::create($sformatf("r_rd_cfg[%0d]",i));
 
					if(!uvm_config_db#(virtual router_if)::get(this,"",$sformatf("vif_%0d",i+1),r_rd_cfg[i].vif))
                        			`uvm_fatal("VIF CONFIG","cannot get()interface from uvm_config_db. Have you set() it?")
					r_rd_cfg[i].is_active = UVM_ACTIVE;
                    			r_tb_cfg.r_rd_cfg[i] = r_rd_cfg[i];
 			end
 

		r_tb_cfg.has_wagent = has_wagent;
		r_tb_cfg.has_ragent = has_ragent;
		r_tb_cfg.has_scoreboard = has_scoreboard;
		r_tb_cfg.has_virtual_sequencer = has_virtual_sequencer;
		r_tb_cfg.no_of_dest = no_of_dest;	
		r_tb_cfg.no_of_score = no_of_score;
		end
	endfunction


	function void router_base_test::connect_phase(uvm_phase phase);
		super.connect_phase(phase);
	endfunction

	function void router_base_test::end_of_elaboration_phase(uvm_phase phase);
		super.end_of_elaboration_phase(phase);
		uvm_top.print_topology();
	endfunction

	task router_base_test::run_phase(uvm_phase phase);
		super.run_phase(phase);
	endtask
	
	
class router_small_wr_test extends router_base_test;
	
	`uvm_component_utils(router_small_wr_test);
	router_small_virtual_seq test_small;
	bit[1:0] addr;	

	extern function new(string name = "router_small_wr_test",uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern task run_phase(uvm_phase phase);
endclass	

	function router_small_wr_test::new(string name = "router_small_wr_test",uvm_component parent);
		super.new(name,parent);
	endfunction

	function void router_small_wr_test::build_phase(uvm_phase phase);
		super.build_phase(phase);
	endfunction

	task router_small_wr_test::run_phase(uvm_phase phase);
		super.run_phase(phase);
		phase.raise_objection(this);
		
		repeat(1)
			begin
				addr = {$random}%3;
				uvm_config_db#(bit[1:0])::set(this,"*","bit[1:0]",addr);
				test_small = router_small_virtual_seq::type_id::create("test_small");
				test_small.start(router_envh.r_v_sequencer);
			end
		phase.drop_objection(this);
	endtask

class router_medium_wr_test extends router_base_test;
	
	`uvm_component_utils(router_medium_wr_test);
	router_medium_virtual_seq test_medium;
	bit[1:0] addr;	

	extern function new(string name = "router_medium_wr_test",uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern task run_phase(uvm_phase phase);
endclass	

	function router_medium_wr_test::new(string name = "router_medium_wr_test",uvm_component parent);
		super.new(name,parent);
	endfunction

	function void router_medium_wr_test::build_phase(uvm_phase phase);
		super.build_phase(phase);
	endfunction

	task router_medium_wr_test::run_phase(uvm_phase phase);
		super.run_phase(phase);
		phase.raise_objection(this);
		
		repeat(5)
			begin
				addr = {$random}%3;
				uvm_config_db#(bit[1:0])::set(this,"*","bit[1:0]",addr);
				test_medium = router_medium_virtual_seq::type_id::create("test_small");
				test_medium.start(router_envh.r_v_sequencer);
			end
		phase.drop_objection(this);
	endtask

class router_big_wr_test extends router_base_test;
	
	`uvm_component_utils(router_big_wr_test);
	router_big_virtual_seq test_big;
	bit[1:0] addr;	

	extern function new(string name = "router_big_wr_test",uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern task run_phase(uvm_phase phase);
endclass	

	function router_big_wr_test::new(string name = "router_big_wr_test",uvm_component parent);
		super.new(name,parent);
	endfunction

	function void router_big_wr_test::build_phase(uvm_phase phase);
		super.build_phase(phase);
	endfunction

	task router_big_wr_test::run_phase(uvm_phase phase);
		super.run_phase(phase);
		phase.raise_objection(this);
		
		repeat(5)
			begin
				addr = {$random}%3;
				uvm_config_db#(bit[1:0])::set(this,"*","bit[1:0]",addr);
				test_big = router_big_virtual_seq::type_id::create("test_big");
				test_big.start(router_envh.r_v_sequencer);
			end
		phase.drop_objection(this);
	endtask


class router_random_wr_test extends router_base_test;
	
	`uvm_component_utils(router_random_wr_test);
	router_random_virtual_seq test_random;
	bit[1:0] addr;	

	extern function new(string name = "router_random_wr_test",uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern task run_phase(uvm_phase phase);
endclass	

	function router_random_wr_test::new(string name = "router_random_wr_test",uvm_component parent);
		super.new(name,parent);
	endfunction

	function void router_random_wr_test::build_phase(uvm_phase phase);
		super.build_phase(phase);
	endfunction

	task router_random_wr_test::run_phase(uvm_phase phase);
		super.run_phase(phase);
		phase.raise_objection(this);
		
		repeat(5)
			begin
				addr = {$random}%3;
				uvm_config_db#(bit[1:0])::set(this,"*","bit[1:0]",addr);
				test_random = router_random_virtual_seq::type_id::create("test_random");
				test_random.start(router_envh.r_v_sequencer);
			end
		phase.drop_objection(this);
	endtask

class router_error_wr_test extends router_base_test;
	
	`uvm_component_utils(router_error_wr_test);
	router_error_virtual_seq test_error;
	bit[1:0] addr;	

	extern function new(string name = "router_error_wr_test",uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern task run_phase(uvm_phase phase);
endclass	

	function router_error_wr_test::new(string name = "router_error_wr_test",uvm_component parent);
		super.new(name,parent);
	endfunction

	function void router_error_wr_test::build_phase(uvm_phase phase);
		super.build_phase(phase);
	endfunction

	task router_error_wr_test::run_phase(uvm_phase phase);
		super.run_phase(phase);
		phase.raise_objection(this);
		
		repeat(1)
			begin
				addr = {$random}%3;
				uvm_config_db#(bit[1:0])::set(this,"*","bit[1:0]",addr);
				test_error = router_error_virtual_seq::type_id::create("test_error");
				test_error.start(router_envh.r_v_sequencer);
			end
		phase.drop_objection(this);
	endtask
	



