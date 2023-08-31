library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.constants_pkg.all;

entity register_file is
  generic (
    REGISTER_SIZE          : positive range 32 to 32;
    REGISTER_NAME_SIZE     : positive;
    READ_PORTS             : positive range 1 to 3;
    WRITE_FIRST_SMALL_RAMS : boolean
    );
  port (
    clk        : in std_logic;
    rs1_select : in std_logic_vector(REGISTER_NAME_SIZE-1 downto 0);
    rs2_select : in std_logic_vector(REGISTER_NAME_SIZE-1 downto 0);
    rs3_select : in std_logic_vector(REGISTER_NAME_SIZE-1 downto 0);
    wb_select  : in std_logic_vector(REGISTER_NAME_SIZE-1 downto 0);
    wb_data    : in std_logic_vector(REGISTER_SIZE-1 downto 0);
    wb_enable  : in std_logic;
    
    wb2_select : in std_logic_vector(REGISTER_NAME_SIZE-1 downto 0);
    fpau_data_out2 : in std_logic_vector(REGISTER_SIZE -1 downto 0);
    wb2_enable : in std_logic;

    rs1_data_fpau : out std_logic_vector(REGISTER_SIZE -1 downto 0);
    rs2_data_fpau : out std_logic_vector(REGISTER_SIZE -1 downto 0);
    rs3_data_fpau : out std_logic_vector(REGISTER_SIZE -1 downto 0);

    rs1_data : out std_logic_vector(REGISTER_SIZE-1 downto 0);
    rs2_data : out std_logic_vector(REGISTER_SIZE-1 downto 0);
    rs3_data : out std_logic_vector(REGISTER_SIZE-1 downto 0)
    );
end;

architecture rtl of register_file is
  type register_vector is array(31 downto 0) of std_logic_vector(REGISTER_SIZE-1 downto 0);
  signal registers : register_vector := (others => (others => '0'));
  shared variable registers_variable : register_vector := (others => (others => '0'));

  signal writeback_select : std_logic_vector(REGISTER_NAME_SIZE-1 downto 0);
  signal writeback_data   : std_logic_vector(REGISTER_SIZE-1 downto 0);
  signal writeback_enable : std_logic;
  signal wb2_select_delay : std_logic_vector(REGISTER_NAME_SIZE-1 downto 0);
  signal wb2_enable_delay : std_logic;
  signal wb_data_delay    : std_logic_vector(REGISTER_SIZE-1 downto 0);

