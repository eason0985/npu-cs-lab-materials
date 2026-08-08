//数据存储器
module dm(output reg [31:0] data_out  ,
		   input 	     clock     ,
		   input 	     mem_write ,
		   input  [31:0]  address   ,
           input  [31:0]  data_in   );
//4KB数据存储器
reg [31:0] data_memory[1023:0]; 

	always @(*)//读
		begin
			data_out = data_memory[(address >> 2) & 10'h3FF];//字节地址要转化为字地址
		end
		
	always @(posedge clock)//写
		begin
			if(mem_write)
				data_memory[(address >> 2) & 10'h3FF] = data_in;
		end
		
endmodule