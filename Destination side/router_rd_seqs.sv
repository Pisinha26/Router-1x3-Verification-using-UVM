class router_rd_seq  extends uvm_sequence #(read_xtn);
	`uvm_object_utils(router_rd_seq);

	extern function new(string name="router_rd_seq");
endclass

function router_rd_seq::new(string name="router_rd_seq");
	super.new(name);
endfunction


class router_rd_seq_c1  extends uvm_sequence #(read_xtn);
	`uvm_object_utils(router_rd_seq_c1);

	extern function new(string name="router_rd_seq_c1");
	extern task body;
endclass

function router_rd_seq_c1::new(string name="router_rd_seq_c1");
	super.new(name);
endfunction


task router_rd_seq_c1::body;
	req=read_xtn::type_id::create("req");
	start_item(req);
	//assert(req.randomize() with {cycles inside {[1:28]};});
	assert(req.randomize with {cycles == 31;});
	//assert(req.randomize with {cycles inside {[1:29]};});
	`uvm_info("ROUTER_RD_SEQUENCE",$sformatf("printing from sequence \n %s", req.sprint()),UVM_HIGH)
	finish_item(req);
endtask


class router_rd_seq_c2  extends uvm_sequence #(read_xtn);
	`uvm_object_utils(router_rd_seq_c2);

	extern function new(string name="router_rd_seq_c2");
	extern task body;
endclass

function router_rd_seq_c2::new(string name="router_rd_seq_c2");
	super.new(name);
endfunction


task router_rd_seq_c2::body;
	req=read_xtn::type_id::create("req");
	start_item(req);
	assert(req.randomize with {cycles inside {[1:29]};});
	finish_item(req);
endtask


