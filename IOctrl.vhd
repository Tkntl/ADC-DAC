library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity IOctrl is

    generic (
        nbits : integer :=11);
    port (
        clk : in std_logic;
        rst_n : in std_logic;
		sel_in : in std_logic;
        addr  : out std_logic_vector(2 downto 0);
        D : in std_logic_vector(nbits downto 0);
        Q : out std_logic_vector(nbits downto 0));
end IOctrl;

architecture rtl of IOctrl is
signal sClkCntr2 : integer range 0 to 4095;
begin

data : process(rst_n, D)
begin
    if rst_n = '0' then
        Q <= (others => '0');
    else
        Q <= D;
    end if;
end process;

inputSel : process(rst_n,clk)
	variable sel_addr	 : unsigned(2 downto 0);
	variable toggle : std_logic;
begin
    if rst_n = '0' then
		  sel_addr := (others => '0');
		  toggle := '0';
	 elsif rising_edge(clk) then
		if sel_in = '0' and toggle = '0' then
			sel_addr := sel_addr + 1;
			toggle := '1';
		elsif sel_in = '1' then
			toggle := '0';
		end if;
		addr <= std_logic_vector(sel_addr);
    end if;
end process;
end rtl;
