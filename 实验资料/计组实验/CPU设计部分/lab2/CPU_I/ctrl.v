module ctrl( output reg reg_write  ,
             output reg [3:0] aluop ,
			 output reg s_a,
			 output reg s_b,
			 output reg s_sum_write,
			 output reg s_ext,
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
				end
			else if(op == 6'd0)//R型指令
					begin
						s_sum_write = 1;
						reg_write = 1;
						s_b = 0;
						aluop = funct[3:0];
						s_ext = 0;
					end
				 else
					begin//除了lui之外的I型
						s_sum_write = 0;
						aluop = op[3:0];
						reg_write = 1;
						s_b = 1;
						s_ext = (op == 6'b001100 || op == 6'b001101) ? 1'b0 : 1'b1;//当op为andi或ori的op时无符号拓展
					end
			if(shamt != 5'd0 && op == 6'd0)//注意只有R型指令才可能有位移，不然I型指令也会出现s_a = 1,结果会出错
				s_a = 0;
			else
				s_a = 1;
		end
endmodule
