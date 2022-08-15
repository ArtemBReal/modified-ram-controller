module ram_ctrl_tb;
	parameter p_mem_size = 8;
	
	logic clk;
	logic en;
	logic we;
	logic re;
	logic rstN;
	
	logic [1:0] op_code;
	logic[p_mem_size-1:0] addr;
	logic[31:0] tb_data;

	wire[31:0] data_in;
	wire[31:0] data_out;
	
	reg [3:0] op_sign;
	int i;
	int j;
	
	ram_ctrl #(.p_mem_size(p_mem_size)) u0
	(
		.clk(clk),
		.en(en),
		.we(we),
		.re(re),
		.rstN(rstN),
		.op_code(op_code),
		.addr(addr),
		//.write_mem(write_mem),
		//.read_mem(read_mem),
		.data_in(data_in),
		.data_out(data_out),
		.op_sign(op_sign)
	
	);
	
	always #10 clk = ~clk;
	assign data_in = !re ? tb_data : 'hz;
	assign data_out = !we ? tb_data : 'hz;
	
	initial begin
		{clk, en, we, re, op_code, addr, tb_data, op_sign, rstN} <=0;
		repeat (2) @ (posedge clk);
		
		#10;
		$monitor ("\nSET TESTING PART\n");
		$monitor ("\n1. Writing to the beginning\n");
		rstN = 1;
		en = 1;
		op_code = 00;
		we = 1;
		re = 0;
		addr = $random;
		tb_data = $random;
		// $monitor ("Op_code = %b \tWE = %b \tRE = %b",
					   // op_code, we, re);
		#10;
		
		#10;
		$monitor ("\n2. Writing to the middle");
		rstN = 1;
		en = 1;
		op_code = 01;
		we = 1;
		re = 0;
		addr = $random;
		tb_data = $random;
		//$monitor ("Op_code = %b \tWE = %b \tRE = %b",
					   // op_code, we, re);
		#10;
	
		#10;
		$monitor ("\n3. Writing to the end");
		rstN = 1;
		en = 1;
		op_code = 10;
		we = 1;
		re = 0;
		addr = $random;
		tb_data = $random;
		// $monitor ("Op_code = %b \tWE = %b \tRE = %b",
					   // op_code, we, re);
		#10;
	
		#10;
		$monitor ("\n4. Writing to the whole array");
		rstN = 1;
		en = 1;
		op_code = 11;
		we = 1;
		re = 0;
		addr = $random;
		tb_data = $random;
		// $monitor ("Op_code = %b \tWE = %b \tRE = %b",
					   // op_code, we, re);
		#10;
	
		#10;
		$monitor ("\n1. Reading from the beginning\n");
		rstN = 1;
		en = 1;
		op_code = 00;
		we = 0;
		re = 1;
		addr = $random;
		//tb_data = $random;
		//$monitor ("Op_code = %b \tWE = %b \tRE = %b",
					   // op_code, we, re);
		#10;
		
		#10;
		$monitor ("\n2. Reading from the middle");
		rstN = 1;
		en = 1;
		op_code = 01;
		we = 0;
		re = 1;
		addr = $random;
		//tb_data = $random;
		// $monitor ("Op_code = %b \tWE = %b \tRE = %b",
					   // op_code, we, re);
		#10;
	
		#10;
		$monitor ("\n3. Reading from the end");
		rstN = 1;
		en = 1;
		op_code = 10;
		we = 0;
		re = 1;
		addr = $random;
		//tb_data = $random;
		// $monitor ("Op_code = %b \tWE = %b \tRE = %b",
					   // op_code, we, re);
		#10;
	
		#10;
		$monitor ("\n4. Reading the whole array");
		rstN = 1;
		en = 1;
		op_code = 11;
		we = 0;
		re = 1;
		addr = $random;
		//tb_data = $random;
		// $monitor ("Op_code = %b \tWE = %b \tRE = %b",
					   // op_code, we, re);
		#10;
		
		#10;
		{clk, en, we, re, op_code, addr, tb_data, op_sign, rstN} <=0;
		$monitor ("\nRANDOM TESTING PART\n");
		$monitor ("\nOp_code = %b \tWE = %b \tRE = %b",
					   op_code, we, re);			   
		#10;

		#10
		{clk, en, we, re, op_code, addr, tb_data, op_sign, rstN} <=0;
		
		repeat (2) @ (posedge clk);
		for (i = 0; i < 2**p_mem_size-1; i=i+1)
		begin
			#10;
			rstN = 1;
			en = 1;
			addr = $random;
			//#10;
			op_code = $random;
			we = $random;
			re = !we;
			if (!re)
			begin 
				tb_data = $random;
			end //if
			$monitor ("Op_code = %b \tWE = %b \tRE = %b",
					   op_code, we, re);
			#10;
			
			// $monitor ("Op_code = %b \tWE = %b \tRE = %b",
					   // op_code, we, re);
			
		end
	end
endmodule	
