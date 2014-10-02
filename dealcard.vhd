library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity DealCard is
	port(
		Deal			: IN  std_logic; 
		Clock			: IN STD_LOGIC;
		Reset			: IN STD_LOGIC;
		RandomCard 		: OUT  STD_LOGIC_VECTOR(3 downto 0)
	);
end entity;

architecture Behaviour of DealCard is

signal tempcard: unsigned(3 downto 0):="0001";
signal Randout	: std_LOGIC_VECTOR(3 downto 0) := "0000";

begin
	
	process(clock)	
	begin
		IF(rising_edge(clock)) then	
			IF (tempcard = "1101")then
				tempcard <= "0001";
			else
				tempcard <= tempcard + "0001";
			end IF;
		end IF;
		
		
	end process;
	
	process(deal, Randout, reset)
	begin	
		IF(Deal='1' and Randout = "0000")then
			Randout <= std_logic_vector(tempcard);
		ELSIF( reset = '0') THEn
			Randout <= "0000";
		end IF;

	end process;
	
	RandomCard <= Randout;
	
end Behaviour;
