//原理和其他几个流水线寄存器差不多，exe_mem写了详细注释，这个就不细写了
module if_id( output reg [31:0] pc_4_out,//if_id,传的参数最少的一集
			  output reg [31:0] instruction_out,
			  input [31:0] instruction_in,
			  input [31:0] pc_4_in,
			  input clock,
			  input reset,
			  input if_id_write
			);
			
	always @(posedge clock)
		begin
			if(!reset)
				begin
					pc_4_out <= 32'd0;
					instruction_out <= 32'd0;
				end
			else if(!if_id_write)
				begin
					pc_4_out <= pc_4_in;
					instruction_out <= instruction_in;
				end
			else; 
		end

endmodule