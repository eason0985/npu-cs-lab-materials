module exe_mem( output reg [31:0] pc_4_out,//EXE to MEM
				output reg [31:0] c_out,//c 也就是alu输出的结果
				output reg [31:0] b_out,//b
				output reg [4:0] num_write_out,//num_write 要写的寄存器的编号
				output reg reg_write_out,//写使能
				output reg mem_write_out,
				output reg [1:0] s_data_write_out,
				input [31:0] pc_4_in,
				input [31:0] c_in,
				input [31:0] b_in,
				input [4:0] num_write_in,
				input reg_write_in,
				input clock,
				input reset,
				input mem_write_in,
				input [1:0] s_data_write_in
			  );
	always @(posedge clock)
		begin 
			if(!reset)//复位时把下面的这些全部复位为0
				begin
					pc_4_out <= 32'd0;
					c_out <= 32'd0;
					b_out <= 32'd0;
					num_write_out <= 5'd0;
					reg_write_out <= 1'd0;
					mem_write_out <= 1'd0;
					s_data_write_out <= 2'b00; 
				end
			else
				begin//正常运行的时候就向后传递
					pc_4_out <= pc_4_in;
					c_out <= c_in;
					b_out <= b_in;
					num_write_out <= num_write_in;
					reg_write_out <= reg_write_in;
					mem_write_out <= mem_write_in;
					s_data_write_out <= s_data_write_in;
				end
		end
endmodule