module ext( output reg [31:0] imm_ext,//拓展后的立即数
			input s_ext,//选择
			input [15:0] imm);//imm字段
	always@(*)
		begin
			if(s_ext)//有符号
				imm_ext = {{16{imm[15]}}, imm[15:0]}; 
			else//无符号
				imm_ext = {16'b0, imm};
		end
endmodule