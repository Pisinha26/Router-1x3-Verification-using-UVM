interface router_if(input clock);
	
	// Router Signal
	logic resetn;
	logic read_enb;
	logic [7:0] data_in;
	logic pkt_valid;
	logic error;
	logic busy;
	logic valid_out;
	logic [7:0] data_out;
	
//Clocking Block For Write Driver
clocking WR_DRV_CB @(posedge clock);
default input #1 output #1;
output resetn;
output data_in;
output pkt_valid;
input busy;
input error;
endclocking

//Clocking Block For Write Monitor
clocking WR_MON_CB @(posedge clock);
default input #1 output #1;
input resetn;
input data_in;
input pkt_valid;
input busy;
input error;
endclocking

//Clocking Block For Read Driver
clocking RD_DRV_CB @(posedge clock);
default input #1 output #1;
output read_enb;
input valid_out;
endclocking

//Clocking BLock For Read Monitor
clocking RD_MON_CB @(posedge clock);
default input #1 output #1;
input data_out;
input read_enb;
input error;
endclocking

//Modport for write driver 
modport WR_DRV_MP(clocking WR_DRV_CB, input clock);
	
//Modport for write monitor
modport WR_MON_MP(clocking WR_MON_CB, input clock);
	
//Modport for read driver
modport RD_DRV_MP(clocking RD_DRV_CB, input clock);

//Modport for read monitor
modport RD_MON_MP(clocking RD_MON_CB, input clock);

endinterface
	
