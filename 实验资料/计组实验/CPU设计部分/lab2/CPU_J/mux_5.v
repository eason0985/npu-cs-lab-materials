//专门为s_sum_write为选择的二选一设计的mux
module mux_5( input [1:0]s,//选择条件
			input [4:0] zero,//当s为0时会输出的值
			input [4:0] one,//当s为1时会输出的值
			input [4:0] two,//当s为2时会输出的值
			output reg [4:0] result);
	
	always @(*)
		begin
			if(s == 2'b0)
				result = zero;
			else if(s == 2'b1)
				result = one;
			else
				result = two;
		end
endmodule