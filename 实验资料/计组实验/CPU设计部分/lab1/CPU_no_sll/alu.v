`define ADDU   4'b0001  //addu
`define SUBU   4'b0011  //subu
`define ADD    4'b0000  //add
`define AND    4'b0100  //and
`define OR     4'b0101  //or 
`define SLT    4'b1010  //slt
//ALU模块接口定义
module alu(output reg [31:0] c   ,
	       input  [31:0] a   , 
	       input  [31:0] b   ,
           input  [3:0] aluop );
	always@(*)
		begin
		
		case(aluop)
			`ADDU:c = a + b;//addu
			`SUBU:c = a - b;//subu
			`ADD:c = a + b;//add
			`AND:c = a & b;//and
			`OR:c = a | b;//or
			`SLT:begin
						c = ($signed(a) < $signed(b)) ? 32'd1 : 32'd0;
					end
		endcase

		end

endmodule