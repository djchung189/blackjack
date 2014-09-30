library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;


entity scorehand is
  port(
		CardIn   	      : in  std_logic_vector(15 downto 0);
		
      sum		         : out std_logic_vector(4 downto 0);
      Bust		         : out std_logic
		);
end scorehand;

architecture Behavioural of Scorehand is

		signal C0Ace:	std_logic;
		signal C1Ace:	std_logic;
		signal C2Ace:	std_logic;
		signal C3Ace:	std_logic;
		
		
		signal int_card0: unsigned(3 downto 0);
		signal int_card1: unsigned(3 downto 0);
		signal int_card2: unsigned(3 downto 0);
		signal int_card3: unsigned(3 downto 0);
		
		signal int_sum: unsigned(5 downto 0) := "000000";
		signal int_sum1: std_logic_vector(4 downto 0) := "00000";
		signal AceTot : unsigned(1 downto 0) := "00";
				
begin

	int_card0 <= unsigned(CardIn(3 downto 0));
	int_card1 <= unsigned(CardIn(7 downto 4));
	int_card2 <= unsigned(CardIn(11 downto 8));
	int_card3 <= unsigned(CardIn(15 downto 12));
	
	
	process( int_card0, int_card1, int_card2, int_card3 )
	  variable Temp_AceTot: unsigned(1 downto 0);
	begin
	  Temp_AceTot := "00";
	  
		if( int_card0 = "0001" ) then
			C0Ace <= '1';
			Temp_AceTot := Temp_AceTot + "1";
		else
			C0Ace <= '0';
		end if;
		
		if( int_card1 = "0001" ) then
			C1Ace <= '1';
			Temp_AceTot := Temp_AceTot + "1";
		else
			C1Ace <= '0';
		end if;
	
		if( int_card2 = "0001" ) then
			C2Ace <= '1';
			Temp_AceTot := Temp_AceTot + "1";
		else
			C2Ace <= '0';
		end if;
		
		if( int_card3 = "0001" ) then
			C3Ace <= '1';
			Temp_AceTot := Temp_AceTot + "1";
		else
			C3Ace <= '0';
		end if;	
		
		AceTot <= Temp_AceTot;
		
	end process;
	
	process( int_card0, int_card1, int_card2, int_card3, C0Ace, C1Ace, C2Ace, C3Ace )
	    variable temp_sum: unsigned(5 downto 0)  := "000000";
	begin

    temp_sum := "000000";

		if( int_card0 > "0001" ) then
			if( C0Ace = '0' ) then
				temp_sum := temp_sum + int_card0;
			end if;
		end if;
		
		if( int_card1 > "0001" ) then
			if( C1Ace = '0' ) then
				temp_sum := temp_sum + int_card1;
			end if;
		end if;
		
		if( int_card2 > "0001" ) then
			if( C2Ace = '0' ) then
				temp_sum := temp_sum + int_card2;
			end if;
		end if;
		
		if( int_card3 > "0001" ) then
			if( C3Ace = '0' ) then
				temp_sum := temp_sum + int_card3;
			end if;
		end if;
		
		int_sum <= temp_sum;
	end process;
	
	process( int_sum, AceTot )
	begin
	  int_sum1 <= "00000";
	  
		if( AceTot = "00") then
			int_sum1 <= std_logic_vector(int_sum(4 downto 0));
		elsif( AceTot = "01" ) then
			if( int_sum <= "001010" )then
				int_sum1 <= std_logic_vector(int_sum(4 downto 0) + "01011");
			else
				int_sum1 <= std_logic_vector(int_sum(4 downto 0) + "00001");
			end if;
		elsif( AceTot = "10" ) then
			if( int_sum <= "001001" )then
				int_sum1 <= std_logic_vector(int_sum(4 downto 0) + "01100");
			else
				int_sum1 <= std_logic_vector(int_sum(4 downto 0) + "00010");
			end if;
		else 
			if( int_sum <= "001000" )then
				int_sum1 <= std_logic_vector(int_sum(4 downto 0) + "01101");
			else
				int_sum1 <= std_logic_vector(int_sum(4 downto 0) + "00011");
			end if;			
		end if;
	end process;	
	
	process( int_sum1 )
	begin
		if( int_sum1 > "10101" ) then
			Bust <= '1';
		else
			Bust <= '0';
		end if;
	end process;
	
	sum <= int_sum1;

end;
