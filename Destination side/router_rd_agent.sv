class router_rd_agent extends uvm_agent;
`uvm_component_utils(router_rd_agent);
router_rd_sequencer r_seqr;
router_rd_driver r_drv;
router_rd_monitor r_mon;
router_rd_agent_config rd_cfg;

extern function new(string name="router_rd_agent",uvm_component parent);
extern function void build_phase(uvm_phase phase);
extern function void connect_phase(uvm_phase phase);
endclass

function router_rd_agent::new(string name="router_rd_agent",uvm_component parent);
	super.new(name,parent);
endfunction

function void router_rd_agent::build_phase(uvm_phase phase);
	super.build_phase(phase);
	if(!uvm_config_db #(router_rd_agent_config)::get(this,"","router_rd_agent_config",rd_cfg))
		`uvm_fatal("rd_agent","cannot get config data");

	
	r_mon=router_rd_monitor::type_id::create("r_mon",this);
	if(rd_cfg.is_active==UVM_ACTIVE)
		begin
			r_drv=router_rd_driver::type_id::create("r_drv",this);
			r_seqr=router_rd_sequencer::type_id::create("r_seqr",this);
		end
		
endfunction

function void router_rd_agent::connect_phase(uvm_phase phase);

	super.connect_phase(phase);
	if(rd_cfg.is_active==UVM_ACTIVE)
		begin
			r_drv.seq_item_port.connect(r_seqr.seq_item_export);
		end
endfunction
