module bypass(output reg s_forwardA3,
			  output reg s_forwardB3,//两个旁路的选择信号
			  input [4:0] num_write_mem,//传递到MEM阶段的num_write
			  input [4:0] rs_exe,//exe阶段的rs
			  input [4:0] rt_exe,//exe阶段的rt
			  input reg_write_mem//mem阶段的reg_write
			  );
	
	always @(*)
		begin
			s_forwardA3 = 1;
			s_forwardB3 = 1;//设置初始值，不然会出错。
			if(reg_write_mem && (rs_exe == num_write_mem) && num_write_mem != 0)//0号寄存器不能写必须&& num_write_mem != 0
				s_forwardA3 = 0;
			else;
			if(reg_write_mem && (rt_exe == num_write_mem))
				s_forwardB3 = 0;
			else;
		end
		
endmodule