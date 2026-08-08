module s_cycle_cpu(input clock, //时钟信号
		            input reset);  //复位信号  
	
	parameter pc_4 = 32'h00000004;//用于实现PC+4
	parameter op_pc_4 = 4'b0001;//用于实现PC+4的op
	parameter shamt_pc_4 = 5'b00000;//用于实现PC+4的shamt
	parameter s_a_pc_4 = 1'b1;//用于实现PC+4的s_a
	
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
	wire [4:0] shamt = instruction[10:6];
	wire s_a;
	wire s_b;
	wire s_sum_write;
	wire [4:0] rs = instruction[25:21];
	wire [4:0] rt = instruction[20:16];
	wire [4:0] rd = instruction[15:11];
	wire [31:0] imm_ext;
	wire s_ext;
	wire [15:0] imm = instruction[15:0];
	wire [31:0] result_b;//注意这里的位宽是32位
	wire [4:0] result;
	wire [31:0] data_out;
	wire mem_write;
	wire s_data_write;
	wire [31:0] result_data_write;
	
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
		.aluop(op_pc_4),
		.s_a(s_a_pc_4),
		.shamt(shamt_pc_4)
		);
		
	im IM(
		.pc(pc),
		.instruction(instruction)
		);
		
	mux_s_sum_write MUX_S_SUM_WRITE(
		.zero(rt),//注意位宽
		.one(rd),
		.s(s_sum_write),
		.result(result)
		);
		
	gpr GPR(
		.a(a),
		.b(b),
		.clock(clock),
		.reg_write(reg_write),
		.num_write(result),
		.data_write(result_data_write),
		.rs(rs),
		.rt(rt)
		);
	
	ext EXT(
		.s_ext(s_ext),
		.imm(imm),
		.imm_ext(imm_ext)
		);
		
	mux_alu MUX_s_b(
		.zero(b),
		.one(imm_ext),
		.s(s_b),
		.result(result_b)
		);
	
	alu ALU(
		.a(a),
		.b(result_b),
		.c(alu_out),
		.aluop(aluop),
		.s_a(s_a),
		.shamt(shamt)
		);
		
	dm DM(
		.data_out(data_out),
		.clock(clock),
		.mem_write(mem_write),
		.address(alu_out),   
        .data_in(b)   
		);
	
	mux_alu MUX_S_DATA_WRITE(
		.zero(alu_out),
		.one(data_out),
		.s(s_data_write),
		.result(result_data_write)
	);
	
	ctrl CTRL(
		.op(op),
		.funct(funct),
		.reg_write(reg_write),
		.aluop(aluop),
		.s_a(s_a),
		.s_b(s_b),
		.s_ext(s_ext),
		.shamt(shamt),
		.s_sum_write(s_sum_write),
		.mem_write(mem_write),
		.s_data_write(s_data_write)
		);
		
endmodule