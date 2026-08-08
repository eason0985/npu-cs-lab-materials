module mux_alu( input s,//选择条件
			input [31:0] zero,//当s为0时会输出的值
			input [31:0] one,//当s为1时会输出的值
			output reg [31:0] result);
	
	always @(*)
		begin
			if(s == 1'b0)
				result = zero;
			else
				result = one;
		end
endmodule