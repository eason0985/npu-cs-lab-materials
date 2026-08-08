library verilog;
use verilog.vl_types.all;
entity mux_s_sum_write is
    port(
        s               : in     vl_logic;
        zero            : in     vl_logic_vector(4 downto 0);
        one             : in     vl_logic_vector(4 downto 0);
        result          : out    vl_logic_vector(4 downto 0)
    );
end mux_s_sum_write;
