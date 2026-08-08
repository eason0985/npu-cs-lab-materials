module tb_cpu1();

reg clock,reset;

s_cycle_cpu CPU(
    .clock(clock),
    .reset(reset)
);

initial begin 
    $readmemh("code.txt",CPU.IM.ins_memory);
    //CPU.IM.ins_memory[0] = 32'b00000000000010010101100100000000;
    CPU.GPR.gp_registers[32'd11] = 32'd1;
    CPU.GPR.gp_registers[32'd10] = 32'd2;

    reset = 1'b0;
    clock = 0;
    #50 clock = ~clock;
    #50 clock = ~clock;
    reset = 1'b1;
    forever #50 clock = ~clock;
end



endmodule