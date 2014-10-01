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

		newPlayerCard : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
		newDealerCard : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);

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
begin
	resetsignal <= reset;
	nextsignal <= nextStep;
	
	process (clock ,resetsignal)
		--variable PRESENT_STATE : state_type;
		--variable PRESENT_STATE : bit_vector(2 downto 0) <= "000";
	begin
		if(reset = '0') then
			PRESENT_STATE <= idle;
		elsif(rising_edge(clock)) then
			If(PRESENT_STATE=idle)then --deal card to player
				if(nextsignal='0')then
					PRESENT_STATE <= player_1;
				else
					PRESENT_STATE <= idle;
				end if;
				
			elsif(PRESENT_STATE=player_1)then--deal card to dealer
				if(nextsignal='0') then
					PRESENT_STATE <= dealer_1;
				else
					PRESENT_STATE <= player_1;
				end if;
				
			elsif(PRESENT_STATE=dealer_1)then-- deal card to player and check if it should proceed to next stage
				if(nextsignal='0') then
					PRESENT_STATE <= player_2;
				else
					PRESENT_STATE <= dealer_1;
				end if;
				
			elsif(PRESENT_STATE=player_2)then
				if(nextsignal='0' and playerStands='0') then
					PRESENT_STATE <= player_3_hit;
				elsif(nextsignal='0' and playerStands='1')then
					PRESENT_STATE <= dealer_2;
				else
					PRESENT_STATE <= player_2;
				end if;
			
			elsif(PRESENT_STATE=player_3_hit)then
				if(nextsignal='0' and playerStands='0' and playerBust='0' ) then--
					PRESENT_STATE <= player_4_hit;
				elsif(nextsignal='0')then
					if(playerStands='1')then
						PRESENT_STATE <= dealer_2;
					elsif(playerBust = '1')then
						PRESENT_STATE <= dealer_2;
					end if;
				else
					PRESENT_STATE <= player_3_hit;
				end if;
			
			elsif(PRESENT_STATE=player_4_hit)then
				if(nextsignal='0') then
					PRESENT_STATE <= dealer_2;
				else
					PRESENT_STATE <= player_4_hit;
				end if;
			
			elsif(PRESENT_STATE=dealer_2)then
				if(nextsignal='0' and dealerStands='0') then
					PRESENT_STATE <= dealer_3_hit;
				elsif(nextsignal='0' and dealerStands='1' and dealerWins='1')then
					PRESENT_STATE <= dealer_win;
				elsif(nextsignal='0' and dealerStands='1' and playerWins='1')then
					PRESENT_STATE <= player_win;
				else
					PRESENT_STATE <= dealer_2;
				end if;
			
			elsif(PRESENT_STATE=dealer_3_hit)then
				if(nextsignal='0' and dealerStands='0') then
					PRESENT_STATE <= dealer_4_hit;
				elsif(nextsignal='0' and dealerStands='1' and dealerWins='1')then
					PRESENT_STATE <= dealer_win;
				else
					PRESENT_STATE <= dealer_3_hit;
				end if;
			
			
			elsif(PRESENT_STATE=dealer_4_hit)then
				if(nextsignal='0' and dealerWins='1') then
					PRESENT_STATE <= dealer_win;
				elsif(nextsignal='0' and playerWins='1')then
					PRESENT_STATE <= player_win;
				elsif(nextsignal='0' and playerBust='1' and dealerbust ='1')then
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
	end process;
	
	process(PRESENT_STATE)
	begin
		If(PRESENT_STATE=idle)then
			newPlayerCard <="0000";
			newDealerCard <="0000";

			redLEDs   <="000000000000000000";
			greenLEDs <="00000000";
		elsif(PRESENT_STATE=player_1)then 
			newPlayerCard <= "0001";
		elsif(PRESENT_STATE=dealer_1)then 
			newDealerCard <= "0001";
		elsif(PRESENT_STATE=player_2)then 
			newPlayerCard <= "0011";
		elsif(PRESENT_STATE=player_3_hit)then 
			newPlayerCard <= "0111";
		elsif(PRESENT_STATE=player_4_hit)then 
			newPlayerCard <= "1111";
		elsif(PRESENT_STATE=dealer_2)then
			newDealerCard <= "0011";
		elsif(PRESENT_STATE=dealer_3_hit)then
			newDealerCard <= "0111";
		elsif(PRESENT_STATE=dealer_4_hit)then
			newDealerCard <= "1111";
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
