
module Router_top;


	import router_test_pkg::*;
	import uvm_pkg::*;


	
	bit clock;
		always 
			#10 clock = !clock;

	// interface instantiation
	router_if in0(clock);
	router_if in1(clock);
	router_if in2(clock);
	router_if in3(clock);
	
	//Duv instantiation
	/*router_top DUV (.clk(clock),.resetn(in0.resetn),.pkt_valid(in0.pkt_valid),.read_enb_0(in1.read_enb),.read_enb_1(in2.read_enb),.read_enb_2(in3.read_enb),.data_in(in0.data_in),.busy(in0.busy),.error(in0.error),.vld_out_0(in1.valid_out),.vld_out_1(in2.valid_out),.vld_out_2(in3.valid_out),.data_out_0(in1.data_out),.data_out_1(in2.data_out),.data_out_2(in3.data_out));	
*/
router_top duv(			.clk(clock),
                                .resetn(in0.resetn),
                                .pkt_vld(in0.pkt_valid),
                                .data_in(in0.data_in),
                                .error(in0.error),
                                .busy(in0.busy),

                                .read_enb_0(in1.read_enb),
                                .vld_out_0(in1.valid_out),
                                .data_out_0(in1.data_out),

                                .read_enb_1(in2.read_enb),
                                .vld_out_1(in2.valid_out),
                                .data_out_1(in2.data_out),

                                .read_enb_2(in3.read_enb),
                                .vld_out_2(in3.valid_out),
                                .data_out_2(in3.data_out));



//config db
initial begin
			`ifdef VCS
         		$fsdbDumpvars(0,Router_top);
        		`endif
	uvm_config_db#(virtual router_if)::set(null,"*","vif_0",in0);
 	uvm_config_db#(virtual router_if)::set(null,"*","vif_1",in1);
 	uvm_config_db#(virtual router_if)::set(null,"*","vif_2",in2);
 	uvm_config_db#(virtual router_if)::set(null,"*","vif_3",in3);	
	run_test();
	end
endmodule

