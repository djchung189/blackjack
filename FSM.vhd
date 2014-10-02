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

--		redLEDs   : OUT STD_LOGIC_VECTOR(17 DOWNTO 0);
		LEDG_TEST : out std_LOGIC;
		greenLEDs : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
end entity;

architecture BEHAVIOURAL of FSM is
	--type state_type is (Idle, player_1, dealer_1, player_2, player_3_hit, player_4_hit, dealer_2, dealer_3_hit, 
	--	dealer_4_hit, player_win, both_bust,dealer_win, end_game);
		
	--signal PRESENT_STATE : state_type := IDLE;
	signal resetsignal : std_LOGIC;
	
	signal nextStep_sig: std_LOGIC;
	
	signal button_STATE:  STD_LOGIC_VECTOR(2 DOWNTO 0):= "000";
	
		
begin
	resetsignal<=reset;

--	process(clock)
--	begin 
--		if(button_STATE="000")then
--			nextStep_sig <='1';
--			if(nextStep='0')then
--				button_STATE<="001";
--			end if;
--			LEDG_TEST <= '1';
--		elsif (button_STATE="001")then
--			nextStep_sig <='1';
--			if(nextStep='1')then
--				button_STATE<="010";
--			end if;
--			LEDG_TEST <= '1';
--		elsif (button_STATE="010")then
--			nextStep_sig <='0';----------------------
--			button_STATE<="011";
--			LEDG_TEST <= '0';
--		elsif (button_STATE="011")then
--			nextStep_sig <='1';--
--			button_STATE<="100";
--			LEDG_TEST <= '1';
--		else
--			nextStep_sig<='1';--
--			if(nextStep='0')then--
--				button_STATE<="000";--
--			end if;--
--			--button_STATE<="000";
--			LEDG_TEST <= '1';
--		end if;
--	end process;	

	process(clock)
	begin 
		if(button_STATE="000")then
			nextStep_sig <='1';
			if(nextStep='0')then
				button_STATE<="001";
			else
				button_STATE<="000";
			end if;
			LEDG_TEST <= '1';
		elsif (button_STATE="001")then
			nextStep_sig <='1';
			LEDG_TEST <= '0';
			if(nextStep='1')then
				button_STATE<="010";
			else
				button_STATE<="001";
			end if;
			
		elsif (button_STATE="010")then
			nextStep_sig <='0';----------------------
			button_STATE<="011";
			LEDG_TEST <= '1';
		elsif (button_STATE="011")then
			nextStep_sig <='0';--
			button_STATE<="100";
			LEDG_TEST <= '1';
		elsif (button_STATE="100")then
			nextStep_sig <='0';--
			button_STATE<="101";
			LEDG_TEST <= '1';
		else
			nextStep_sig<='0';--
			button_STATE<="000";
			LEDG_TEST <= '1';
		end if;
	end process;
	
	
	process (nextStep_sig ,resetsignal)
			type state_type is (Idle, player_1, dealer_1, player_2, player_3_hit, player_4_hit, dealer_2, dealer_3_hit, 
				dealer_4_hit, player_win, both_bust,dealer_win, end_game);	
			variable PRESENT_STATE : state_type := IDLE;
			variable NEXT_STATE : state_type;
	begin
		if(resetsignal = '0') then
			PRESENT_STATE := idle; 
--			greenLEDs<="00000001";
--			redLEDs<="000000000000000000";
		elsif(rising_edge(nextStep_sig)) then
			 case PRESENT_STATE is 
				when idle => NEXT_STATE := player_1; --redLEDs<="000000000000000001";
				when player_1 => NEXT_STATE := dealer_1;-- redLEDs<="000000000000000011";
				when dealer_1 => NEXT_STATE := player_2;-- redLEDs<="000000000000000111";
				when player_2 =>if(playerStands='0') then
											NEXT_STATE := player_3_hit;-- redLEDs<="000000000000001111";
									elsif(playerStands='1')then
											NEXT_STATE := dealer_2;-- redLEDs<="000000000000011111";
									end if;
				when player_3_hit => if( playerStands='0' and playerBust='0' ) then
												nexT_STATE := player_4_hit; --redLEDs<="000000000000111111";
											elsif(playerStands= '1' and playerBust ='0')then
												nexT_STATE := dealer_2; --redLEDs<="000000000001111111";
											elsif(playerBust ='1')then
												next_STATE := dealer_2; --redLEDs<="000000000011111111";
											end if;
				when player_4_hit => NEXT_STATE := dealer_2; --redLEDs<="000000000000000010";
				when dealer_2 =>if(dealerStands='0') then
										nexT_STATE := dealer_3_hit;  ---redLEDs<="000000000000000110";
									elsif(dealerStands='1' and dealerWins='1')then
										nexT_STATE := dealer_win; --redLEDs<="000000000000001110";
									elsif(dealerStands='1' and playerWins='1')then
										nexT_STATE := player_win; --redLEDs<="000000000000011110";
									end if;
				when others => NEXT_STATE := idle;
			end case;
			
			PRESENT_STATE := NEXT_STATE;
			
			case NEXT_STATE is 
				when idle => greenLEDs<="00000001";
				when player_1 => greenLEDs<="00000011";
				when dealer_1 => greenLEDs<="00000111";
				when player_2 => greenLEDs<="00001111";
				when player_3_hit=> greenLEDs<="00011111";
				when player_4_hit=> greenLEDs<="00111111";
				when dealer_2=> greenLEDs<="01111111";
				when others => greenLEDs<="11111111";
			end case;
			
