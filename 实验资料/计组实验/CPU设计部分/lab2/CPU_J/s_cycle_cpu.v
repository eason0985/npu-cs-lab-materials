module s_cycle_cpu(input clock, //时钟信号
		            input reset);  //复位信号  
	
	parameter pc_4 = 32'h00000004;//用于实现PC+4
	parameter mux_s_sum_write_31 = 5'd31;//mux_s_sum_write当s_sum_write为2时应该选择为31
	
	wire [31:0] pc;//当前pc
	wire [31:0] instruction;//32位指令
	wire [31:0] alu_out;//a和b运算后的输出
	wire [31:0] npc;//next pc
	wire [31:0] npc_4;//pc+4得到的npc
	wire [31:0] a;//读寄存器1的值
	wire [31:0] b;//读寄存器2的值
	wire reg_write;//写使能
	wire [3:0] aluop;//aluop
	wire [5:0] op = instruction[31:26];//opcode
	wire [5:0] funct = instruction[5:0];//funct字段	
	wire [4:0] shamt = instruction[10:6];
	wire s_a;
	wire s_b;
	wire [1:0] s_sum_write;
	wire [4:0] rs = instruction[25:21];
	wire [4:0] rt = instruction[20:16];
	wire [4:0] rd = instruction[15:11];
	wire [25:0] instr_index = instruction[25:0];
	wire [31:0] imm_ext;
	wire s_ext;
	wire [15:0] imm = instruction[15:0];
	wire [31:0] result_b;//注意这里的位宽是32位
	wire [4:0] result;
	wire [31:0] data_out;
	wire mem_write;
	wire [1:0] s_data_write;
	wire [31:0] result_data_write;
	wire [1:0] s_npc;
	wire zero_output;
	wire [31:0] jump_target;
	wire [31:0] imm_ext_shift;
	wire [31:0] branch_adder;
	wire [31:0] beq_adder;
	assign imm_ext_shift = imm_ext << 2'b10;
	
	pc PC(
		.pc(pc),
		.clock(clock),
		.reset(reset),
		.npc(npc)
		);
	
	jump JUMP(
		.jump_target(jump_target),
		.pc(pc),
		.instr_index(instr_index)
		);
	
	add ADD_BEQ(
		.a(npc_4),
		.b(imm_ext_shift),
		.c(branch_adder)
		);
	
	mux_32_2to1 MUX_32_2to1_ZERO(
		.s(zero_output),
		.zero(npc_4),
		.one(branch_adder),
		.result(beq_adder)
		);
	
	mux_32_4to1 MUX_S_NPC(
		.zero(beq_adder),
		.one(a),
		.two(jump_target),
		.three(npc_4),
		.s(s_npc),
		.result(npc)
		);
		
	add PC_ADD(
		.a(pc),
		.b(pc_4),
		.c(npc_4)
		);
		
	im IM(
		.pc(pc),
		.instruction(instruction)
		);
		
	mux_5 MUX_S_SUM_WRITE(
		.zero(rt),//注意位宽
		.one(rd),
		.two(mux_s_sum_write_31),
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
		
	mux_32_2to1 MUX_s_b(
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
		.shamt(shamt),
		.zero(zero_output)
		);
		
	dm DM(
		.data_out(data_out),
		.clock(clock),
		.mem_write(mem_write),
		.address(alu_out),   
        .data_in(b)   
		);
	
	mux_32_3to1 MUX_S_DATA_WRITE(
		.zero(npc_4),
		.one(alu_out),
		.two(data_out),
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
		.s_npc(s_npc),
		.shamt(shamt),
		.s_sum_write(s_sum_write),
		.mem_write(mem_write),
		.instr_index(instr_index),
		.s_data_write(s_data_write)
		);
		
endmodule