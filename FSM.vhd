library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity FSM is
	port(
		CLOCK_50 : IN STD_LOGIC;
		KEY: in std_logic_vector(3 downto 0);
		LEDR:out bit_vector(2 downto 0);
		LEDG:out bit_vector(1 downto 0);
		dealcard: out std_LOGIC_vector(1 downto 0)
	);
end entity;

architecture Behaviour of FSM is
	signal PRESENT_STATE : bit_vector( 2 downto 0 ) := "000";
	signal reset : STD_LOGIC;
	signal nextsignal : STD_LOGIC;
begin
	reset <= Key(3);
	nextsignal <= Key(0);
	
	process (nextsignal ,reset)
	begin
		if(reset = '0') then
			LEDR <= "000";
			dealcard <= "00";
			PRESENT_STATE <= "001";
		elsif(rising_edge(nextsignal)) then	
				If(PRESENT_STATE="000")then --start
						LEDR <= PRESENT_STATE;
						dealcard <= "00";
						LEDG <= "00";
						PRESENT_STATE <= "001";

				elsif(PRESENT_STATE="001")then--deal card to player
						LEDR <= PRESENT_STATE;
						dealcard <= "10";
						LEDG <= "10";
						PRESENT_STATE <= "010";
				
				elsif(PRESENT_STATE="010")then-- deal card to dealer
						LEDR <= PRESENT_STATE;
						dealcard <= "01";
						LEDG <= "01";
						PRESENT_STATE <= "011";
			
				elsif(PRESENT_STATE="011")then--deal card to player
						LEDR <= PRESENT_STATE;
						dealcard <= "10";
						LEDG <= "10";
						PRESENT_STATE <= "100";
					
			
				elsif(PRESENT_STATE="100")then-- deal card to dealer
						LEDR <= PRESENT_STATE;
						dealcard <= "01";
						LEDG <= "01";
						PRESENT_STATE <= "101";
						
				elsif(PRESENT_STATE="101")then-- deal card to dealer
						dealcard <= "00";
						LEDG <= "00";
						LEDR <= PRESENT_STATE;
				else
					LEDR <= "111";
					PRESENT_STATE <= "000";
		
				end IF;
			end if;
	end process;
end Behaviour;
