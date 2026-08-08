//5位的三选一
module mux_5_3to1( input [1:0] s,//选择条件
			input [4:0] zero,//当s为0时会输出的值
			input [4:0] one,//当s为1时会输出的值
			input [4:0] two,
			output reg [4:0] result);
	
	always @(*)
		begin
			if(s == 2'b00)
				result = zero;
			else if(s == 2'b01)
				result = one;
			else 
				result = two;
		end
endmodule