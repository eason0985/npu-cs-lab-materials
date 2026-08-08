library verilog;
use verilog.vl_types.all;
entity pipeline_cpu is
    generic(
        pc_4            : integer := 4;
        op_pc_4         : vl_logic_vector(0 to 3) := (Hi0, Hi0, Hi0, Hi1);
        shamt_pc_4      : vl_logic_vector(0 to 4) := (Hi0, Hi0, Hi0, Hi0, Hi0);
        s_a_pc_4        : vl_logic := Hi1;
        mux_s_num_write_31: vl_logic_vector(0 to 4) := (Hi1, Hi0, Hi0, Hi0, Hi1);
        beq_addr        : vl_logic_vector(0 to 4) := (Hi1, Hi0, Hi0, Hi0, Hi1)
    );
    port(
        clock           : in     vl_logic;
        reset           : in     vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of pc_4 : constant is 1;
    attribute mti_svvh_generic_type of op_pc_4 : constant is 1;
    attribute mti_svvh_generic_type of shamt_pc_4 : constant is 1;
    attribute mti_svvh_generic_type of s_a_pc_4 : constant is 1;
    attribute mti_svvh_generic_type of mux_s_num_write_31 : constant is 1;
    attribute mti_svvh_generic_type of beq_addr : constant is 1;
end pipeline_cpu;
