module s_cycle_cpu(input clock, //时钟信号
		            input reset);  //复位信号  
	
	parameter pc_4 = 32'h00000004;//用于实现PC+4
	parameter op_pc_4 = 4'b0001;//用于实现PC+4的op
	
	wire [31:0] pc;//当前pc
	wire [31:0] instruction;//32位指令
	wire [31:0] alu_out;//a和b运算后的输出
	wire [31:0] npc;//next pc
	wire [31:0] a;//读寄存器1的值
	wire [31:0] b;//读寄存器2的值
	wire reg_write;//写使能
	wire [3:0] aluop;//aluop
	wire [5:0] op = instruction[31:26];//opcode
	wire [5:0] funct = instruction[5:0];//funct字段	
	
	pc PC(
		.pc(pc),
		.clock(clock),
		.reset(reset),
		.npc(npc)
		);
		
	alu PC_NPC(
		.a(pc),
		.b(pc_4),
		.c(npc),
		.aluop(op_pc_4)
		);
		
	im IM(
		.pc(pc),
		.instruction(instruction)
		);

	gpr GPR(
		.a(a),
		.b(b),
		.clock(clock),
		.reg_write(reg_write),
		.num_write(instruction[15:11]),
		.data_write(alu_out),
		.rs(instruction[25:21]),
		.rt(instruction[20:16])
		);
		
	alu ALU(
		.a(a),
		.b(b),
		.c(alu_out),
		.aluop(aluop)
		);
	
	ctrl CTRL(
		.op(op),
		.funct(funct),
		.reg_write(reg_write),
		.aluop(aluop)
		);
		
endmodule