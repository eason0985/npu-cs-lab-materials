library verilog;
use verilog.vl_types.all;
entity mem_wb is
    port(
        pc_4_out        : out    vl_logic_vector(31 downto 0);
        c_out           : out    vl_logic_vector(31 downto 0);
        data_out_out    : out    vl_logic_vector(31 downto 0);
        num_write_out   : out    vl_logic_vector(4 downto 0);
        reg_write_out   : out    vl_logic;
        s_data_write_out: out    vl_logic_vector(1 downto 0);
        pc_4_in         : in     vl_logic_vector(31 downto 0);
        c_in            : in     vl_logic_vector(31 downto 0);
        data_out_in     : in     vl_logic_vector(31 downto 0);
        num_write_in    : in     vl_logic_vector(4 downto 0);
        reg_write_in    : in     vl_logic;
        clock           : in     vl_logic;
        reset           : in     vl_logic;
        s_data_write_in : in     vl_logic_vector(1 downto 0)
    );
end mem_wb;
