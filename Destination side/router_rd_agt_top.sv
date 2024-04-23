class router_rd_agt_top extends uvm_env;
	`uvm_component_utils(router_rd_agt_top);

	router_env_config m_cfg;
	router_rd_agent rd_agt[];

extern function new(string name="router_rd_agt_top",uvm_component parent);
extern function void build_phase(uvm_phase phase);

endclass

function router_rd_agt_top::new(string name="router_rd_agt_top",uvm_component parent);
	super.new(name,parent);
endfunction 

function void router_rd_agt_top::build_phase(uvm_phase phase);
	super.build_phase(phase);
	if(!uvm_config_db #(router_env_config)::get(this,"","router_env_config",m_cfg))
		`uvm_fatal("rd_agent_top","can't get data")

	rd_agt = new[m_cfg.no_of_dest];	
	foreach(rd_agt[i]) 
		begin
			rd_agt[i]=router_rd_agent::type_id::create($sformatf("rd_agt[%0d]",i),this);
			uvm_config_db#(router_rd_agent_config)::set(this,$sformatf("rd_agt[%0d]*",i),"router_rd_agent_config",m_cfg.r_rd_cfg[i]);
		end
	
endfunction
