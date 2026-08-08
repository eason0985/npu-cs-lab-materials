//寄存器堆模块接口定义
module gpr(output reg [31:0]   a         ,  //寄存器1的值
		   output reg [31:0]   b         ,  //寄存器2的值
		   input         clock     ,
		   input         reg_write ,  //写使能信号
		   input [4:0]   rs        , //读寄存器1编号
		   input [4:0]   rt        , //读寄存器2编号
		   input [4:0]   num_write , //写寄存器编号
		   input [31:0]  data_write);  //写数据   	

reg [31:0] gp_registers[31:0]; //32个寄存器

	always@(*)
		begin
			a = gp_registers[rs];//读寄存器
			b = gp_registers[rt];
		end
		
	always @(posedge clock)//写寄存器
		begin
			if(reg_write && num_write != 5'b00000)//还要保证0号寄存器不能被写
				gp_registers[num_write] <= data_write;
			else;
		end
		
initial begin // 确保0号寄存器始终为0
		gp_registers[0] = 32'h00000000;
	   end
endmodule