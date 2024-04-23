class read_xtn extends uvm_sequence_item;
`uvm_object_utils(read_xtn);
bit [7:0] header;
bit [7:0] payload_data[];
bit [7:0] parity;
rand bit [5:0] cycles;
bit error;
extern function new(string name = "read_xtn");
extern function void do_print(uvm_printer printer);
endclass

function read_xtn::new(string name = "read_xtn");
super.new(name);
endfunction

function void read_xtn::do_print(uvm_printer printer);
super.do_print(printer);
printer.print_field( "Header",this.header,8,UVM_DEC);
foreach(payload_data[i]) 
begin
printer.print_field( $sformatf("Payload_data[%0d]",i),this.payload_data[i],8,UVM_DEC);
end
printer.print_field( "Parity",this.parity,8,UVM_DEC);
printer.print_field("Cycles",this.cycles,6,UVM_DEC);
printer.print_field("Error",this.error,1,UVM_DEC);
endfunction:do_print

