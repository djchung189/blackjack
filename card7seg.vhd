library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity Card7Seg is
	port(
		SW : IN  STD_LOGIC_VECTOR(15 DOWNTO 0); -- value of card
		dealercard : IN  STD_LOGIC_VECTOR(15 DOWNTO 0); -- value of card
	   HEX0 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);  -- 7-seg LED pattern
		HEX1 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);  -- 7-seg LED pattern
		HEX2 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);  -- 7-seg LED pattern
		HEX3 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);  -- 7-seg LED pattern
		HEX4 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);  -- 7-seg LED pattern
		HEX5 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);  -- 7-seg LED pattern
		HEX6 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);  -- 7-seg LED pattern
		HEX7 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0)  -- 7-seg LED pattern
	);
end entity;

architecture Behaviour of Card7Seg is
	signal seg0: STD_LOGIC_VECTOR(3 DOWNTO 0);
	signal seg1: STD_LOGIC_VECTOR(3 DOWNTO 0);
	signal seg2: STD_LOGIC_VECTOR(3 DOWNTO 0);
	signal seg3: STD_LOGIC_VECTOR(3 DOWNTO 0);
	signal seg4: STD_LOGIC_VECTOR(3 DOWNTO 0);
	signal seg5: STD_LOGIC_VECTOR(3 DOWNTO 0);
	signal seg6: STD_LOGIC_VECTOR(3 DOWNTO 0);
	signal seg7: STD_LOGIC_VECTOR(3 DOWNTO 0);
