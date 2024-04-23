class router_scoreboard extends uvm_scoreboard;

	`uvm_component_utils(router_scoreboard);




	uvm_tlm_analysis_fifo#(write_xtn) fifo_wh;
	uvm_tlm_analysis_fifo#(read_xtn) fifo_rh[];

	write_xtn wr_data;
	write_xtn wr_cov_data;

	read_xtn rd_data;
	read_xtn rd_cov_data;

	router_env_config m_cfg;
	int data_verified_count;

	covergroup cov1;
		option.per_instance=1;
		//option.at_least = 1;

		ADDRESS:coverpoint wr_cov_data.header[1:0] {bins low = {2'b00};
													bins mid = {2'b01};
													bins high = {2'b10};}

		PAYLOAD:coverpoint wr_cov_data.header[7:2] {bins small_packet = {[1:15]};
													bins medium_packet = {[16:40]};
													bins big_packet = {[41:63]};}
		
		CORRUPT:coverpoint wr_cov_data.error {bins corrupted_packet = {1};}

		ADDRESS_X_PAYLOAD:cross ADDRESS,PAYLOAD;
		ADDRESS_X_PAYLOAD_X_CORRUPT:cross ADDRESS,PAYLOAD,CORRUPT;
	endgroup

	covergroup cov2;
		option.per_instance=1;
		//option.atleast = 1;

		ADDRESS:coverpoint rd_cov_data.header[1:0] {bins low = {2'b00};
													bins mid = {2'b01};
													bins high = {2'b10};}

		PAYLOAD:coverpoint rd_cov_data.header[7:2] {bins small_packet = {[1:15]};
													bins medium_packet = {[16:40]};
													bins big_packet = {[41:63]};}
		
		ADDRESS_X_PAYLOAD:cross ADDRESS,PAYLOAD;

	endgroup


	extern function new(string name = "router_scoreboard",uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern task run_phase(uvm_phase phase);
	extern function void check_data(read_xtn rd);
	extern function void report_phase(uvm_phase phase);
	
endclass

	function router_scoreboard::new(string name="router_scoreboard",uvm_component parent);
		super.new(name,parent);
		cov1 = new();
		cov2 = new();
	endfunction


	function void router_scoreboard::build_phase(uvm_phase phase);
		super.build_phase(phase);
		if(!uvm_config_db#(router_env_config)::get(this,"","router_env_config",m_cfg))
			`uvm_fatal("SCOREBOARD","cannot get inside the build_phase of SB")

		wr_data = write_xtn::type_id::create("wr_data");
		rd_data = read_xtn::type_id::create("rd_data");
		fifo_wh = new("fifo_wh",this);
		fifo_rh = new[m_cfg.no_of_dest];
		foreach(fifo_rh[i])
			begin
				fifo_rh[i] = new($sformatf("fifo_rh[%0d]",i),this);
			end 

	endfunction

	task router_scoreboard::run_phase(uvm_phase phase);
		super.run_phase(phase);
		fork
			begin
				forever
					begin
						fifo_wh.get(wr_data);
						wr_data.print;
						`uvm_info("SB","Inside SB run_phase",UVM_LOW)
						wr_cov_data = wr_data;
						cov1.sample();

					end
			end
			begin
				forever
					begin
						fork:READ
							begin
								fifo_rh[0].get(rd_data);
								rd_data.print;
								`uvm_info("SB","Inside Sb run_phase(read[0])",UVM_LOW)
								check_data(rd_data);
								rd_cov_data = rd_data;
								cov2.sample();
							end
							begin
								fifo_rh[1].get(rd_data);
								rd_data.print;
								`uvm_info("SB","Inside Sb run_phase(read[1])",UVM_LOW)
								check_data(rd_data);
								rd_cov_data = rd_data;
								cov2.sample();
							end
							begin
								fifo_rh[2].get(rd_data);
								rd_data.print;
								`uvm_info("SB","Inside Sb run_phase(read[2])",UVM_LOW)
								check_data(rd_data);
								rd_cov_data = rd_data;
								cov2.sample();
							end
						join_any
						disable READ;
					end
			end
		join

	endtask

	function void router_scoreboard::check_data(read_xtn rd);

		if(wr_data.header == rd.header)
			`uvm_info("SB","HEADER MATCHED SUCCESSFULLY",UVM_LOW)
		else
			`uvm_info("SB","HEADER MISMATCHED",UVM_LOW)

		if(wr_data.payload_data == rd.payload_data)
			`uvm_info("SB","PAYLOAD MATCHED SUCCESSFULLY",UVM_LOW)
		else
			`uvm_info("SB","PAYLOAD MISMATCHED",UVM_LOW)

		if(wr_data.parity == rd.parity)
			`uvm_info("SB","parity MATCHED SUCCESSFULLY",UVM_LOW)
		else
			`uvm_info("SB","parity MISMATCHED",UVM_LOW)

		data_verified_count++;

	endfunction

	function void router_scoreboard::report_phase(uvm_phase phase);
		super.report_phase(phase);
		`uvm_info(get_type_name(),$sformatf("DATA VERIFIED COUNT IN SB: %0d",data_verified_count),UVM_LOW);
	endfunction
	
