library verilog;
use verilog.vl_types.all;
entity ctrl is
    port(
        reg_write       : out    vl_logic;
        aluop           : out    vl_logic_vector(3 downto 0);
        s_a             : out    vl_logic;
        s_b             : out    vl_logic;
        s_sum_write     : out    vl_logic_vector(1 downto 0);
        s_ext           : out    vl_logic;
        mem_write       : out    vl_logic;
        s_data_write    : out    vl_logic_vector(1 downto 0);
        s_npc           : out    vl_logic_vector(1 downto 0);
        op              : in     vl_logic_vector(5 downto 0);
        funct           : in     vl_logic_vector(5 downto 0);
        instr_index     : in     vl_logic_vector(25 downto 0);
        shamt           : in     vl_logic_vector(4 downto 0)
    );
end ctrl;
