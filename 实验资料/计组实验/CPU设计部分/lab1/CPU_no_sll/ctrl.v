module ctrl( output reg reg_write  ,
             output reg [3:0] aluop ,
             input [5:0] op    ,
             input [5:0] funct );

	always@(*)
		begin
			aluop = funct[3:0];//题目给的
			if(op == 6'd0)
				reg_write = 1;
			else
				reg_write = 0;
		end
endmodule