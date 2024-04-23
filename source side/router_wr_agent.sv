    
class router_wr_agent extends uvm_agent;

	`uvm_component_utils(router_wr_agent);
	router_wr_sequencer w_seqr;
	router_wr_driver w_dr;
	router_wr_monitor w_mon;
	router_wr_agent_config w_cfg;

	extern function new(string name="router_wr_agent",uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern function void connect_phase(uvm_phase phase);

endclass

function router_wr_agent::new(string name="router_wr_agent",uvm_component parent);
	super.new(name,parent);
endfunction

function void router_wr_agent::build_phase(uvm_phase phase);
	super.build_phase(phase);
	if(!uvm_config_db #(router_wr_agent_config)::get(this,"","router_wr_agent_config",w_cfg))
		`uvm_fatal("W_AGENT","cannot get config data");

	w_mon=router_wr_monitor::type_id::create("W_MON",this);
	if(w_cfg.is_active==UVM_ACTIVE)
		begin
		w_seqr=router_wr_sequencer::type_id::create("W_SEQR",this);
		w_dr=router_wr_driver::type_id::create("W_DR",this);
		end
endfunction

function void router_wr_agent::connect_phase(uvm_phase phase);

	super.connect_phase(phase);
	if(w_cfg.is_active==UVM_ACTIVE)
		w_dr.seq_item_port.connect(w_seqr.seq_item_export);
endfunction