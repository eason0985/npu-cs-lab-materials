library verilog;
use verilog.vl_types.all;
entity s_cycle_cpu is
    generic(
        pc_4            : integer := 4;
        mux_s_sum_write_31: vl_logic_vector(0 to 4) := (Hi1, Hi1, Hi1, Hi1, Hi1)
    );
    port(
        clock           : in     vl_logic;
        reset           : in     vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of pc_4 : constant is 1;
    attribute mti_svvh_generic_type of mux_s_sum_write_31 : constant is 1;
end s_cycle_cpu;