--These aliases are useful during simulation of software.
  alias ra  : std_logic_vector(REGISTER_SIZE-1 downto 0) is registers(to_integer(unsigned(REGISTER_RA)));
  alias sp  : std_logic_vector(REGISTER_SIZE-1 downto 0) is registers(to_integer(unsigned(REGISTER_SP)));
  alias gp  : std_logic_vector(REGISTER_SIZE-1 downto 0) is registers(to_integer(unsigned(REGISTER_GP)));
  alias tp  : std_logic_vector(REGISTER_SIZE-1 downto 0) is registers(to_integer(unsigned(REGISTER_TP)));
  alias t0  : std_logic_vector(REGISTER_SIZE-1 downto 0) is registers(to_integer(unsigned(REGISTER_T0)));
  alias t1  : std_logic_vector(REGISTER_SIZE-1 downto 0) is registers(to_integer(unsigned(REGISTER_T1)));
  alias t2  : std_logic_vector(REGISTER_SIZE-1 downto 0) is registers(to_integer(unsigned(REGISTER_T2)));
  alias s0  : std_logic_vector(REGISTER_SIZE-1 downto 0) is registers(to_integer(unsigned(REGISTER_S0)));
  alias s1  : std_logic_vector(REGISTER_SIZE-1 downto 0) is registers(to_integer(unsigned(REGISTER_S1)));
  alias a0  : std_logic_vector(REGISTER_SIZE-1 downto 0) is registers(to_integer(unsigned(REGISTER_A0)));
  alias a1  : std_logic_vector(REGISTER_SIZE-1 downto 0) is registers(to_integer(unsigned(REGISTER_A1)));
  alias a2  : std_logic_vector(REGISTER_SIZE-1 downto 0) is registers(to_integer(unsigned(REGISTER_A2)));
  alias a3  : std_logic_vector(REGISTER_SIZE-1 downto 0) is registers(to_integer(unsigned(REGISTER_A3)));
  alias a4  : std_logic_vector(REGISTER_SIZE-1 downto 0) is registers(to_integer(unsigned(REGISTER_A4)));
  alias a5  : std_logic_vector(REGISTER_SIZE-1 downto 0) is registers(to_integer(unsigned(REGISTER_A5)));
  alias a6  : std_logic_vector(REGISTER_SIZE-1 downto 0) is registers(to_integer(unsigned(REGISTER_A6)));
  alias a7  : std_logic_vector(REGISTER_SIZE-1 downto 0) is registers(to_integer(unsigned(REGISTER_A7)));
  alias s2  : std_logic_vector(REGISTER_SIZE-1 downto 0) is registers(to_integer(unsigned(REGISTER_S2)));
  alias s3  : std_logic_vector(REGISTER_SIZE-1 downto 0) is registers(to_integer(unsigned(REGISTER_S3)));
  alias s4  : std_logic_vector(REGISTER_SIZE-1 downto 0) is registers(to_integer(unsigned(REGISTER_S4)));
  alias s5  : std_logic_vector(REGISTER_SIZE-1 downto 0) is registers(to_integer(unsigned(REGISTER_S5)));
  alias s6  : std_logic_vector(REGISTER_SIZE-1 downto 0) is registers(to_integer(unsigned(REGISTER_S6)));
  alias s7  : std_logic_vector(REGISTER_SIZE-1 downto 0) is registers(to_integer(unsigned(REGISTER_S7)));
  alias s8  : std_logic_vector(REGISTER_SIZE-1 downto 0) is registers(to_integer(unsigned(REGISTER_S8)));
  alias s9  : std_logic_vector(REGISTER_SIZE-1 downto 0) is registers(to_integer(unsigned(REGISTER_S9)));
  alias s10 : std_logic_vector(REGISTER_SIZE-1 downto 0) is registers(to_integer(unsigned(REGISTER_S10)));
  alias s11 : std_logic_vector(REGISTER_SIZE-1 downto 0) is registers(to_integer(unsigned(REGISTER_S11)));
  alias t3  : std_logic_vector(REGISTER_SIZE-1 downto 0) is registers(to_integer(unsigned(REGISTER_T3)));
  alias t4  : std_logic_vector(REGISTER_SIZE-1 downto 0) is registers(to_integer(unsigned(REGISTER_T4)));
  alias t5  : std_logic_vector(REGISTER_SIZE-1 downto 0) is registers(to_integer(unsigned(REGISTER_T5)));
  alias t6  : std_logic_vector(REGISTER_SIZE-1 downto 0) is registers(to_integer(unsigned(REGISTER_T6)));
