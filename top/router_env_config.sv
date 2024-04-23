class router_env_config extends uvm_object;
`uvm_object_utils(router_env_config);

int no_of_score = 3;
int no_of_dest = 3;
bit has_scoreboard = 1;
bit has_wagent = 1;
bit has_ragent = 1;
bit has_virtual_sequencer = 1;

router_wr_agent_config r_wr_cfg;
router_rd_agent_config r_rd_cfg[];

extern function new(string name="router_env_config");
endclass

function router_env_config::new(string name="router_env_config");
		super.new(name);
endfunction

