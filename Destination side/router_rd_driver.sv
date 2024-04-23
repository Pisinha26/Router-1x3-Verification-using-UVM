class router_rd_driver extends uvm_driver #(read_xtn);
`uvm_component_utils(router_rd_driver);

router_rd_agent_config rd_cfg;
virtual router_if.RD_DRV_MP vif;

extern function new(string name="router_rd_driver",uvm_component parent);
extern function void build_phase(uvm_phase phase);
extern function void connect_phase(uvm_phase phase);
extern task run_phase(uvm_phase phase);
extern task send_to_dut (read_xtn xtn);
endclass

function router_rd_driver::new(string name="router_rd_driver",uvm_component parent);
	super.new(name,parent);
endfunction

function void router_rd_driver::build_phase(uvm_phase phase);
	super.build_phase(phase);
	if(!uvm_config_db #(router_rd_agent_config)::get(this,"","router_rd_agent_config",rd_cfg))
		`uvm_fatal("rd_drv","can't get data");

endfunction

function void router_rd_driver::connect_phase(uvm_phase phase);
	super.connect_phase(phase);
	vif=rd_cfg.vif;
endfunction

task router_rd_driver::run_phase(uvm_phase phase);
	forever
		begin
			seq_item_port.get_next_item(req);
			send_to_dut(req);
			seq_item_port.item_done();
		end
endtask

task router_rd_driver::send_to_dut(read_xtn xtn);
	
	`uvm_info("ROUTER_RD_DRIVER",$sformatf("printing from driver \n %s", xtn.sprint()),UVM_LOW)
	@(vif.RD_DRV_CB);
	while(vif.RD_DRV_CB.valid_out!==1)
	@(vif.RD_DRV_CB);
	repeat(xtn.cycles)
			@(vif.RD_DRV_CB);
	
	vif.RD_DRV_CB.read_enb <= 1'b1;

	while(vif.RD_DRV_CB.valid_out===1)
	@(vif.RD_DRV_CB);
	vif.RD_DRV_CB.read_enb <= 1'b0;
	@(vif.RD_DRV_CB);

endtask
