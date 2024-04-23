class router_wbase_seq extends uvm_sequence#(write_xtn);
	
	`uvm_object_utils(router_wbase_seq)

	extern function new(string name = "router_wbase_seq");
        
endclass

	function router_wbase_seq::new(string name = "router_wbase_seq");
		super.new(name);
	endfunction
        
 // 1st TESTCASE SMALL PACKET SIZE      
class router_small_wr_xtn extends router_wbase_seq;

	`uvm_object_utils(router_small_wr_xtn)
        bit[1:0] address;	
	
	extern function new(string name = "router_small_wr_xtn");
	extern task body();

endclass

	function router_small_wr_xtn::new(string name = "router_small_wr_xtn");
		super.new(name);
	endfunction

	task router_small_wr_xtn::body();
                if(!uvm_config_db#(bit[1:0])::get(null,get_full_name(),"bit[1:0]",address))
                     `uvm_fatal("router_small_wr_xtn","cannot get the router_env_config")

				req = write_xtn::type_id::create("req");
				start_item(req);
				assert(req.randomize() with {header[7:2] inside {[1:15]} && header[1:0] == address;});
                                `uvm_info("ROUTER_WR_SEQUENCE",$sformatf("printing from sequence \n %s", req.sprint()),UVM_HIGH)
				finish_item(req);
	endtask


//2nd TESTCASE MEDIUM PACKET
class router_medium_wr_xtn extends router_wbase_seq;

	`uvm_object_utils(router_medium_wr_xtn)
        bit[1:0] address;	
	
	extern function new(string name = "router_medium_wr_xtn");
	extern task body();

endclass

	function router_medium_wr_xtn::new(string name = "router_medium_wr_xtn");
		super.new(name);
	endfunction

	task router_medium_wr_xtn::body();
                if(!uvm_config_db#(bit[1:0])::get(null,get_full_name(),"bit[1:0]",address))
                     `uvm_fatal("router_medium_wr_xtn","cannot get the router_env_config")

				req = write_xtn::type_id::create("req");
				start_item(req);
				assert(req.randomize() with {header[7:2] inside {[16:40]} && header[1:0] == address;});
                                `uvm_info("ROUTER_WR_SEQUENCE",$sformatf("printing from sequence \n %s", req.sprint()),UVM_HIGH)
				finish_item(req);
	endtask

//3rd TESTCASE big
class router_big_wr_xtn extends router_wbase_seq;

	`uvm_object_utils(router_big_wr_xtn)
        bit[1:0] address;	
	
	extern function new(string name = "router_big_wr_xtn");
	extern task body();

endclass

	function router_big_wr_xtn::new(string name = "router_big_wr_xtn");
		super.new(name);
	endfunction

	task router_big_wr_xtn::body();
                if(!uvm_config_db#(bit[1:0])::get(null,get_full_name(),"bit[1:0]",address))
                     `uvm_fatal("router_big_wr_xtn","cannot get the router_env_config")

				req = write_xtn::type_id::create("req");
				start_item(req);
				assert(req.randomize() with {header[7:2] inside {[41:63]} && header[1:0] == address;});
                                `uvm_info("ROUTER_WR_SEQUENCE",$sformatf("printing from sequence \n %s", req.sprint()),UVM_HIGH)
				finish_item(req);
	endtask

//4th TESTCASE RANDOM
class router_random_wr_xtn extends router_wbase_seq;

	`uvm_object_utils(router_random_wr_xtn)
        bit[1:0] address;	
	
	extern function new(string name = "router_random_wr_xtn");
	extern task body();

endclass

	function router_random_wr_xtn::new(string name = "router_random_wr_xtn");
		super.new(name);
	endfunction

	task router_random_wr_xtn::body();
                if(!uvm_config_db#(bit[1:0])::get(null,get_full_name(),"bit[1:0]",address))
                     `uvm_fatal("router_random_wr_xtn","cannot get the router_env_config")

				req = write_xtn::type_id::create("req");
				start_item(req);
				assert(req.randomize() with {header[1:0] == address;});
                                `uvm_info("ROUTER_WR_SEQUENCE",$sformatf("printing from sequence \n %s", req.sprint()),UVM_HIGH)
				finish_item(req);
	endtask

//5th TESTCASE ERROR
class router_error_wr_xtn extends uvm_sequence#(write_xtn1);
        `uvm_object_utils(router_error_wr_xtn)

        bit[1:0] address;

        extern function new(string name = "router_error_wr_xtn");
        extern task body();
endclass

        function router_error_wr_xtn::new(string name = "router_error_wr_xtn");
                super.new(name);
        endfunction


        task router_error_wr_xtn::body();
                if(!uvm_config_db#(bit[1:0])::get(null,get_full_name(),"bit[1:0]",address))
                     `uvm_fatal("router_error_wr_xtn","cannot get the router_env_config")

		req = write_xtn1::type_id::create("req");
		start_item(req);
		assert(req.randomize() with {header[1:0] == address;});
                `uvm_info("ROUTER_WR_SEQUENCE",$sformatf("printing from sequence \n %s", req.sprint()),UVM_HIGH)
		finish_item(req);
        endtask
                        
