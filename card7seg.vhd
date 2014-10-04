library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity Card7Seg is
	port(
		playercards : IN  STD_LOGIC_VECTOR(15 DOWNTO 0); -- value of card
		dealercards : IN  STD_LOGIC_VECTOR(15 DOWNTO 0); -- value of card
	   disp0 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);  -- 7-seg LED pattern
		disp1 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);  -- 7-seg LED pattern
		disp2 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);  -- 7-seg LED pattern
		disp3 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);  -- 7-seg LED pattern
		disp4 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);  -- 7-seg LED pattern
		disp5 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);  -- 7-seg LED pattern
		disp6 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);  -- 7-seg LED pattern
		disp7 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0)  -- 7-seg LED pattern
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
	seg0 <= playercards(3 downto 0);
	seg1 <= playercards(7 downto 4);
	seg2 <= playercards(11 downto 8);
	seg3 <= playercards(15 downto 12);
	
	seg4 <= dealercards(3 downto 0);
	seg5 <= dealercards(7 downto 4);
	seg6 <= dealercards(11 downto 8);
	seg7 <= dealercards(15 downto 12);
	process(Seg0)
	begin
		case seg0 is
			when "0000" => disp0 <= "1111111"; --no card
			when "0001" => disp0 <= "0001000"; --ace "A"
			when "0010" => disp0 <= "0100100"; --2
			when "0011" => disp0 <= "0110000"; --3
			when "0100" => disp0 <= "0011001"; --4
			when "0101" => disp0 <= "0010010"; --5
			when "0110" => disp0 <= "0000010"; --6
			when "0111" => disp0 <= "1111000"; --7
			when "1000" => disp0 <= "0000000"; --8
			when "1001" => disp0 <= "0010000"; --9
			when "1010" => disp0 <= "1000000"; --10 "0"
			when "1011" => disp0 <= "1100000"; --Jack "J"
			when "1100" => disp0 <= "0011000"; --Queen "q"
			when others => disp0 <= "0001001"; --King "H"
		end case;
	end process;
	
	process(Seg1)
	begin
		case seg1 is
			when "0000" => disp1 <= "1111111"; --no card
			when "0001" => disp1 <= "0001000"; --ace "A"
			when "0010" => disp1 <= "0100100"; --2
			when "0011" => disp1 <= "0110000"; --3
			when "0100" => disp1 <= "0011001"; --4
			when "0101" => disp1 <= "0010010"; --5
			when "0110" => disp1 <= "0000010"; --6
			when "0111" => disp1 <= "1111000"; --7
			when "1000" => disp1 <= "0000000"; --8
			when "1001" => disp1 <= "0010000"; --9
			when "1010" => disp1 <= "1000000"; --10 "0"
			when "1011" => disp1 <= "1100000"; --Jack "J"
			when "1100" => disp1 <= "0011000"; --Queen "q"
			when others => disp1 <= "0001001"; --King "H"
		end case;
	end process;
	
	process(Seg2)
	begin
		case seg2 is
			when "0000" => disp2 <= "1111111"; --no card
			when "0001" => disp2 <= "0001000"; --ace "A"
			when "0010" => disp2 <= "0100100"; --2
			when "0011" => disp2 <= "0110000"; --3
			when "0100" => disp2 <= "0011001"; --4
			when "0101" => disp2 <= "0010010"; --5
			when "0110" => disp2 <= "0000010"; --6
			when "0111" => disp2 <= "1111000"; --7
			when "1000" => disp2 <= "0000000"; --8
			when "1001" => disp2 <= "0010000"; --9
			when "1010" => disp2 <= "1000000"; --10 "0"
			when "1011" => disp2 <= "1100000"; --Jack "J"
			when "1100" => disp2 <= "0011000"; --Queen "q"
			when others => disp2 <= "0001001"; --King "H"
		end case;
	end process;
	
	process(Seg3)
	begin
		case seg3 is
			when "0000" => disp3 <= "1111111"; --no card
			when "0001" => disp3 <= "0001000"; --ace "A"
			when "0010" => disp3 <= "0100100"; --2
			when "0011" => disp3 <= "0110000"; --3
			when "0100" => disp3 <= "0011001"; --4
			when "0101" => disp3 <= "0010010"; --5
			when "0110" => disp3 <= "0000010"; --6
			when "0111" => disp3 <= "1111000"; --7
			when "1000" => disp3 <= "0000000"; --8
			when "1001" => disp3 <= "0010000"; --9
			when "1010" => disp3 <= "1000000"; --10 "0"
			when "1011" => disp3 <= "1100000"; --Jack "J"
			when "1100" => disp3 <= "0011000"; --Queen "q"
			when others => disp3 <= "0001001"; --King "H"
		end case;
	end process;
	
		process(Seg4)
		begin
			case seg4 is
				when "0000" => disp4 <= "1111111"; --no card
				when "0001" => disp4 <= "0001000"; --ace "A"
				when "0010" => disp4 <= "0100100"; --2
				when "0011" => disp4 <= "0110000"; --3
				when "0100" => disp4 <= "0011001"; --4
				when "0101" => disp4 <= "0010010"; --5
				when "0110" => disp4 <= "0000010"; --6
				when "0111" => disp4 <= "1111000"; --7
				when "1000" => disp4 <= "0000000"; --8
				when "1001" => disp4 <= "0010000"; --9
				when "1010" => disp4 <= "1000000"; --10 "0"
				when "1011" => disp4 <= "1100000"; --Jack "J"
				when "1100" => disp4 <= "0011000"; --Queen "q"
				when others => disp4 <= "0001001"; --King "H"
		end case;
	end process;
	
	process(Seg5)
	begin
		case seg5 is
			when "0000" => disp5 <= "1111111"; --no card
			when "0001" => disp5 <= "0001000"; --ace "A"
			when "0010" => disp5 <= "0100100"; --2
			when "0011" => disp5 <= "0110000"; --3
			when "0100" => disp5 <= "0011001"; --4
			when "0101" => disp5 <= "0010010"; --5
			when "0110" => disp5 <= "0000010"; --6
			when "0111" => disp5 <= "1111000"; --7
			when "1000" => disp5 <= "0000000"; --8
			when "1001" => disp5 <= "0010000"; --9
			when "1010" => disp5 <= "1000000"; --10 "0"
			when "1011" => disp5 <= "1100000"; --Jack "J"
			when "1100" => disp5 <= "0011000"; --Queen "q"
			when others => disp5 <= "0001001"; --King "H"
		end case;
	end process;
	
	process(Seg6)
	begin
		case seg6 is
			when "0000" => disp6 <= "1111111"; --no card
			when "0001" => disp6 <= "0001000"; --ace "A"
			when "0010" => disp6 <= "0100100"; --2
			when "0011" => disp6 <= "0110000"; --3
			when "0100" => disp6 <= "0011001"; --4
			when "0101" => disp6 <= "0010010"; --5
			when "0110" => disp6 <= "0000010"; --6
			when "0111" => disp6 <= "1111000"; --7
			when "1000" => disp6 <= "0000000"; --8
			when "1001" => disp6 <= "0010000"; --9
			when "1010" => disp6 <= "1000000"; --10 "0"
			when "1011" => disp6 <= "1100000"; --Jack "J"
			when "1100" => disp6 <= "0011000"; --Queen "q"
			when others => disp6 <= "0001001"; --King "H"
		end case;
	end process;
	
	process(Seg7)
	begin
		case seg7 is
			when "0000" => disp7 <= "1111111"; --no card
			when "0001" => disp7 <= "0001000"; --ace "A"
			when "0010" => disp7 <= "0100100"; --2
			when "0011" => disp7 <= "0110000"; --3
			when "0100" => disp7 <= "0011001"; --4
			when "0101" => disp7 <= "0010010"; --5
			when "0110" => disp7 <= "0000010"; --6
			when "0111" => disp7 <= "1111000"; --7
			when "1000" => disp7 <= "0000000"; --8
			when "1001" => disp7 <= "0010000"; --9
			when "1010" => disp7 <= "1000000"; --10 "0"
			when "1011" => disp7 <= "1100000"; --Jack "J"
			when "1100" => disp7 <= "0011000"; --Queen "q"
			when others => disp7 <= "0001001"; --King "H"
		end case;
	end process;
	
end Behaviour;
