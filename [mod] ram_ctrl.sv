module ram_ctrl #(parameter p_mem_size = 8)
	(input logic clk,			
	 input logic en,						// work permission
	 input logic we,						// write permission
	 input logic re,						// read permission
	 input logic [1:0] op_code,				// operation code
	 input logic rstN, 						//memory reset
	 input logic [p_mem_size-1:0] addr,				//address
	 input logic [31:0] data_in,					//input data 

	 output logic [31:0] data_out,				// output data
	 output reg [3:0] op_sign				// operation indication
	 );		
	 
logic [31:0] read_mem [p_mem_size-1:0];	 	//readable array
logic [31:0] mem [p_mem_size-1:0];			//array
int i = 0;							//counter
int res_op_sign;
 
//writing to the beginning of the array
function automatic void write_begin 
	(ref logic [31:0] mem[p_mem_size-1:0],
	input logic [31:0] addr,
	input logic [31:0] data_in,	
	ref reg [3:0] op_sign);
	
	addr = 0;
	mem [addr] = data_in;
	op_sign = 1;
	
	$display("\n\tAn entry of data = %b was made to the beginning of the array", data_in);
	
 endfunction
 
//writing to the middle of the array 
function automatic void write_middle
	(ref logic [31:0] mem[p_mem_size-1:0],
	input logic [31:0] addr,
	input logic [31:0] data_in,	
	ref reg [3:0] op_sign);
	
	addr = p_mem_size/2;
	mem [addr] = data_in;
	op_sign = 2;
 
	$display("\n\tAn entry of data = %b was made to the middle of the array", data_in);

 endfunction
 
 //writing to the end of the array
 function automatic void write_end
	(ref logic [31:0] mem[p_mem_size-1:0],
	input logic [31:0] addr,
	input logic [31:0] data_in,	
	ref reg [3:0] op_sign);
	
	addr = p_mem_size-1;
	mem [addr] = data_in;
	op_sign = 3;
 
	$display("\n\tAn entry of data = %b was made to the end of the array", data_in);
 

	
 endfunction

//writing to the entire array
function automatic void write_all
	(ref logic [31:0] mem[p_mem_size-1:0],
	input logic [31:0] data_in,	
	ref reg [3:0] op_sign);
	
	int j;
	
	for (j = 0; j < p_mem_size; j=j+1) mem[j] = data_in;
	op_sign = 4;
	
	$display("\n\tAn entry was made to the whole array");
	

	
endfunction

//reading from the beginning of the array
function automatic void read_begin
	(ref logic [31:0] mem[p_mem_size-1:0],
	input logic [31:0] addr,
	output logic [31:0] data_out,	
	ref reg [3:0] op_sign);
	
	addr = 0;
	data_out = mem[addr];
	op_sign = 5;
	
	$display ("\n\tData = %b has been read from the beginning of the array", data_out);
	
endfunction

//reading from the middle of the array
function automatic void read_middle
	(ref logic [31:0] mem[p_mem_size-1:0],
	input logic [31:0] addr,
	output logic [31:0] data_out,	
	ref reg [3:0] op_sign);
	
	addr = p_mem_size/2;
	data_out = mem[addr];
	op_sign = 6;
	
	$display ("\n\tData = %b has been read from the middle of the array", data_out);
	
endfunction

//reading from the end of the array
function automatic void read_end
	(ref logic [31:0] mem[p_mem_size-1:0],
	input logic [31:0] addr,
	output logic [31:0] data_out,	
	ref reg [3:0] op_sign);
	
	addr = p_mem_size-1;
	data_out = mem[addr];
	op_sign = 7;
	
	$display ("\n\tData = %b has been read from the end of the array", data_out);
	

	
endfunction

//reading the entire array
function automatic void read_all
	(ref logic [31:0] mem[p_mem_size-1:0],
	ref logic [31:0]write_mem[p_mem_size-1:0],		
	ref reg [3:0] op_sign);
	
	read_mem = mem;
	op_sign = 8;
	
	$display ("\n\tData has been read from the whole array");
	
	
endfunction

task id_of_luck;
	input reg [3:0] op_sign;
	case (op_sign)
		4'b0001: 
		begin
			$monitor ("\n\tWriting to the beginning of the array completed successfully!\n"); 
		end
		4'b0010: 
		begin
			$monitor ("\n\tWriting to the middle of the array completed successfully!\n"); 
		end
		4'b0011: 
		begin
			$monitor ("\n\tWriting to the end of the array completed successfully!\n"); 
		end
		4'b0100: 
		begin
			$monitor ("\n\tWriting to the whole array completed successfully!\n"); 
		end
		4'b0101: 
		begin
			$monitor ("\n\tReading from the beginning of the array completed successfully!\n"); 
		end
		4'b0110:
		begin
			$monitor ("\n\tReading from the middle of the array completed successfully!\n"); 
		end
		4'b0111:
		begin
			$monitor ("\n\tReading from the end of the array completed successfully!\n"); 
		end
		4'b1000:
		begin
			$monitor ("\n\tReading from the whole array completed successfully!\n"); 
		end
		default : 
		begin 
			$monitor ("\n\tOops... Something went wrong!\n"); 
		end
	endcase
endtask	
	
 always @(posedge clk, negedge rstN)
	begin
		if (~rstN)
		begin
			for (i = 0; i < p_mem_size; i++) mem[i] = 2'b00;
		end
		else if(en)
			begin
				case (op_code)
					0:
					begin					
if 		(we) 	write_begin(mem, addr, data_in, op_sign);
else if (re)	read_begin(mem, addr, data_out, op_sign);
						
					end
					1:
					begin					
if 		(we) 	write_middle(mem, addr, data_in, op_sign);
else if (re)	read_middle(mem, addr, data_out, op_sign);
						
					end
					2:
					begin
if 		(we) 	write_end(mem, addr, data_in, op_sign);
else if (re)	read_end(mem, addr, data_out, op_sign);
						
					end
					3:
					begin 
if 		(we) 	write_all(mem, data_in, op_sign);
else if (re)	read_all(mem, read_mem, op_sign);
						
					end
					default: $monitor ("\n\tWow, and how did you get into this case?!");
				endcase
				
				id_of_luck (op_sign);	
				
			end //if (en)
	end	//always


endmodule
