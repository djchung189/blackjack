
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
	
ENTITY BlackJack IS
	PORT(
			CLOCK_50 : in std_logic; -- A 50MHz clock
	   	SW   : in  std_logic_vector(17 downto 0); -- SW(0) = player stands
			KEY  : in  std_logic_vector(3 downto 0);  -- KEY(3) reset, KEY(0) advance
			
--	   	LEDR : out std_logic_vector(17 downto 0); -- red LEDs: dealer wins
	   	LEDG : out std_logic_vector(7 downto 0);  -- green LEDs: player wins
			
			LEDG_test : out std_logic;

	   	HEX7 : out std_logic_vector(6 downto 0);  -- dealer, fourth card
	   	HEX6 : out std_logic_vector(6 downto 0);  -- dealer, third card
	   	HEX5 : out std_logic_vector(6 downto 0);  -- dealer, second card
	   	HEX4 : out std_logic_vector(6 downto 0);   -- dealer, first card

	   	HEX3 : out std_logic_vector(6 downto 0);  -- player, fourth card
	   	HEX2 : out std_logic_vector(6 downto 0);  -- player, third card
	   	HEX1 : out std_logic_vector(6 downto 0);  -- player, second card
	   	HEX0 : out std_logic_vector(6 downto 0)   -- player, first card
	);
END;


ARCHITECTURE Behavioural OF BlackJack IS