begin
	seg0 <= SW(3 downto 0);
	seg1 <= SW(7 downto 4);
	seg2 <= SW(11 downto 8);
	seg3 <= SW(15 downto 12);
	
	seg4 <= dealercard(3 downto 0);
	seg5 <= dealercard(7 downto 4);
	seg6 <= dealercard(11 downto 8);
	seg7 <= dealercard(15 downto 12);
	process(Seg0)
	begin
		case seg0 is
			when "0000" => HEX0 <= "1111111"; --no card
			when "0001" => HEX0 <= "0001000"; --ace "A"
			when "0010" => HEX0 <= "0100100"; --2
			when "0011" => HEX0 <= "0110000"; --3
			when "0100" => HEX0 <= "0011001"; --4
			when "0101" => HEX0 <= "0010010"; --5
			when "0110" => HEX0 <= "0000010"; --6
			when "0111" => HEX0 <= "1111000"; --7
			when "1000" => HEX0 <= "0000000"; --8
			when "1001" => HEX0 <= "0010000"; --9
			when "1010" => HEX0 <= "1000000"; --10 "0"
			when "1011" => HEX0 <= "1100000"; --Jack "J"
			when "1100" => HEX0 <= "0011000"; --Queen "q"
			when others => HEX0 <= "0001001"; --King "H"
		end case;
	end process;
	
	process(Seg1)
	begin
		case seg1 is
			when "0000" => HEX1 <= "1111111"; --no card
			when "0001" => HEX1 <= "0001000"; --ace "A"
			when "0010" => HEX1 <= "0100100"; --2
			when "0011" => HEX1 <= "0110000"; --3
			when "0100" => HEX1 <= "0011001"; --4
			when "0101" => HEX1 <= "0010010"; --5
			when "0110" => HEX1 <= "0000010"; --6
			when "0111" => HEX1 <= "1111000"; --7
			when "1000" => HEX1 <= "0000000"; --8
			when "1001" => HEX1 <= "0010000"; --9
			when "1010" => HEX1 <= "1000000"; --10 "0"
			when "1011" => HEX1 <= "1100000"; --Jack "J"
			when "1100" => HEX1 <= "0011000"; --Queen "q"
			when others => HEX1 <= "0001001"; --King "H"
		end case;
	end process;
	
	process(Seg2)
	begin
		case seg2 is
			when "0000" => HEX2 <= "1111111"; --no card
			when "0001" => HEX2 <= "0001000"; --ace "A"
			when "0010" => HEX2 <= "0100100"; --2
			when "0011" => HEX2 <= "0110000"; --3
			when "0100" => HEX2 <= "0011001"; --4
			when "0101" => HEX2 <= "0010010"; --5
			when "0110" => HEX2 <= "0000010"; --6
			when "0111" => HEX2 <= "1111000"; --7
			when "1000" => HEX2 <= "0000000"; --8
			when "1001" => HEX2 <= "0010000"; --9
			when "1010" => HEX2 <= "1000000"; --10 "0"
			when "1011" => HEX2 <= "1100000"; --Jack "J"
			when "1100" => HEX2 <= "0011000"; --Queen "q"
			when others => HEX2 <= "0001001"; --King "H"
		end case;
	end process;
	
	process(Seg3)
	begin
		case seg3 is
			when "0000" => HEX3 <= "1111111"; --no card
			when "0001" => HEX3 <= "0001000"; --ace "A"
			when "0010" => HEX3 <= "0100100"; --2
			when "0011" => HEX3 <= "0110000"; --3
			when "0100" => HEX3 <= "0011001"; --4
			when "0101" => HEX3 <= "0010010"; --5
			when "0110" => HEX3 <= "0000010"; --6
			when "0111" => HEX3 <= "1111000"; --7
			when "1000" => HEX3 <= "0000000"; --8
			when "1001" => HEX3 <= "0010000"; --9
			when "1010" => HEX3 <= "1000000"; --10 "0"
			when "1011" => HEX3 <= "1100000"; --Jack "J"
			when "1100" => HEX3 <= "0011000"; --Queen "q"
			when others => HEX3 <= "0001001"; --King "H"
		end case;
	end process;
	
		process(Seg4)
		begin
			case seg4 is
				when "0000" => HEX4 <= "1111111"; --no card
				when "0001" => HEX4 <= "0001000"; --ace "A"
				when "0010" => HEX4 <= "0100100"; --2
				when "0011" => HEX4 <= "0110000"; --3
				when "0100" => HEX4 <= "0011001"; --4
				when "0101" => HEX4 <= "0010010"; --5
				when "0110" => HEX4 <= "0000010"; --6
				when "0111" => HEX4 <= "1111000"; --7
				when "1000" => HEX4 <= "0000000"; --8
				when "1001" => HEX4 <= "0010000"; --9
				when "1010" => HEX4 <= "1000000"; --10 "0"
				when "1011" => HEX4 <= "1100000"; --Jack "J"
				when "1100" => HEX4 <= "0011000"; --Queen "q"
				when others => HEX4 <= "0001001"; --King "H"
		end case;
	end process;
	
	process(Seg5)
	begin
		case seg5 is
			when "0000" => HEX5 <= "1111111"; --no card
			when "0001" => HEX5 <= "0001000"; --ace "A"
			when "0010" => HEX5 <= "0100100"; --2
			when "0011" => HEX5 <= "0110000"; --3
			when "0100" => HEX5 <= "0011001"; --4
			when "0101" => HEX5 <= "0010010"; --5
			when "0110" => HEX5 <= "0000010"; --6
			when "0111" => HEX5 <= "1111000"; --7
			when "1000" => HEX5 <= "0000000"; --8
			when "1001" => HEX5 <= "0010000"; --9
			when "1010" => HEX5 <= "1000000"; --10 "0"
			when "1011" => HEX5 <= "1100000"; --Jack "J"
			when "1100" => HEX5 <= "0011000"; --Queen "q"
			when others => HEX5 <= "0001001"; --King "H"
		end case;
	end process;
	
	process(Seg6)
	begin
		case seg6 is
			when "0000" => HEX6 <= "1111111"; --no card
			when "0001" => HEX6 <= "0001000"; --ace "A"
			when "0010" => HEX6 <= "0100100"; --2
			when "0011" => HEX6 <= "0110000"; --3
			when "0100" => HEX6 <= "0011001"; --4
			when "0101" => HEX6 <= "0010010"; --5
			when "0110" => HEX6 <= "0000010"; --6
			when "0111" => HEX6 <= "1111000"; --7
			when "1000" => HEX6 <= "0000000"; --8
			when "1001" => HEX6 <= "0010000"; --9
			when "1010" => HEX6 <= "1000000"; --10 "0"
			when "1011" => HEX6 <= "1100000"; --Jack "J"
			when "1100" => HEX6 <= "0011000"; --Queen "q"
			when others => HEX6 <= "0001001"; --King "H"
		end case;
	end process;
	
	process(Seg7)
	begin
		case seg7 is
			when "0000" => HEX7 <= "1111111"; --no card
			when "0001" => HEX7 <= "0001000"; --ace "A"
			when "0010" => HEX7 <= "0100100"; --2
			when "0011" => HEX7 <= "0110000"; --3
			when "0100" => HEX7 <= "0011001"; --4
			when "0101" => HEX7 <= "0010010"; --5
			when "0110" => HEX7 <= "0000010"; --6
			when "0111" => HEX7 <= "1111000"; --7
			when "1000" => HEX7 <= "0000000"; --8
			when "1001" => HEX7 <= "0010000"; --9
			when "1010" => HEX7 <= "1000000"; --10 "0"
			when "1011" => HEX7 <= "1100000"; --Jack "J"
			when "1100" => HEX7 <= "0011000"; --Queen "q"
			when others => HEX7 <= "0001001"; --King "H"
		end case;
	end process;
	
end Behaviour;
