class router_rd_monitor extends uvm_monitor;
`uvm_component_utils(router_rd_monitor);

router_rd_agent_config rd_cfg;
virtual router_if.RD_MON_MP vif;
uvm_analysis_port #(read_xtn) monitor_port;
read_xtn xtn;

extern function new(string name="router_rd_monitor",uvm_component parent);
extern function void build_phase(uvm_phase phase);
extern function void connect_phase(uvm_phase phase);
extern task run_phase(uvm_phase phase);
extern task collect_data();
endclass

function router_rd_monitor::new(string name="router_rd_monitor",uvm_component parent);
	super.new(name,parent);
	monitor_port = new("monitor_port",this);
endfunction

function void router_rd_monitor::build_phase(uvm_phase phase);
	super.build_phase(phase);
	if(!uvm_config_db #(router_rd_agent_config)::get(this,"","router_rd_agent_config",rd_cfg))
		`uvm_fatal("rd_mon","can't get data");
	
endfunction

function void router_rd_monitor::connect_phase(uvm_phase phase);
	super.connect_phase(phase);
	vif=rd_cfg.vif;
endfunction

task router_rd_monitor::run_phase(uvm_phase phase);
	
	forever
		collect_data();	
		

endtask


task router_rd_monitor::collect_data();


	xtn = read_xtn::type_id::create("xtn");
	@(vif.RD_MON_CB);
	while(vif.RD_MON_CB.read_enb!==1)
	@(vif.RD_MON_CB);
	@(vif.RD_MON_CB);
	xtn.header = vif.RD_MON_CB.data_out;

	xtn.payload_data = new[xtn.header[7:2]];
	@(vif.RD_MON_CB);
	
	foreach(xtn.payload_data[i])
		begin
			//while(!vif.RD_MON_CB.read_enb)
			//@(vif.RD_MON_CB);	
			xtn.payload_data[i] = vif.RD_MON_CB.data_out;
			@(vif.RD_MON_CB);
		end
	xtn.parity = vif.RD_MON_CB.data_out;
	//`uvm_info("ROUTER_RD_MONITOR",$sformatf("printing from Monitor \n %s", xtn.sprint()),UVM_LOW)
	@(vif.RD_MON_CB);
	`uvm_info("ROUTER_RD_MONITOR",$sformatf("printing from Monitor \n %s", xtn.sprint()),UVM_LOW)
	xtn.error = vif.RD_MON_CB.error;

	monitor_port.write(xtn);
endtask



				


