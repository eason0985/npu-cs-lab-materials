library verilog;
use verilog.vl_types.all;
entity mux_32_2to1 is
    port(
        s               : in     vl_logic;
        zero            : in     vl_logic_vector(31 downto 0);
        one             : in     vl_logic_vector(31 downto 0);
        result          : out    vl_logic_vector(31 downto 0)
    );
end mux_32_2to1;
