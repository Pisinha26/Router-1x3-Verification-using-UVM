class router_wr_driver extends uvm_driver#(write_xtn);

	`uvm_component_utils(router_wr_driver)


	virtual router_if.WR_DRV_MP vif;
	router_wr_agent_config r_cfg;
	

	extern function new(string name = "router_wr_driver",uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern function void connect_phase(uvm_phase phase);
	extern task run_phase(uvm_phase phase);
	extern task send_to_dut(write_xtn xtn);
	//extern function report_phase(uvm_phase phase);

endclass




	function router_wr_driver::new(string name = "router_wr_driver",uvm_component parent);
		super.new(name,parent);
	endfunction



	function void router_wr_driver::build_phase(uvm_phase phase);
		super.build_phase(phase);
		if(!uvm_config_db#(router_wr_agent_config)::get(this,"","router_wr_agent_config",r_cfg))
			`uvm_fatal("DRIVER","get is getting failed")
	endfunction


	function void router_wr_driver::connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		vif = r_cfg.vif;
	endfunction


	task router_wr_driver::run_phase(uvm_phase phase);

		@(vif.WR_DRV_CB);
		vif.WR_DRV_CB.resetn<=1'b0;
		@(vif.WR_DRV_CB);
		vif.WR_DRV_CB.resetn<=1'b1;
	
		forever	
			begin
				seq_item_port.get_next_item(req);
				send_to_dut(req);
				seq_item_port.item_done();
			end
	endtask	
	

		
	task router_wr_driver::send_to_dut(write_xtn xtn);

		`uvm_info("ROUTER_WR_DRIVER",$sformatf("printing from driver \n %s", xtn.sprint()),UVM_LOW)
		
	    
		
		@(vif.WR_DRV_CB);
		while(vif.WR_DRV_CB.busy===1) 
		@(vif.WR_DRV_CB);

		vif.WR_DRV_CB.pkt_valid<=1'b1;
		vif.WR_DRV_CB.data_in <= xtn.header;
		@(vif.WR_DRV_CB);

		foreach(xtn.payload_data[i])
			begin
				while(vif.WR_DRV_CB.busy===1)
				@(vif.WR_DRV_CB);
		
				vif.WR_DRV_CB.data_in <= xtn.payload_data[i];
				@(vif.WR_DRV_CB);
			end		
		while(vif.WR_DRV_CB.busy===1)
		@(vif.WR_DRV_CB);
 
		vif.WR_DRV_CB.pkt_valid<=1'b0;
		vif.WR_DRV_CB.data_in<=xtn.parity;

		repeat(2)
		@(vif.WR_DRV_CB);

		xtn.error = vif.WR_DRV_CB.error;
		@(vif.WR_DRV_CB);
		
	endtask
			








