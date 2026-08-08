//指令存储器接口定义
module im(output reg [31:0] instruction,
		  input  [31:0] pc           );      
//指令存储器4kB大小，类型为字，所以大小为1024字
reg [31:0] ins_memory[1023:0];

	always@(*)
		begin

		instruction = ins_memory[pc[11:2]];
 
		end

endmodule