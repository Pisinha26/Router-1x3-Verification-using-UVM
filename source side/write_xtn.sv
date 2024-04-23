class write_xtn extends uvm_sequence_item;
`uvm_object_utils(write_xtn)

rand bit [7:0] header;
rand bit [7:0] payload_data[];
bit [7:0] parity;
bit error;

constraint valid_size {header[1:0]!=3;}
constraint valid_size2 {payload_data.size()!=0;}
constraint  valid_size3 {payload_data.size() == header[7:2];}

extern function new(string name = "write_xtn");
//extern function void parity_cal();
extern function void post_randomize();
extern function void do_print(uvm_printer printer);
endclass

function write_xtn::new(string name ="write_xtn");
super.new(name);
endfunction

function void write_xtn::post_randomize();
parity =  header;
foreach(payload_data[i])
begin
parity = parity ^ payload_data[i];
end
endfunction

function void write_xtn::do_print(uvm_printer printer);
super.do_print(printer);
printer.print_field( "Header",this.header,8,UVM_DEC);
foreach(payload_data[i]) 
begin
printer.print_field( $sformatf("Payload_data[%0d]",i),this.payload_data[i],8,UVM_DEC);
end
printer.print_field( "Parity",this.parity,8,UVM_DEC);
printer.print_field("Error",this.error,1,UVM_DEC);
endfunction:do_print


class write_xtn1 extends write_xtn;
`uvm_object_utils(write_xtn1)
extern function new(string name = "write_xtn1");
extern function void post_randomize();
endclass
function write_xtn1::new(string name = "write_xtn1");
super.new(name);
endfunction
function void write_xtn1::post_randomize();
parity = $urandom_range(0,300);
endfunction


