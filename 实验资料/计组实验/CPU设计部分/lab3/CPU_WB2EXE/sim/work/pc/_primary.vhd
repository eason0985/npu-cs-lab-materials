library verilog;
use verilog.vl_types.all;
entity pc is
    port(
        pc              : out    vl_logic_vector(31 downto 0);
        clock           : in     vl_logic;
        reset           : in     vl_logic;
        npc             : in     vl_logic_vector(31 downto 0)
    );
end pc;
