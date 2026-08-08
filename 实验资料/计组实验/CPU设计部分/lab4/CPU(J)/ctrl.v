module ctrl( output reg reg_write  ,
             output reg [3:0] aluop ,
			 output reg s_a,
			 output reg s_b,
			 output reg [1:0] s_num_write,
			 output reg s_ext,
			 output reg mem_write,
			 output reg [1:0] s_data_write,
			 output reg [1:0] s_npc,
             input [5:0] op    ,
             input [5:0] funct, 
			 input [4:0] shamt
			 );

	always@(*)
		begin
			if(op == 6'b000100)//beq
				begin
					s_num_write = 0;
					reg_write = 0;
					aluop = 4'b0011;//为了得到zero信号，需要减法
					s_b = 0;
					s_ext = 1;
					s_data_write = 2'b00;
					mem_write = 0;
					s_npc = 2'b00;
				end
			else if(op == 6'b000000 && funct == 6'b001000)//jr 后面那句很重要，不然全部op=0的都当jr跳了
				begin
					s_num_write = 0;
					reg_write = 0;
					aluop = 4'b0000;
					s_b = 0;
					s_ext = 0;
					s_data_write = 2'b00;
					mem_write = 0;
					s_npc = 2'b01;
				end
			else if(op == 6'b000010)//j
				begin
					s_num_write = 0;
					reg_write = 0;
					aluop = 4'b0000;
					s_b = 0;
					s_ext = 0;
					s_data_write = 2'b00;
					mem_write = 0;
					s_npc = 2'b10;
				end
			else if(op == 6'b000011)//jar
				begin
					s_num_write = 2;
					reg_write = 1;
					aluop = 4'b0000;
					s_b = 0;
					s_ext = 0;
					s_data_write = 2'b00;
					mem_write = 0;
					s_npc = 2'b10;
				end
			else if(op == 6'b001111)//特殊处理lui
				begin
					s_num_write = 0;
					reg_write = 1;
					aluop = 4'b1111;
					s_b = 1;//应为要将这个立即数送进alu
					s_ext = 0;
					s_data_write = 2'b01;
					mem_write = 0;
					s_npc = 2'b11;
				end
			else if(op == 6'd0 && funct != 6'b001000)//R型指令
					begin
						s_num_write = 1;
						reg_write = 1;
						s_b = 0;
						aluop = funct[3:0];
						s_ext = 0;
						s_data_write = 2'b01;
					    mem_write = 0;
						s_npc = 2'b11;
					end
				 else
					begin//除了lui之外的I型
						s_num_write = 0;
						if(op == 6'b100011 || op == 6'b101011) 
							aluop = 4'b0001;//用ADDU的
						else
							aluop = op[3:0];//lw和sw用这个会重复
						reg_write = (op == 6'b101011) ? 1'b0 : 1'b1;//lw要存入到寄存器里，regwrite需要有效
						s_b = 1;
						s_ext = (op == 6'b001100 || op == 6'b001101) ? 1'b0 : 1'b1;//当op为andi或ori的op时无符号拓展
						mem_write = (op == 6'b101011) ? 1'b1 : 1'b0;
						s_data_write = (op == 6'b100011) ? 2'b10 : 1'b01;
						s_npc = 2'b11;
					end
			if(shamt != 5'd0 && op == 6'd0)//注意只有R型指令才可能有位移，不然I型指令也会出现s_a = 1,结果会出错
				s_a = 0;
			else
				s_a = 1;
		end
endmodule