--			If(PRESENT_STATE=idle)then --deal card to player
--				
--				greenLEDs<="00000011";
--
--			elsif(PRESENT_STATE=player_1)then--deal card to dealer
--				PRESENT_STATE <= dealer_1;
--				greenLEDs<="00000111";
--
--			elsif(PRESENT_STATE=dealer_1)then-- deal card to player and check if it should proceed to next stage
--				PRESENT_STATE <= player_2;
--				greenLEDs<="00001111";
					
	--			greenLEDs<="00000010";
--			elsif(PRESENT_STATE=player_2)then
--				if(nextStep_sig='0' and playerStands='0') then
--					PRESENT_STATE <= player_3_hit;
--				elsif(nextStep_sig='0' and playerStands='1')then
--					PRESENT_STATE <= dealer_2;
--				else
--					PRESENT_STATE <= player_2;
--				end if;
----				greenLEDs<="00000011";
--			elsif(PRESENT_STATE=player_3_hit)then
--				if(nextStep_sig='0' and playerStands='0' and playerBust='0' ) then--
--					PRESENT_STATE <= player_4_hit;
--				elsif(nextStep_sig='0')then
--					if(playerStands='1')then
--						PRESENT_STATE <= dealer_2;
--					elsif(playerBust = '1')then
--						PRESENT_STATE <= dealer_2;
--					end if;
--				else
--					PRESENT_STATE <= player_3_hit;
--				end if;
--			
--			elsif(PRESENT_STATE=player_4_hit)then
--				if(nextStep_sig='0') then
--					PRESENT_STATE <= dealer_2;
--				else
--					PRESENT_STATE <= player_4_hit;
--				end if;
--			
--			elsif(PRESENT_STATE=dealer_2)then
--				if(nextStep_sig='0' and dealerStands='0') then
--					PRESENT_STATE <= dealer_3_hit;
--				elsif(nextStep_sig='0' and dealerStands='1' and dealerWins='1')then
--					PRESENT_STATE <= dealer_win;
--				elsif(nextStep_sig='0' and dealerStands='1' and playerWins='1')then
--					PRESENT_STATE <= player_win;
--				else
--					PRESENT_STATE <= dealer_2;
--				end if;
--			
--			elsif(PRESENT_STATE=dealer_3_hit)then
--				if(nextStep_sig='0' and dealerStands='0') then
--					PRESENT_STATE <= dealer_4_hit;
--				elsif(nextStep_sig='0' and dealerStands='1' and dealerWins='1')then
--					PRESENT_STATE <= dealer_win;
--				else
--					PRESENT_STATE <= dealer_3_hit;
--				end if;
--			
--			
--			elsif(PRESENT_STATE=dealer_4_hit)then
--				if(nextStep_sig='0' and dealerWins='1') then
--					PRESENT_STATE <= dealer_win;
--				elsif(nextStep_sig='0' and playerWins='1')then
--					PRESENT_STATE <= player_win;
--				elsif(nextStep_sig='0' and playerBust='1' and dealerbust ='1')then
--					PRESENT_STATE <= both_bust;
--				else
--					PRESENT_STATE <= dealer_4_hit;
--				end if;
--				
--			elsif(PRESENT_STATE=player_win)then
--					PRESENT_STATE <= end_game;
--				
--			elsif(PRESENT_STATE=both_bust)then
--				PRESENT_STATE <= end_game;
--				
--				
--			elsif(PRESENT_STATE=dealer_win)then
--				PRESENT_STATE <= end_game;
--				
--				
--			elsif(PRESENT_STATE=end_game)then
--				PRESENT_STATE <= end_game;
--			end IF;
		end If;
		
		--
		--
	end process;
	
