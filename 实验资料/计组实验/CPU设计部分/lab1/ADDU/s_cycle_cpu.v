module s_cycle_cpu(input clock, //时钟信号
		            input reset);  //复位信号  
	
	parameter reg_write_1 = 1'b1;//寄存器写使能先设定为1
	parameter pc_4 = 32'h00000004;//用于实现PC+4
	
	wire [31:0] pc;//当前pc
	wire [31:0] instruction;//32位指令
	wire [31:0] alu_out;//a+b后的输出
	wire [31:0] npc;//next pc
	wire [31:0] a;//读寄存器1的值
	wire [31:0] b;//读寄存器2的值
	
	pc PC(
		.pc(pc),
		.clock(clock),
		.reset(reset),
		.npc(npc)
		);
		
	alu PC_NPC(
		.a(pc),
		.b(pc_4),
		.c(npc)
		);
		
	im IM(
		.pc(pc),
		.instruction(instruction)
		);

	gpr GPR(
		.a(a),
		.b(b),
		.clock(clock),
		.reg_write(reg_write_1),
		.num_write(instruction[15:11]),
		.data_write(alu_out),
		.rs(instruction[25:21]),
		.rt(instruction[20:16])
		);
		
	alu ALU(
		.a(a),
		.b(b),
		.c(alu_out)
		);
		
endmodule