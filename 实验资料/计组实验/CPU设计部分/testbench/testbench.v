`timescale 1ns / 1ps

module tb_s_cycle_cpu_addu;

    reg  clock;
    reg  reset;
    
    // 内部信号
    wire [31:0] pc;
    wire [31:0] instruction;
    wire [31:0] a, b;           // 寄存器堆输出
    wire [31:0] alu_out;
    wire [4:0]  rs, rt, rd;
    wire        reg_write;
    wire [31:0] write_data;
    
    // 指令字段提取
    assign rs = instruction[25:21];
    assign rt = instruction[20:16];
    assign rd = instruction[15:11];
    
    // 实例化 PC
    pc u_pc (
        .pc(pc),
        .clock(clock),
        .reset(reset),
        .npc(pc + 4)
    );
    
    // 实例化指令存储器 (直接初始化)
    im u_im (
        .instruction(instruction),
        .pc(pc)
    );
    
    // 实例化寄存器堆
    gpr u_gpr (
        .a(a),
        .b(b),
        .clock(clock),
        .reg_write(reg_write),
        .rs(rs),
        .rt(rt),
        .num_write(rd),
        .data_write(write_data)
    );
    
    // 实例化 ALU
    alu u_alu (
        .c(alu_out),
        .a(a),
        .b(b)
    );
    
    // 控制信号：addu 是 R-type，需要写寄存器
    assign reg_write = (instruction[31:26] == 6'b000000) ? 1 : 0;  // R-type 指令
    assign write_data = alu_out;
    
    // 时钟生成
    always #5 clock = ~clock;
    
    // 测试主程序
    initial begin
        // 初始化
        clock = 0;
        reset = 1;
        
        // 波形记录
        $dumpfile("tb_addu.vcd");
        $dumpvars(0, tb_s_cycle_cpu_addu);
        
        // 复位
        #15 reset = 0;
        
        // 运行足够多的时钟周期
        #200;
        
        // 显示结果
        $display("\n========== 测试结果 ==========");
        $display("PC地址变化:");
        
        #10 $display("PC = 0x%h, 指令 = 0x%h", pc, instruction);
        #10 $display("PC = 0x%h, 指令 = 0x%h", pc, instruction);
        #10 $display("PC = 0x%h, 指令 = 0x%h", pc, instruction);
        
        #20 $display("\n最终寄存器值:");
        $display("$t0 = %0d", u_gpr.gp_registers[8]);  // $8 = $t0
        $display("$t1 = %0d", u_gpr.gp_registers[9]);  // $9 = $t1
        $display("$t2 = %0d", u_gpr.gp_registers[10]); // $10 = $t2
        
        $finish;
    end
    
    // 监控关键信号
    initial begin
        $monitor("时间=%0t, PC=0x%h, 指令=0x%h, rs=%0d, rt=%0d, a=%0d, b=%0d, alu_out=%0d, 写寄存器=%0d", 
                 $time, pc, instruction, rs, rt, a, b, alu_out, rd);
    end

endmodule