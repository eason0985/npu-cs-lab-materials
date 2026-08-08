//ALU模块接口定义
module alu(output reg [31:0] c,
	       input  [31:0] a,
           input  [31:0] b );  
	
	always@(*)
		begin
			c = a + b; //加法
		end

endmodule