class router_wr_monitor extends uvm_monitor;

	`uvm_component_utils(router_wr_monitor)
	virtual router_if.WR_MON_MP vif;
	router_wr_agent_config w_cfg;
	uvm_analysis_port #(write_xtn) monitor_port;
	write_xtn xtn;

	extern function new(string name="router_wr_monitor",uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern function void connect_phase(uvm_phase phase);
	extern task run_phase(uvm_phase phase);
	extern task collect_data;

endclass

function router_wr_monitor::new(string name="router_wr_monitor",uvm_component parent);
	
	super.new(name,parent);
	monitor_port=new("monitor_port",this);

endfunction

function void router_wr_monitor::build_phase(uvm_phase phase);
	
	if(!uvm_config_db #(router_wr_agent_config)::get(this,"","router_wr_agent_config",w_cfg))
		`uvm_fatal("MON","cannot get config data");
	super.build_phase(phase);

endfunction

function void router_wr_monitor::connect_phase(uvm_phase phase);
	
	super.connect_phase(phase);
	vif=w_cfg.vif;

endfunction

task router_wr_monitor::run_phase(uvm_phase phase);
	super.run_phase(phase);
	
	forever
		collect_data();
	
endtask

task router_wr_monitor::collect_data;

	xtn=write_xtn::type_id::create("xtn");
	@(vif.WR_MON_CB);
	while(vif.WR_MON_CB.pkt_valid!==1)
	@(vif.WR_MON_CB);
	while(vif.WR_MON_CB.busy===1)
	@(vif.WR_MON_CB);

	xtn.header=vif.WR_MON_CB.data_in;
	xtn.payload_data=new[xtn.header[7:2]];
	@(vif.WR_MON_CB);

	//foreach(xtn.payload_data[i])
	foreach(xtn.payload_data[i])
		begin
			while(vif.WR_MON_CB.busy===1)
			@(vif.WR_MON_CB);	
					
			xtn.payload_data[i]=vif.WR_MON_CB.data_in;
			@(vif.WR_MON_CB);
		end

	while(vif.WR_MON_CB.busy===1)
	@(vif.WR_MON_CB);
	
	xtn.parity=vif.WR_MON_CB.data_in;
	repeat(2) @(vif.WR_MON_CB);
	xtn.error = vif.WR_MON_CB.error;
	`uvm_info("ROUTER_WR_MONITOR",$sformatf("printing from monitor \n %s", xtn.sprint()),UVM_LOW)

	monitor_port.write(xtn);

endtask
	

