library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity FSM is
	port(
		clock : IN STD_LOGIC;
		reset : IN STD_LOGIC;
		
		nextStep     : IN STD_LOGIC; -- when true, it advances game to next step
		playerStands : IN STD_LOGIC; -- true if player wants to stand
		dealerStands : IN STD_LOGIC; -- true if dealerScore >= 17
		playerWins   : IN STD_LOGIC; -- true if playerScore >  dealerScore AND playerScore <= 21
		dealerWins   : IN STD_LOGIC; -- true if dealerScore >= playerScore AND dealerScore <= 21
		playerBust   : IN STD_LOGIC; -- true if playerScore > 21
		dealerBust   : IN STD_LOGIC;  -- true if dealerScore > 21

		newPlayerCards : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
		newDealerCards : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);

		redLEDs   : OUT STD_LOGIC_VECTOR(17 DOWNTO 0);
		greenLEDs : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
end entity;

architecture BEHAVIOURAL of FSM is
	type state_type is (Idle, player_1, dealer_1, player_2, player_3_hit, player_4_hit, dealer_2, dealer_3_hit, 
		dealer_4_hit, player_win, both_bust,dealer_win, end_game);
		
	signal PRESENT_STATE : state_type;
	signal resetsignal : std_LOGIC;
	signal nextsignal : std_LOGIC;
	
	signal int_nextStep: std_LOGIC;
	
	signal button_STATE:  STD_LOGIC_VECTOR(1 DOWNTO 0);
	
		
begin
	resetsignal<=reset;
	nextsignal<=nextStep;
	
	process(clock)
	begin 
		if(button_STATE="00")then
			int_nextStep <='1';
			if(nextStep='0')then
				button_STATE<="01";
			end if;
		elsif (button_STATE="01")then
			int_nextStep <='1';
			if(nextStep='1')then
				button_STATE<="10";
			end if;
		elsif (button_STATE="10")then
			int_nextStep <='0';
			button_STATE<="11";
		else
			int_nextStep<='0';
			button_STATE<="00";
		end if;
	end process;	
	
	
	
	process (clock ,resetsignal)
	
	begin
		if(resetsignal = '0') then
			PRESENT_STATE <= idle;
		elsif(rising_edge(clock)) then
			If(PRESENT_STATE=idle)then --deal card to player
				if(int_nextStep='0')then
					PRESENT_STATE <= player_1;
				else
					PRESENT_STATE <= idle;
				end if;
--				greenLEDs<="00000000";
			elsif(PRESENT_STATE=player_1)then--deal card to dealer
				if(int_nextStep='0') then
					PRESENT_STATE <= dealer_1;
				else
					PRESENT_STATE <= player_1;
				end if;
--				greenLEDs<="00000001";
			elsif(PRESENT_STATE=dealer_1)then-- deal card to player and check if it should proceed to next stage
				if(int_nextStep='0') then
					PRESENT_STATE <= player_2;
				else
					PRESENT_STATE <= dealer_1;
				end if;
	--			greenLEDs<="00000010";
			elsif(PRESENT_STATE=player_2)then
				if(int_nextStep='0' and playerStands='0') then
					PRESENT_STATE <= player_3_hit;
				elsif(int_nextStep='0' and playerStands='1')then
					PRESENT_STATE <= dealer_2;
				else
					PRESENT_STATE <= player_2;
				end if;
--				greenLEDs<="00000011";
			elsif(PRESENT_STATE=player_3_hit)then
				if(int_nextStep='0' and playerStands='0' and playerBust='0' ) then--
					PRESENT_STATE <= player_4_hit;
				elsif(int_nextStep='0')then
					if(playerStands='1')then
						PRESENT_STATE <= dealer_2;
					elsif(playerBust = '1')then
						PRESENT_STATE <= dealer_2;
					end if;
				else
					PRESENT_STATE <= player_3_hit;
				end if;
			
			elsif(PRESENT_STATE=player_4_hit)then
				if(int_nextStep='0') then
					PRESENT_STATE <= dealer_2;
				else
					PRESENT_STATE <= player_4_hit;
				end if;
			
			elsif(PRESENT_STATE=dealer_2)then
				if(int_nextStep='0' and dealerStands='0') then
					PRESENT_STATE <= dealer_3_hit;
				elsif(int_nextStep='0' and dealerStands='1' and dealerWins='1')then
					PRESENT_STATE <= dealer_win;
				elsif(int_nextStep='0' and dealerStands='1' and playerWins='1')then
					PRESENT_STATE <= player_win;
				else
					PRESENT_STATE <= dealer_2;
				end if;
			
			elsif(PRESENT_STATE=dealer_3_hit)then
				if(int_nextStep='0' and dealerStands='0') then
					PRESENT_STATE <= dealer_4_hit;
				elsif(int_nextStep='0' and dealerStands='1' and dealerWins='1')then
					PRESENT_STATE <= dealer_win;
				else
					PRESENT_STATE <= dealer_3_hit;
				end if;
			
			
			elsif(PRESENT_STATE=dealer_4_hit)then
				if(int_nextStep='0' and dealerWins='1') then
					PRESENT_STATE <= dealer_win;
				elsif(int_nextStep='0' and playerWins='1')then
					PRESENT_STATE <= player_win;
				elsif(int_nextStep='0' and playerBust='1' and dealerbust ='1')then
					PRESENT_STATE <= both_bust;
				else
					PRESENT_STATE <= dealer_4_hit;
				end if;
				
			elsif(PRESENT_STATE=player_win)then
					PRESENT_STATE <= end_game;
				
			elsif(PRESENT_STATE=both_bust)then
				PRESENT_STATE <= end_game;
				
				
			elsif(PRESENT_STATE=dealer_win)then
				PRESENT_STATE <= end_game;
				
				
			elsif(PRESENT_STATE=end_game)then
				PRESENT_STATE <= end_game;
			end IF;
		end If;
		
		--
		--
	end process;
	
	process(PRESENT_STATE)
	begin
		If(PRESENT_STATE=idle)then
			newPlayerCards <="0000";
			newDealerCards <="0000";

			redLEDs   <="000000000000000000";
			greenLEDs <="00000000";
		elsif(PRESENT_STATE=player_1)then 
			newPlayerCards <= "0001";
		elsif(PRESENT_STATE=dealer_1)then 
			newDealerCards <= "0001";
		elsif(PRESENT_STATE=player_2)then 
			newPlayerCards <= "0011";
		elsif(PRESENT_STATE=player_3_hit)then 
			newPlayerCards <= "0111";
		elsif(PRESENT_STATE=player_4_hit)then 
			newPlayerCards <= "1111";
		elsif(PRESENT_STATE=dealer_2)then
			newDealerCards <= "0011";
		elsif(PRESENT_STATE=dealer_3_hit)then
			newDealerCards <= "0111";
		elsif(PRESENT_STATE=dealer_4_hit)then
			newDealerCards <= "1111";
		elsif(PRESENT_STATE=player_win)then 
			greenLEDs<="11111111";
		elsif(PRESENT_STATE=both_bust)then
			greenLEDs<="11111111";
			redLeds<="111111111111111111";
		elsif(PRESENT_STATE=dealer_win)then 
			redLeds<="111111111111111111";
		elsif(PRESENT_STATE=end_game)then 
		else		
		end if;
	end process;
end behAVIOURAL;

