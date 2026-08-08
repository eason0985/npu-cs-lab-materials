module mux_32_4to1( input [1:0] s,//选择条件
			input [31:0] zero,//当s为0时会输出的值
			input [31:0] one,//当s为1时会输出的值
			input [31:0] two,//当s为2时会输出的值
			input [31:0] three,//当s为3时会输出的值
			output reg [31:0] result);
	
	always @(*)
		begin
			if(s == 2'b00)
				result = zero;
			else if(s == 2'b01)
				result = one;
			else if(s == 2'b10)
				result = two;
			else
				result = three;
		end
endmodule