begin

  bypass_gen : if not WRITE_FIRST_SMALL_RAMS generate
    signal out1               : std_logic_vector(REGISTER_SIZE-1 downto 0);
    signal out2               : std_logic_vector(REGISTER_SIZE-1 downto 0);
    signal out3               : std_logic_vector(REGISTER_SIZE-1 downto 0);
    signal read_during_write1 : std_logic;
    signal read_during_write2 : std_logic;
    signal read_during_write3 : std_logic;
    signal wb_data_latched    : std_logic_vector(REGISTER_SIZE-1 downto 0);
  begin

    process (clk) is
    begin
      if rising_edge(clk) then
        out1 <= registers(to_integer(unsigned(rs1_select)));
        out2 <= registers(to_integer(unsigned(rs2_select)));
        out3 <= registers(to_integer(unsigned(rs3_select)));
        if wb_enable = '1' then
          registers(to_integer(unsigned(wb_select))) <= wb_data;
        end if;
        if wb2_enable = '1' then
          registers(to_integer(unsigned(wb2_select))) <= fpau_data_out2;
        end if;
      end if;
    end process;

    rs1_data_fpau <= registers(to_integer(unsigned(rs1_select)));
    rs2_data_fpau <= registers(to_integer(unsigned(rs2_select)));
    rs3_data_fpau <= registers(to_integer(unsigned(rs3_select)));

    --read during write logic
    rs1_data <= wb_data_latched when read_during_write1 = '1' else out1;
    rs2_data <= wb_data_latched when read_during_write2 = '1' else out2;
    rs3_data <= (others => '-') when READ_PORTS < 3 else
                wb_data_latched when read_during_write3 = '1' else out3;
    process(clk) is
    begin
      if rising_edge(clk) then
        read_during_write3 <= '0';
        read_during_write2 <= '0';
        read_during_write1 <= '0';
        if rs1_select = wb_select and wb_enable = '1' then
          read_during_write1 <= '1';
        end if;
        if rs2_select = wb_select and wb_enable = '1' then
          read_during_write2 <= '1';
        end if;
        if rs3_select = wb_select and wb_enable = '1' then
          read_during_write3 <= '1';
        end if;
        wb_data_latched <= wb_data;
      end if;
    end process;
  end generate bypass_gen;

  write_first_gen : if WRITE_FIRST_SMALL_RAMS generate
    -- process to delay FPAU writeback signals in order to write 2nd output in subsequent clock cycle (goal is to keep RAM inference):
    process (clk) is
    begin
      if rising_edge(clk) then
        --wb2_select_delay <= wb2_select;
        --wb2_enable_delay <= wb2_enable;
        --wb_data_delay    <= fpau_data_out2;
        wb2_select_delay <= wb_select;
        wb2_enable_delay <= wb2_enable;
        wb_data_delay    <= wb_data;
      end if;
    end process;
    --writeback_select <= wb2_select_delay when wb2_enable_delay = '1' else wb_select;
    --writeback_data   <= wb_data_delay when wb2_enable_delay = '1' else wb_data;
    --writeback_enable <= wb_enable or wb2_enable_delay;
    writeback_select <= wb2_select_delay when wb2_enable_delay = '1' else
                        wb2_select when wb2_enable = '1' else 
                        wb_select;
    writeback_data   <= wb_data_delay when wb2_enable_delay = '1' else
                        fpau_data_out2 when wb2_enable = '1' else
                        wb_data;
    writeback_enable <= wb_enable or wb2_enable_delay;

    process (clk, rs1_select, rs2_select, rs3_select) is
    begin
      if rising_edge(clk) then
        if writeback_enable = '1' then
          registers_variable(to_integer(unsigned(writeback_select))) := writeback_data;
        end if;
        rs1_data <= registers_variable(to_integer(unsigned(rs1_select)));
        rs2_data <= registers_variable(to_integer(unsigned(rs2_select)));
        rs3_data <= registers_variable(to_integer(unsigned(rs3_select)));
      end if;
      rs1_data_fpau <= registers_variable(to_integer(unsigned(rs1_select)));
      rs2_data_fpau <= registers_variable(to_integer(unsigned(rs2_select)));
      rs3_data_fpau <= registers_variable(to_integer(unsigned(rs3_select)));
    end process;

    process (clk) is
    begin
      if rising_edge(clk) then
        --Vivado simulator doesn't like tracing variables so this signal
        --duplicates the register_file variable
        if wb_enable = '1' then
          registers(to_integer(unsigned(wb_select))) <= wb_data;
        end if;
        if wb2_enable = '1' then
          registers(to_integer(unsigned(wb2_select))) <= fpau_data_out2;
        end if;
      end if;
    end process;
  end generate write_first_gen;

end architecture;
