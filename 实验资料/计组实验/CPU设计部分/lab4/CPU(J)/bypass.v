module bypass(output reg [1:0] s_forwardA3,
			  output reg [1:0] s_forwardB3,//两个旁路的选择信号
			  input [4:0] num_write_mem,//传递到MEM阶段的num_write
			  input [4:0] rs_exe,//exe阶段的rs
			  input [4:0] rt_exe,//exe阶段的rt
			  input reg_write_mem,//mem阶段的reg_write
			  input [4:0] num_write_wb,
			  input reg_write_wb
			  );
	
	always @(*)
		begin
			s_forwardA3 = 2'b10;//不走旁路
			s_forwardB3 = 2'b10;//设置初始值，不然会出错。
			
			if(reg_write_mem && (rs_exe == num_write_mem) && num_write_mem != 0)//0号寄存器不能写必须&& num_write_mem != 0
			//血的教训 add $0, $1, $3   addi $13, $0, 0x002d
				s_forwardA3 = 2'b01;//EX——MEM旁路
			else if(reg_write_wb && (rs_exe == num_write_wb) && num_write_wb != 0)
				s_forwardA3 = 2'b00;//MEM——WB旁路
			else;
			if(reg_write_mem && (rt_exe == num_write_mem) && num_write_mem != 0)
				s_forwardB3 = 2'b01;
			else if(reg_write_wb && (rt_exe == num_write_wb) && num_write_wb != 0)
				s_forwardB3 = 2'b00;
			else;
		end
		
endmodule