--	COMPONENT Card7Seg IS
--	PORT(
--		playercards : IN  STD_LOGIC_VECTOR(15 DOWNTO 0); -- value of card
--		dealercards : IN  STD_LOGIC_VECTOR(15 DOWNTO 0); -- value of card
--	   disp0 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);  -- 7-seg LED pattern
--		disp1 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);  -- 7-seg LED pattern
--		disp2 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);  -- 7-seg LED pattern
--		disp3 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);  -- 7-seg LED pattern
--		disp4 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);  -- 7-seg LED pattern
--		disp5 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);  -- 7-seg LED pattern
--		disp6 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);  -- 7-seg LED pattern
--		disp7 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0)  -- 7-seg LED pattern
--	);
--	END COMPONENT;
--
--	COMPONENT DataPath IS
--	PORT(
--		clock : IN STD_LOGIC;
--		reset : IN STD_LOGIC;
--
--		newPlayerCards : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
--		newDealerCards : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
--
--		playerCards : OUT STD_LOGIC_VECTOR(15 DOWNTO 0); -- player’s hand
--		dealerCards : OUT STD_LOGIC_VECTOR(15 DOWNTO 0); -- dealer’s hand
--
--		dealerStands : OUT STD_LOGIC; -- true if dealerScore >= 17
--
--		playerWins : OUT STD_LOGIC; -- true if playerScore >  dealerScore AND playerScore <= 21
--		dealerWins : OUT STD_LOGIC; -- true if dealerScore >= playerScore AND dealerScore <= 21
--
--		playerBust : OUT STD_LOGIC; -- true if playerScore > 21
--		dealerBust : OUT STD_LOGIC  -- true if dealerScore > 21
--	);
--	END COMPONENT;

	COMPONENT FSM IS
	PORT(
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
		ledG_test : out std_LOGIC;
		greenLEDs : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
	END COMPONENT;


	---- Your code goes here!
	----
		SIGNAL int_clock :  STD_LOGIC;
		SIGNAL int_reset :  STD_LOGIC;

		SIGNAL int_nextStep     :  STD_LOGIC; 
		SIGNAL int_playerStands :  STD_LOGIC; 
		SIGNAL int_dealerStands :  STD_LOGIC; 
		SIGNAL int_playerWins   :  STD_LOGIC; 
		SIGNAL int_dealerWins   :  STD_LOGIC; 
		SIGNAL int_playerBust   :  STD_LOGIC; 
		SIGNAL int_dealerBust   :  STD_LOGIC;  

		SIGNAL int_newPlayerCards :  STD_LOGIC_VECTOR(3 DOWNTO 0);
		SIGNAL int_newDealerCards :  STD_LOGIC_VECTOR(3 DOWNTO 0);

	--	SIGNAL int_redLEDs   :  STD_LOGIC_VECTOR(17 DOWNTO 0);
		SIGNAL int_greenLEDs :  STD_LOGIC_VECTOR(7 DOWNTO 0);
		
--		SIGNAL int_playercards :   STD_LOGIC_VECTOR(15 DOWNTO 0); -- value of card
--		SIGNAL int_dealercards :   STD_LOGIC_VECTOR(15 DOWNTO 0); -- value of card
--	   SIGNAL int_disp0 :  STD_LOGIC_VECTOR(6 DOWNTO 0);  -- 7-seg LED pattern
--		SIGNAL int_disp1 :  STD_LOGIC_VECTOR(6 DOWNTO 0);  -- 7-seg LED pattern
--		SIGNAL int_disp2 :  STD_LOGIC_VECTOR(6 DOWNTO 0);  -- 7-seg LED pattern
--		SIGNAL int_disp3 :  STD_LOGIC_VECTOR(6 DOWNTO 0);  -- 7-seg LED pattern
--		SIGNAL int_disp4 :  STD_LOGIC_VECTOR(6 DOWNTO 0);  -- 7-seg LED pattern
--		SIGNAL int_disp5 :  STD_LOGIC_VECTOR(6 DOWNTO 0);  -- 7-seg LED pattern
--		SIGNAL int_disp6 :  STD_LOGIC_VECTOR(6 DOWNTO 0);  -- 7-seg LED pattern
--	   SIGNAL int_disp7 :  STD_LOGIC_VECTOR(6 DOWNTO 0);  -- 7-seg LED pattern

BEGIN

	int_clock <= CLOCK_50;
	int_reset <= KEY(3);
	
	int_PlayerStands <= SW(0);
	int_nextStep <= KEY(0);
--	LEDR <= int_redLEDs;
	LEDG <= int_greenLEDs;

--	HEX7 <= int_disp7;
--	HEX6 <= int_disp6;
--	HEX5 <= int_disp5;
--	HEX4 <= int_disp4;
--
--	HEX3 <= int_disp3;
--	HEX2 <= int_disp2;
--	HEX1 <= int_disp1;
--	HEX0 <= int_disp0;	
	
	

	FSM_u0: fsm
	port map(
		clock => int_clock,
		reset => int_reset,

		nextStep => int_nextStep,
		playerStands=> int_playerStands,
		dealerStands => int_dealerStands, 
		playerWins   => int_playerWins,
		dealerWins   => int_dealerWins, 
		playerBust   => int_playerBust,
		dealerBust   => int_dealerBust,

		newplayercards => int_newPlayerCards,
		newdealercards => int_newdealercards,

	--	redLEDs   => int_redLEDs,
		greenLEDs => int_greenLEDs,
		LEDG_test => LEDG_test
	);
	
--	card7Seg_u1: card7Seg
--	port map(
--		playercards => int_playercards,
--		dealercards => int_dealercards,
--	   disp0 => int_disp0,
--		disp1 => int_disp1,
--		disp2 => int_disp2,
--		disp3 => int_disp3,
--		disp4 => int_disp4,
--		disp5 => int_disp5,
--		disp6 => int_disp6,
--		disp7 => int_disp7
--	);
--	
--	dataPath_u2: dataPath
--	port map(
--		clock => int_clock,
--		reset => int_reset,
--
--		newPlayerCards => int_newPlayerCards,
--		newDealerCards => int_newDealerCards,
--
--		playerCards => int_playercards,
--		dealerCards => int_dealercards,
--		
--		dealerStands => int_dealerStands,
--
--		playerWins => int_playerWins,
--		dealerWins => int_dealerWins,
--
--		playerBust => int_playerBust,
--		dealerBust => int_dealerBust
--	);


END Behavioural;

