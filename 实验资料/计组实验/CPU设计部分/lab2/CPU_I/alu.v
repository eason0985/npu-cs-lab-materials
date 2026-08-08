`define ADDU   4'b0001  //addu
`define SUBU   4'b0011  //subu
`define ADD    4'b0000  //add
`define AND    4'b0100  //and
`define OR     4'b0101  //or 
`define SLT    4'b1010  //slt
//i型指令的新的宏定义：
`define ADDI   4'b1000
`define ADDIU  4'b1001
`define ANDI   4'b1100
`define ORI    4'b1101
`define LUI    4'b1111
//ALU模块接口定义
module alu(output reg [31:0] c   ,
	       input  [31:0] a   , 
	       input  [31:0] b   ,
           input  [3:0] aluop ,
		   input s_a,
		   input [4:0] shamt
		   );
	always@(*)
		begin
			if(s_a == 1)
				begin
					case(aluop)
						`SUBU:c = a - b;//subu
						`ANDI,`AND:c = a & b;//and andi
						`ORI,`OR:c = a | b;//or ori
						`SLT:begin
									c = ($signed(a) < $signed(b)) ? 32'd1 : 32'd0;
							 end
						`ADDI,`ADDIU,`ADD,`ADDU: c = a + b;
						`LUI: c = {b[15:0], 16'b0}; //如果是lui就将立即数这样拓展：{imm，016 }
					endcase
				end
			else
				begin
					c = b << $signed(shamt);
				end

		end

endmodule