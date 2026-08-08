module ctrl( output reg reg_write  ,
             output reg [3:0] aluop ,
			 output reg s_a,
			 output reg s_b,
			 output reg s_sum_write,
			 output reg s_ext,
			 output reg mem_write,
			 output reg s_data_write,
             input [5:0] op    ,
             input [5:0] funct,
			 input [4:0] shamt		);

	always@(*)
		begin
			if(op == 6'b001111)//特殊处理lui
				begin
					s_sum_write = 0;
					reg_write = 1;
					aluop = 4'b1111;
					s_b = 1;//应为要将这个立即数送进alu
					s_ext = 0;
					s_data_write = 0;
					mem_write = 0;
				end
			else if(op == 6'd0)//R型指令
					begin
						s_sum_write = 1;
						reg_write = 1;
						s_b = 0;
						aluop = funct[3:0];
						s_ext = 0;
						s_data_write = 0;
					    mem_write = 0;
					end
				 else
					begin//除了lui之外的I型
						s_sum_write = 0;
						if(op == 6'b100011 || op == 6'b101011) 
							aluop = 4'b0001;//用ADDU的
						else
							aluop = op[3:0];//lw和sw用这个会重复
						reg_write = (op == 6'b101011) ? 1'b0 : 1'b1;
						s_b = 1;
						s_ext = (op == 6'b001100 || op == 6'b001101) ? 1'b0 : 1'b1;//当op为andi或ori的op时无符号拓展
						mem_write = (op == 6'b101011) ? 1'b1 : 1'b0;
						s_data_write = (op == 6'b100011) ? 1'b1 : 1'b0;
					end
			if(shamt != 5'd0 && op == 6'd0)//注意只有R型指令才可能有位移，不然I型指令也会出现s_a = 1,结果会出错
				s_a = 0;
			else
				s_a = 1;
		end
endmodule
