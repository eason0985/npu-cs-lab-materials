library verilog;
use verilog.vl_types.all;
entity mux_5 is
    port(
        s               : in     vl_logic_vector(1 downto 0);
        zero            : in     vl_logic_vector(4 downto 0);
        one             : in     vl_logic_vector(4 downto 0);
        two             : in     vl_logic_vector(4 downto 0);
        result          : out    vl_logic_vector(4 downto 0)
    );
end mux_5;
