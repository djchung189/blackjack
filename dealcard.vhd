library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity DealCard is
	port(
		DEAL			: IN std_logic;
		Clock			: IN STD_LOGIC;
		RESET			: IN STD_LOGIC;
		RandomCard 	: OUT STD_LOGIC_VECTOR(3 downto 0)
	);
end entity;

architecture Behaviour of DealCard is

signal tempcard: unsigned(3 downto 0):="0000";
signal Randout	: std_LOGIC_VECTOR(3 downto 0) := "0000";

begin
	
	process(clock, reset)	
	begin
		if( reset = '0') then
			tempcard <= "0000";
		elsif(rising_edge(clock)) then	
			IF(deal='0')then
				IF (tempcard = "1101")then
					tempcard <= "0001";
				elsif( tempcard = "0000" ) then 
					tempcard <= "0001";
				else
					tempcard <= tempcard + "0001";
				end IF;
			end if;
		end IF;
		
		
	end process;
	
	process(deal, Randout, reset)
	begin	
		IF(Deal='1' and reset = '1')then
			Randout <= std_logic_vector(tempcard);
		ELSIF( (reset = '0')  and (Deal='1')) THEn
			Randout <= "0000";
		end IF;

	end process;
	
	RandomCard <= Randout;
	--LEDR<= std_LOGIC_VECTOR(tempcard);
end Behaviour;
