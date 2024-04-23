class router_tb extends uvm_env;
		
	//factory registration
	`uvm_component_utils(router_tb)


		router_rd_agt_top r_ragt_top;
        router_wr_agt_top r_wagt_top;
        router_virtual_sequencer r_v_sequencer;
	
	router_scoreboard router_sb;
	router_env_config r_cfg;



	extern function new(string name="router_tb",uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern function void connect_phase(uvm_phase phase);

endclass



	function router_tb::new(string name = "router_tb",uvm_component parent);
		super.new(name,parent);
	endfunction

	function void router_tb::build_phase(uvm_phase phase);
		super.build_phase(phase);
		
			
		if(!uvm_config_db#(router_env_config)::get(this,"","router_env_config",r_cfg))
			`uvm_fatal("CONFIG","cannot get() r_cfg from uvm_config_db. Have you set() it?")

		if(r_cfg.has_wagent)
			begin	
				//uvm_config_db#(router_wr_agent_config)::set(this,"*","router_wr_agent_config",r_cfg.r_wr_cfg);
				r_wagt_top=router_wr_agt_top::type_id::create("r_wagt_top",this);

			end
		if(r_cfg.has_ragent)
			begin
				//for(int i=0;i<r_cfg.no_of_dest;i++) begin
				//	uvm_config_db#(router_rd_agent_config)::set(this,"*","router_rd_agent_config",r_cfg.r_rd_cfg[i]);
				//end
				r_ragt_top=router_rd_agt_top::type_id::create("r_ragt_top",this);

			end
		if(r_cfg.has_scoreboard)
			begin
			router_sb = router_scoreboard::type_id::create("router_sb",this);
			end


		if(r_cfg.has_virtual_sequencer)
			r_v_sequencer = router_virtual_sequencer::type_id::create("r_v_sequencer",this);
			
	endfunction

	function void router_tb::connect_phase(uvm_phase phase);
		super.connect_phase(phase);
			if(r_cfg.has_virtual_sequencer)
				begin
					if(r_cfg.has_wagent)
						r_v_sequencer.wr_seqrh = r_wagt_top.w_ag.w_seqr;

					if(r_cfg.has_ragent)
						foreach(r_cfg.r_rd_cfg[i])
							r_v_sequencer.rd_seqrh[i] = r_ragt_top.rd_agt[i].r_seqr;
				end

			if(r_cfg.has_scoreboard)
				begin
						if(r_cfg.has_wagent)
							begin
								r_wagt_top.w_ag.w_mon.monitor_port.connect(router_sb.fifo_wh.analysis_export);
							end
						if(r_cfg.has_ragent)
							begin
								foreach(r_cfg.r_rd_cfg[i])
									begin
										r_ragt_top.rd_agt[i].r_mon.monitor_port.connect(router_sb.fifo_rh[i].analysis_export);
									end
							end
				end
	endfunction


