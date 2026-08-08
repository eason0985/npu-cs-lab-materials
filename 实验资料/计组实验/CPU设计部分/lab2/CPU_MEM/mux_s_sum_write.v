//专门为s_sum_write为选择的二选一设计的mux
module mux_s_sum_write( input s,//选择条件
			input [4:0] zero,//当s为0时会输出的值
			input [4:0] one,//当s为1时会输出的值
			output reg [4:0] result);
	
	always @(*)
		begin
			if(s == 1'b0)
				result = zero;
			else
				result = one;
		end
endmodule