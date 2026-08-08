module tb_cpu1();

reg clock,reset;

pipeline_cpu CPU(
    .clock(clock),
    .reset(reset)
);

initial begin 
    $readmemh("code.txt",CPU.IM.ins_memory);
    //CPU.IM.ins_memory[0] = 32'b00000000000010010101100100000000;
    CPU.GPR.gp_registers[32'd9] = 32'd2;
    CPU.GPR.gp_registers[32'd10] = 32'd1;
    CPU.GPR.gp_registers[32'd6] = 32'd3;
    CPU.GPR.gp_registers[32'd5] = 32'd5;
    CPU.GPR.gp_registers[32'd12] = 32'd6;
    CPU.GPR.gp_registers[32'd13] = 32'd7;
   
 reset = 1'b0;
    clock = 0;
    #50 clock = ~clock;
    #50 clock = ~clock;
    reset = 1'b1;
    forever #50 clock = ~clock;
end



endmodule