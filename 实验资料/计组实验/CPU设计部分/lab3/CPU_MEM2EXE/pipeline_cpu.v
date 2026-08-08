module pipeline_cpu(input clock, //时钟信号
		            input reset);  //复位信号  
	
	parameter pc_4 = 32'h00000004;//用于实现PC+4
	parameter op_pc_4 = 4'b0001;//用于实现PC+4的op
	parameter shamt_pc_4 = 5'b00000;//用于实现PC+4的shamt
	parameter s_a_pc_4 = 1'b1;//用于实现PC+4的s_a
	parameter mux_s_num_write_31 = 5'h31;
	
	wire [31:0] pc;//当前pc
	wire [31:0] instruction_out;//32位指令
	wire [31:0] alu_out;//a和b运算后的输出
	wire [31:0] npc;//next pc
	wire [31:0] a;//读寄存器1的值
	wire [31:0] b;//读寄存器2的值
	wire reg_write;//写使能
	wire [3:0] aluop;//aluop
	wire [31:0] instruction;
	wire [5:0] op = instruction_out[31:26];//opcode
	wire [5:0] funct = instruction_out[5:0];//funct字段	
	wire [4:0] shamt = instruction_out[10:6];
	wire s_a;
	wire s_b;
	wire [1:0] s_num_write;
	wire [4:0] rs = instruction_out[25:21];
	wire [4:0] rt = instruction_out[20:16];
	wire [4:0] rd = instruction_out[15:11];
	wire [31:0] imm_ext;
	wire s_ext;
	wire [15:0] imm = instruction_out[15:0];
	wire [31:0] result_b;//注意这里的位宽是32位
	wire [4:0] result;
	wire [31:0] data_out;
	wire mem_write;
	wire [1:0] s_data_write;
	wire [31:0] result_data_write;
	wire [31:0] pc_4_1;
	wire [31:0] pc_4_2;
	wire [31:0] pc_4_3;
	wire [31:0] pc_4_4;
	wire [4:0] shamt_out;        
	wire [31:0] a_out;            
	wire [31:0] b_out_1;          
	wire [31:0] imm_ext_out;      
	wire [4:0] num_write_1;       
	wire reg_write_1;             
	wire [31:0] c_out;            
	wire [31:0] b_out_2;          
	wire [4:0] num_write_2;       
	wire reg_write_2;                     
	wire [31:0] c_out_1;          
	wire [31:0] data_out_out;     
	wire [4:0] num_write_3;       
	wire reg_write_3;  
	wire [4:0] num_write_0;
	wire mem_write_1;
	wire mem_write_2;
	wire [1:0] s_data_write_1;
	wire [1:0] s_data_write_2;
	wire [1:0] s_data_write_3;
	wire [3:0] aluop_out;
	wire s_a_out;
	wire s_b_out;
	wire [31:0] instruction_1;
	wire [4:0] rs_exe = instruction_1[25:21];
	wire [4:0] rt_exe = instruction_1[20:16];
	wire s_forwardA3;
	wire s_forwardB3;
	wire [31:0] result_forwardB3;
	wire [31:0] result_forwardA3;

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
		
	mux_5_3to1 MUX_S_num_WRITE(
		.zero(rt),//注意位宽
		.one(rd),
		.two(mux_s_num_write_31),
		.s(s_num_write),
		.result(num_write_0)
		);
		
	if_id IF_ID(
		.pc_4_out(pc_4_1),
		.instruction_out(instruction_out),
		.instruction_in(instruction),
		.pc_4_in(npc),
		.clock(clock),
		.reset(reset)
		);
		
	gpr GPR(
		.a(a),
		.b(b),
		.clock(clock),
		.reg_write(reg_write_3),
		.num_write(num_write_3),
		.data_write(result_data_write),
		.rs(rs),
		.rt(rt)
		);
	
	id_exe ID_EXE(
		.pc_4_out(pc_4_2),
	    .shamt_out(shamt_out),
		.a_out(a_out),
		.b_out(b_out_1),
		.imm_ext_out(imm_ext_out),
		.num_write_out(num_write_1),
		.reg_write_out(reg_write_1),
		.mem_write_out(mem_write_1),
		.s_data_write_out(s_data_write_1),
		.aluop_out(aluop_out),
		.s_a_out(s_a_out),
		.s_b_out(s_b_out),
		.instruction_out(instruction_1),
		.instruction_in(instruction_out),
		.shamt_in(shamt),
		.pc_4_in(pc_4_1),
		.a_in(a),
		.b_in(b),
		.imm_ext_in(imm_ext),
		.num_write_in(num_write_0),
		.clock(clock),
		.reset(reset),
		.reg_write_in(reg_write),
		.s_data_write_in(s_data_write),
		.mem_write_in(mem_write),
		.aluop_in(aluop),
		.s_a_in(s_a),
		.s_b_in(s_b)
		);

	ext EXT(
		.s_ext(s_ext),
		.imm(imm),
		.imm_ext(imm_ext)
		);
		
	mux_32_2to1 MUX_S_FORWARDA3(
		.s(s_forwardA3),
		.zero(c_out),
		.one(a_out),
		.result(result_forwardA3)
		);
		
	mux_32_2to1 MUX_S_FORWARDB3(
		.s(s_forwardB3),
		.zero(c_out),
		.one(b_out_1),
		.result(result_forwardB3)
		);
	
	mux_32_2to1 MUX_s_b(
		.zero(result_forwardB3),
		.one(imm_ext_out),
		.s(s_b_out),
		.result(result_b)
		);
	
	alu ALU(
		.a(result_forwardA3),
		.b(result_b),
		.c(alu_out),
		.aluop(aluop_out),
		.s_a(s_a_out),
		.shamt(shamt_out)
		);
	
	exe_mem EXE_MEM(
		.clock(clock),
		.reset(reset),
		.pc_4_out(pc_4_3),
		.c_out(c_out),
		.b_out(b_out_2),
		.num_write_out(num_write_2),
		.reg_write_out(reg_write_2),
		.mem_write_out(mem_write_2),
		.s_data_write_out(s_data_write_2),
		.pc_4_in(pc_4_2),
		.c_in(alu_out),
		.b_in(result_forwardB3),
		.num_write_in(num_write_1),
		.reg_write_in(reg_write_1),
		.mem_write_in(mem_write_1),
		.s_data_write_in(s_data_write_1)
		);

	bypass BYPASS(
		.s_forwardA3(s_forwardA3),
		.s_forwardB3(s_forwardB3),
		.num_write_mem(num_write_2),
		.rs_exe(rs_exe),
		.rt_exe(rt_exe),
		.reg_write_mem(reg_write_2)
		);
	
	dm DM(
		.data_out(data_out),
		.clock(clock),
		.mem_write(mem_write_2),
		.address(c_out),   
        .data_in(b_out_2)   
		);
	
	mem_wb MEM_WB(
		.pc_4_out(pc_4_4),
		.c_out(c_out_1),
		.data_out_out(data_out_out),
		.num_write_out(num_write_3),
		.reg_write_out(reg_write_3),
		.s_data_write_out(s_data_write_3),
		.pc_4_in(pc_4_3),
		.c_in(c_out),
		.data_out_in(data_out),
		.num_write_in(num_write_2),
		.reg_write_in(reg_write_2),
		.s_data_write_in(s_data_write_2),
		.clock(clock),
		.reset(reset)
		);
		
	mux_32_3to1 MUX_S_DATA_WRITE(
		.zero(pc_4_4),
		.one(c_out_1),
		.two(data_out_out),
		.s(s_data_write_3),
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
		.s_num_write(s_num_write),
		.mem_write(mem_write),
		.s_data_write(s_data_write)
		);
		
endmodule