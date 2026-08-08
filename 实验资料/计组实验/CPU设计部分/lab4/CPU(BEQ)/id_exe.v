//原理和其他几个流水线寄存器差不多，exe_mem写了详细注释，这个就不细写了
module id_exe( output reg [31:0] pc_4_out,//id2exe
			   output reg [4:0] shamt_out,
			   output reg [31:0] a_out,
			   output reg [31:0] b_out,
			   output reg [31:0] imm_ext_out,
			   output reg [4:0] num_write_out,
			   output reg reg_write_out,
			   output reg mem_write_out,
			   output reg [1:0] s_data_write_out,
			   output reg [3:0] aluop_out,
			   output reg s_a_out,
			   output reg s_b_out,
			   output reg [31:0] instruction_out,
			   input [31:0] instruction_in,
			   input [4:0] shamt_in,
			   input [31:0] pc_4_in,
			   input [31:0] a_in,
			   input [31:0] b_in,
			   input [31:0] imm_ext_in,
			   input [4:0] num_write_in,
			   input clock,
			   input reset,
			   input reg_write_in,
			   input mem_write_in,
			   input [1:0] s_data_write_in,
			   input [3:0] aluop_in,
			   input s_a_in,
			   input s_b_in,
			   input id_exe_flush
			  );

	always @(posedge clock)
		begin
			if(!reset)
				begin 
					pc_4_out <= 32'd0;
					shamt_out <= 5'd0;
					a_out <= 32'd0;
					b_out <= 32'd0;
					imm_ext_out <= 32'd0;
					num_write_out <= 5'd0;
					reg_write_out <= 1'd0;
					mem_write_out <= 1'd0;
					s_data_write_out <= 2'b00; 
					instruction_out <= 32'd0;
				end
			else if(!id_exe_flush)
				begin
					pc_4_out <= pc_4_in;
					shamt_out <= shamt_in;
					a_out <= a_in;
					b_out <= b_in;
					imm_ext_out <= imm_ext_in;
					num_write_out <= num_write_in;
					reg_write_out <= reg_write_in;
					mem_write_out <= mem_write_in;
					s_data_write_out <= s_data_write_in;
					aluop_out <= aluop_in;
					s_a_out <= s_a_in;
					s_b_out <= s_b_in;
					instruction_out <= instruction_in;
				end
			else
				begin
					pc_4_out <= 32'd0;
					shamt_out <= 5'd0;
					a_out <= 32'd0;
					b_out <= 32'd0;
					imm_ext_out <= 32'd0;
					num_write_out <= 5'd0;
					reg_write_out <= 1'd0;
					mem_write_out <= 1'd0;
					s_data_write_out <= 2'b00; 
					instruction_out <= 32'd0;
					aluop_out <= 4'd0;
					s_a_out <= 1'b1;
					s_b_out <= 1'b0;
				end
		end		
endmodule