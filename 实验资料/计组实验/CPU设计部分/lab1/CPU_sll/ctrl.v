module ctrl( output reg reg_write  ,
             output reg [3:0] aluop ,
			 output reg s_a,
             input [5:0] op    ,
             input [5:0] funct,
			 input [4:0] shamt		);

	always@(*)
		begin
			aluop = funct[3:0];//题目给的
			if(op == 6'd0)
				reg_write = 1;
			else
				reg_write = 0;
			if(shamt == 5'd0)
				s_a = 1;
			else
				s_a = 0;
		end
endmodule