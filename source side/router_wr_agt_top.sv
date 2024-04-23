class router_wr_agt_top extends uvm_env;
`uvm_component_utils(router_wr_agt_top);

router_env_config m_cfg;
router_wr_agent w_ag;

extern function new(string name="router_wr_agt_top",uvm_component parent);
extern function void build_phase(uvm_phase phase);
endclass

function router_wr_agt_top::new(string name="router_wr_agt_top",uvm_component parent);
	super.new(name,parent);
endfunction 

function void router_wr_agt_top::build_phase(uvm_phase phase);
	super.build_phase(phase);
	if(!uvm_config_db #(router_env_config)::get(this,"","router_env_config",m_cfg))
		`uvm_fatal("AGT_TOP","cannot get config data");

	w_ag=router_wr_agent::type_id::create("w_ag",this);
	uvm_config_db#(router_wr_agent_config)::set(this,"w_ag*","router_wr_agent_config",m_cfg.r_wr_cfg);

endfunction
