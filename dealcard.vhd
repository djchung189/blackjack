library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity DealCard is
	port(
		KEY			: IN  std_logic_vector(3 downto 0); 
		Clock_50		: IN STD_LOGIC;
		RandomCard 	: OUT  STD_LOGIC_VECTOR(3 downto 0)
	);
end entity;

architecture Behaviour of DealCard is

signal tempcard: unsigned(3 downto 0):="0001";

begin
	
	process(clock_50)	
	begin
		IF(Key(0)='1')then 
			IF(rising_edge(clock_50)) then	
				IF (tempcard = "1101")then
					tempcard <= "0001";
				else
					tempcard <= tempcard + "0001";
				end IF;
			end IF;
		end IF;
	end process;
	
	process(Key(0))
	begin	
		IF(rising_edge(Key(0)))then
			RandomCard <= std_logic_vector(tempcard);
		end IF;
	end process;
end Behaviour;
