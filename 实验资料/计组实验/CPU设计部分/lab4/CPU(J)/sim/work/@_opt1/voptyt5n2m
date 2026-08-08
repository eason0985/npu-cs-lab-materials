library verilog;
use verilog.vl_types.all;
entity id_exe is
    port(
        pc_4_out        : out    vl_logic_vector(31 downto 0);
        shamt_out       : out    vl_logic_vector(4 downto 0);
        a_out           : out    vl_logic_vector(31 downto 0);
        b_out           : out    vl_logic_vector(31 downto 0);
        imm_ext_out     : out    vl_logic_vector(31 downto 0);
        num_write_out   : out    vl_logic_vector(4 downto 0);
        reg_write_out   : out    vl_logic;
        mem_write_out   : out    vl_logic;
        s_data_write_out: out    vl_logic_vector(1 downto 0);
        aluop_out       : out    vl_logic_vector(3 downto 0);
        s_a_out         : out    vl_logic;
        s_b_out         : out    vl_logic;
        instruction_out : out    vl_logic_vector(31 downto 0);
        instruction_in  : in     vl_logic_vector(31 downto 0);
        shamt_in        : in     vl_logic_vector(4 downto 0);
        pc_4_in         : in     vl_logic_vector(31 downto 0);
        a_in            : in     vl_logic_vector(31 downto 0);
        b_in            : in     vl_logic_vector(31 downto 0);
        imm_ext_in      : in     vl_logic_vector(31 downto 0);
        num_write_in    : in     vl_logic_vector(4 downto 0);
        clock           : in     vl_logic;
        reset           : in     vl_logic;
        reg_write_in    : in     vl_logic;
        mem_write_in    : in     vl_logic;
        s_data_write_in : in     vl_logic_vector(1 downto 0);
        aluop_in        : in     vl_logic_vector(3 downto 0);
        s_a_in          : in     vl_logic;
        s_b_in          : in     vl_logic;
        id_exe_flush    : in     vl_logic
    );
end id_exe;