--	process (clock ,resetsignal)
--	begin
--		if(resetsignal = '0') then
--			PRESENT_STATE <= idle;
--		elsif(rising_edge(clock)) then
--			If(PRESENT_STATE=idle)then --deal card to player
--				if(nextStep_sig='0')then
--					PRESENT_STATE <= player_1;
--				else
--					PRESENT_STATE <= idle;
--				end if;
----				greenLEDs<="00000000";
--			elsif(PRESENT_STATE=player_1)then--deal card to dealer
--				
--				if(nextStep_sig='0') then
--					PRESENT_STATE <= dealer_1;
--				else
--					PRESENT_STATE <= player_1;
--				end if;
----				greenLEDs<="00000001";
--			elsif(PRESENT_STATE=dealer_1)then-- deal card to player and check if it should proceed to next stage
--				if(nextStep_sig='0') then
--					PRESENT_STATE <= player_2;
--				else
--					PRESENT_STATE <= dealer_1;
--				end if;
--	--			greenLEDs<="00000010";
--			elsif(PRESENT_STATE=player_2)then
--				if(nextStep_sig='0' and playerStands='0') then
--					PRESENT_STATE <= player_3_hit;
--				elsif(nextStep_sig='0' and playerStands='1')then
--					PRESENT_STATE <= dealer_2;
--				else
--					PRESENT_STATE <= player_2;
--				end if;
----				greenLEDs<="00000011";
--			elsif(PRESENT_STATE=player_3_hit)then
--				if(nextStep_sig='0' and playerStands='0' and playerBust='0' ) then--
--					PRESENT_STATE <= player_4_hit;
--				elsif(nextStep_sig='0')then
--					if(playerStands='1')then
--						PRESENT_STATE <= dealer_2;
--					elsif(playerBust = '1')then
--						PRESENT_STATE <= dealer_2;
--					end if;
--				else
--					PRESENT_STATE <= player_3_hit;
--				end if;
--			
--			elsif(PRESENT_STATE=player_4_hit)then
--				if(nextStep_sig='0') then
--					PRESENT_STATE <= dealer_2;
--				else
--					PRESENT_STATE <= player_4_hit;
--				end if;
--			
--			elsif(PRESENT_STATE=dealer_2)then
--				if(nextStep_sig='0' and dealerStands='0') then
--					PRESENT_STATE <= dealer_3_hit;
--				elsif(nextStep_sig='0' and dealerStands='1' and dealerWins='1')then
--					PRESENT_STATE <= dealer_win;
--				elsif(nextStep_sig='0' and dealerStands='1' and playerWins='1')then
--					PRESENT_STATE <= player_win;
--				else
--					PRESENT_STATE <= dealer_2;
--				end if;
--			
--			elsif(PRESENT_STATE=dealer_3_hit)then
--				if(nextStep_sig='0' and dealerStands='0') then
--					PRESENT_STATE <= dealer_4_hit;
--				elsif(nextStep_sig='0' and dealerStands='1' and dealerWins='1')then
--					PRESENT_STATE <= dealer_win;
--				else
--					PRESENT_STATE <= dealer_3_hit;
--				end if;
--			
--			
--			elsif(PRESENT_STATE=dealer_4_hit)then
--				if(nextStep_sig='0' and dealerWins='1') then
--					PRESENT_STATE <= dealer_win;
--				elsif(nextStep_sig='0' and playerWins='1')then
--					PRESENT_STATE <= player_win;
--				elsif(nextStep_sig='0' and playerBust='1' and dealerbust ='1')then
--					PRESENT_STATE <= both_bust;
--				else
--					PRESENT_STATE <= dealer_4_hit;
--				end if;
--				
--			elsif(PRESENT_STATE=player_win)then
--					PRESENT_STATE <= end_game;
--				
--			elsif(PRESENT_STATE=both_bust)then
--				PRESENT_STATE <= end_game;
--				
--				
--			elsif(PRESENT_STATE=dealer_win)then
--				PRESENT_STATE <= end_game;
--				
--				
--			elsif(PRESENT_STATE=end_game)then
--				PRESENT_STATE <= end_game;
--			end IF;
--		end If;
--		
--		--
--		--
--	end process;
	
--	process(PRESENT_STATE)
--	begin
--		If(PRESENT_STATE=idle)then
--			newPlayerCards <="0000";
--			newDealerCards <="0000";
--
--			redLEDs   <="000000000000000001";
--			greenLEDs <="00000000";
--		elsif(PRESENT_STATE=player_1)then 
--			newPlayerCards <= "0001";
--			redLEDs   <="000000000000000011";
--		elsif(PRESENT_STATE=dealer_1)then 
--			newDealerCards <= "0001";
--			redLEDs   <="000000000000000111";
----		elsif(PRESENT_STATE=player_2)then 
----			newPlayerCards <= "0011";
----			redLEDs   <="000000000000001111";
----		elsif(PRESENT_STATE=player_3_hit)then 
----			newPlayerCards <= "0111";
----			redLEDs   <="000000000000011111";
----		elsif(PRESENT_STATE=player_4_hit)then 
----			newPlayerCards <= "1111";
----			redLEDs   <="000000000000111111";
----		elsif(PRESENT_STATE=dealer_2)then
----			newDealerCards <= "0011";
----			redLEDs   <="000000000001111111";
----		elsif(PRESENT_STATE=dealer_3_hit)then
----			newDealerCards <= "0111";
----			redLEDs   <="000000000011111111";
----		elsif(PRESENT_STATE=dealer_4_hit)then
----			newDealerCards <= "1111";
----			redLEDs   <="000000000111111111";
----		elsif(PRESENT_STATE=player_win)then 
----			greenLEDs<="11111111";
----			redLEDs   <="000000001111111111";
----		elsif(PRESENT_STATE=both_bust)then
----			greenLEDs<="11111111";
----			redLEDs   <="000000011111111111";
----			redLeds<="111111111111111111";
----		elsif(PRESENT_STATE=dealer_win)then 
----			redLeds<="111111111111111111";
----		elsif(PRESENT_STATE=end_game)then 
--		else		
--		end if;
--	end process;
end behAVIOURAL;

