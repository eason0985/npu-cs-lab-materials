//pc模块接口定义
module pc(output reg [31:0] pc   ,  //当前指令地址
		   input 	    clock,
		   input 	    reset,
		   input  [31:0]  npc,  //下条指令地址);
		   input pc_write
		  );
	always @ (posedge clock)
		begin
			if (!reset)        // 复位信号
		    	pc <= 32'h00003000 ;  // 初始地址	
			else if(!pc_write)
				pc <= npc;     //下一条指令的地址
			else;
		end
endmodule