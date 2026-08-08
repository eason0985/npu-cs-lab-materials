//原理和其他几个流水线寄存器差不多，exe_mem写了详细注释，这个就不细写了
module mem_wb(  output reg [31:0] pc_4_out,//mem_wb
				output reg [31:0] c_out,
				output reg [31:0] data_out_out,
				output reg [4:0] num_write_out,
				output reg reg_write_out,
				output reg [1:0] s_data_write_out,
				input [31:0] pc_4_in,
				input [31:0] c_in,
				input [31:0] data_out_in,
				input [4:0] num_write_in,
				input reg_write_in,
				input clock,
				input reset,
				input [1:0] s_data_write_in
			  );
	always @(posedge clock)
		begin
			if(!reset)
				begin
					pc_4_out <= 32'd0;
					c_out <= 32'd0;
					data_out_out <= 32'd0;
					num_write_out <= 5'd0;
					reg_write_out <= 1'd0;
					s_data_write_out <= 2'b00; 
				end
			else
				begin
					pc_4_out <= pc_4_in;
					c_out <= c_in;
					data_out_out <= data_out_in;
					num_write_out <= num_write_in;
					reg_write_out <= reg_write_in;
					s_data_write_out <= s_data_write_in;
				end
		end

endmodule
