class router_vbase_seq extends uvm_sequence#(uvm_sequence_item);
		
	`uvm_object_utils(router_vbase_seq)

	router_env_config r_cfg;


	router_wr_sequencer wr_seqrh;
	router_rd_sequencer rd_seqrh[];
	router_virtual_sequencer v_seqrh;
		
	extern function new(string name = "router_vbase_seq");	
	extern task body();
endclass




	function router_vbase_seq::new(string name = "router_vbase_seq");
		super.new(name);
	endfunction


	task router_vbase_seq::body();
		if(!uvm_config_db#(router_env_config)::get(null,get_full_name(),"router_env_config",r_cfg))
			`uvm_fatal("Virtual_Sequence","Can't get inside the virtual sequence")

		rd_seqrh = new[r_cfg.no_of_dest];

		if(!$cast(v_seqrh,m_sequencer))
			begin
				`uvm_error("BODY","failed to handle assignment m_sequencer to v_seqrh")
			end
		wr_seqrh = v_seqrh.wr_seqrh;
		foreach(rd_seqrh[i])
			rd_seqrh[i] = v_seqrh.rd_seqrh[i];
	endtask

class router_small_virtual_seq extends router_vbase_seq;
	`uvm_object_utils(router_small_virtual_seq)

	bit[1:0] address;
	router_small_wr_xtn small_wseqh;
	router_rd_seq_c1 normal;
	
	extern function new(string name = "router_small_virtual_seq");
	extern task body();
endclass

function router_small_virtual_seq::new(string name = "router_small_virtual_seq");
	super.new(name);
endfunction


task router_small_virtual_seq::body();
	super.body();
	if(!uvm_config_db#(bit[1:0])::get(null,get_full_name(),"bit[1:0]",address))
		`uvm_fatal("router_small_virtual_seq","cannot get the address inside router_small_virtual_seq")
	
	if(r_cfg.has_wagent)
		begin
			small_wseqh = router_small_wr_xtn::type_id::create("small_wseqh");
		end
	
	if(r_cfg.has_ragent)
		begin
			normal = router_rd_seq_c1::type_id::create("normal");
		end
	fork	
		begin
			small_wseqh.start(wr_seqrh);
		end
		begin
			if(address==2'b00)
				normal.start(rd_seqrh[0]);
			if(address==2'b01)
				normal.start(rd_seqrh[1]);
			if(address==2'b10)
				normal.start(rd_seqrh[2]);
		end
	join

endtask


class router_medium_virtual_seq extends router_vbase_seq;
	`uvm_object_utils(router_medium_virtual_seq)

	bit[1:0] address;
	router_medium_wr_xtn medium_wseqh;
	router_rd_seq_c1 normal;
	
	extern function new(string name = "router_medium_virtual_seq");
	extern task body();
endclass

function router_medium_virtual_seq::new(string name = "router_medium_virtual_seq");
	super.new(name);
endfunction


task router_medium_virtual_seq::body();
	super.body();
	if(!uvm_config_db#(bit[1:0])::get(null,get_full_name(),"bit[1:0]",address))
		`uvm_fatal("router_medium_virtual_seq","cannot get the address inside router_small_virtual_seq")
	
	if(r_cfg.has_wagent)
		begin
			medium_wseqh = router_medium_wr_xtn::type_id::create("medium_wseqh");
		end
	
	if(r_cfg.has_ragent)
		begin
			normal = router_rd_seq_c1::type_id::create("normal");
		end
	fork	
		begin
			medium_wseqh.start(wr_seqrh);
		end
		begin
			if(address==2'b00)
				normal.start(rd_seqrh[0]);
			if(address==2'b01)
				normal.start(rd_seqrh[1]);
			if(address==2'b10)
				normal.start(rd_seqrh[2]);
		end
	join

endtask


class router_big_virtual_seq extends router_vbase_seq;
	`uvm_object_utils(router_big_virtual_seq)

	bit[1:0] address;
	router_big_wr_xtn big_wseqh;
	router_rd_seq_c1 normal;
	
	extern function new(string name = "router_big_virtual_seq");
	extern task body();
endclass

function router_big_virtual_seq::new(string name = "router_big_virtual_seq");
	super.new(name);
endfunction


task router_big_virtual_seq::body();
	super.body();
	if(!uvm_config_db#(bit[1:0])::get(null,get_full_name(),"bit[1:0]",address))
		`uvm_fatal("router_big_virtual_seq","cannot get the address inside router_small_virtual_seq")
	
	if(r_cfg.has_wagent)
		begin
			big_wseqh = router_big_wr_xtn::type_id::create("big_wseqh");
		end
	
	if(r_cfg.has_ragent)
		begin
			normal = router_rd_seq_c1::type_id::create("normal");
		end
	fork	
		begin
			big_wseqh.start(wr_seqrh);
		end
		begin
			if(address==2'b00)
				normal.start(rd_seqrh[0]);
			if(address==2'b01)
				normal.start(rd_seqrh[1]);
			if(address==2'b10)
				normal.start(rd_seqrh[2]);
		end
	join

endtask

	
	
class router_random_virtual_seq extends router_vbase_seq;
	`uvm_object_utils(router_random_virtual_seq)

	bit[1:0] address;
	router_random_wr_xtn random_wseqh;
	router_rd_seq_c1 normal;
	
	extern function new(string name = "router_random_virtual_seq");
	extern task body();
endclass

function router_random_virtual_seq::new(string name = "router_random_virtual_seq");
	super.new(name);
endfunction


task router_random_virtual_seq::body();
	super.body();
	if(!uvm_config_db#(bit[1:0])::get(null,get_full_name(),"bit[1:0]",address))
		`uvm_fatal("router_random_virtual_seq","cannot get the address inside router_small_virtual_seq")
	
	if(r_cfg.has_wagent)
		begin
			random_wseqh = router_random_wr_xtn::type_id::create("random_wseqh");
		end
	
	if(r_cfg.has_ragent)
		begin
			normal = router_rd_seq_c1::type_id::create("normal");
		end
	fork	
		begin
			random_wseqh.start(wr_seqrh);
		end
		begin
			if(address==2'b00)
				normal.start(rd_seqrh[0]);
			if(address==2'b01)
				normal.start(rd_seqrh[1]);
			if(address==2'b10)
				normal.start(rd_seqrh[2]);
		end
	join

endtask

class router_error_virtual_seq extends router_vbase_seq;
	`uvm_object_utils(router_error_virtual_seq)

	bit[1:0] address;
	router_error_wr_xtn error_wseqh;
	router_rd_seq_c1 normal;
	
	extern function new(string name = "router_error_virtual_seq");
	extern task body();
endclass

function router_error_virtual_seq::new(string name = "router_error_virtual_seq");
	super.new(name);
endfunction


task router_error_virtual_seq::body();
	super.body();
	if(!uvm_config_db#(bit[1:0])::get(null,get_full_name(),"bit[1:0]",address))
		`uvm_fatal("router_error_virtual_seq","cannot get the address inside router_small_virtual_seq")
	
	if(r_cfg.has_wagent)
		begin
			error_wseqh = router_error_wr_xtn::type_id::create("error_wseqh");
		end
	
	if(r_cfg.has_ragent)
		begin
			normal = router_rd_seq_c1::type_id::create("normal");
		end
	fork	
		begin
			error_wseqh.start(wr_seqrh);
		end
		begin
			if(address==2'b00)
				normal.start(rd_seqrh[0]);
			if(address==2'b01)
				normal.start(rd_seqrh[1]);
			if(address==2'b10)
				normal.start(rd_seqrh[2]);
		end
	join

endtask