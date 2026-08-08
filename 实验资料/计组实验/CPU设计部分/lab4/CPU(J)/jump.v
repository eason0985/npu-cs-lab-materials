module jump(output reg [31:0] jump_target,
			input [31:0] pc,
			input [25:0] instr_index);
			
	always @(*)
		begin
			jump_target = {pc[31:28], instr_index, 2'b00};//PC ←{PC[31..28 ], instr_index ,2’b00}
		end
endmodule