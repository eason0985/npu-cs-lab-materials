module blockage( output reg pc_write,
				 output reg if_id_write,
				 output reg id_exe_flush,
				 output reg if_id_flush,
				 input [31:0] instruction_id,
				 input [31:0] instruction_exe,
				 input zero
				);

	always @(*)
		begin
			pc_write = 0;
			if_id_write = 0;
			id_exe_flush = 0;
			if_id_flush = 0;
			//R型指令
			if(instruction_id[31:26] == 6'd0 && instruction_exe[31:26] == 6'b100011 && ((instruction_exe[20:16] == instruction_id[25:21]) || (instruction_exe[20:16] == instruction_id[20:16])) && instruction_exe[20:16] != 5'd0)
				begin
					pc_write = 1;
					if_id_write = 1;
					id_exe_flush = 1;
				end
			//I型要存入到rt，不能和R型一样处理
			else if(instruction_exe[31:26] == 6'b100011 && (instruction_exe[20:16] == instruction_id[25:21]) && instruction_exe[20:16] != 5'd0)
				begin
					pc_write = 1;
					if_id_write = 1;
					id_exe_flush = 1;
				end
			else;
			if(instruction_id[31:26] == 6'b000010 || instruction_id[31:26] == 6'b000011 ||(instruction_id[5:0] == 6'b001000 && instruction_id[31:26] == 6'd0) || (instruction_id[31:26] == 6'b000100 && zero == 0) )//j型指令
				if_id_flush = 1;
			else;
		end
		
endmodule