library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

ENTITY datapath IS
	PORT(
		clock : IN STD_LOGIC;
		reset : IN STD_LOGIC;

		newPlayerCards : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
		newDealerCards : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);

		playerCards : OUT STD_LOGIC_VECTOR(15 DOWNTO 0); -- player’s hand
		dealerCards : OUT STD_LOGIC_VECTOR(15 DOWNTO 0); -- dealer’s hand

		dealerStands : OUT STD_LOGIC; -- true if dealerScore >= 17

		playerWins : OUT STD_LOGIC; -- true if playerScore >  dealerScore AND playerScore <= 21
		dealerWins : OUT STD_LOGIC; -- true if dealerScore >= playerScore AND dealerScore <= 21

		playerBust : OUT STD_LOGIC; -- true if playerScore > 21
		dealerBust : OUT STD_LOGIC  -- true if dealerScore > 21
	);
END;
	
Architecture Behavioural of datapath  is

	COMPONENT dealcard IS
	PORT(
		DEAL			: IN std_logic;
		Clock			: IN STD_LOGIC;
		RESET			: IN STD_LOGIC;
		RandomCard 	: OUT STD_LOGIC_VECTOR(3 downto 0)
	);
	END COMPONENT;
	
	COMPONENT Scorehand IS
	PORT(
		CardHand				: in  std_logic_vector(15 downto 0);
		
      sum		         : out std_logic_vector(4 downto 0);
      Bust		         : out std_logic
	);
	END COMPONENT;
	
	SIGNAL PlayerCards_INT: STD_LOGIC_VECTOR(15 downto 0);
	SIGNAL DealerCards_INT: STD_LOGIC_VECTOR(15 downto 0);
	
	SIGNAL PlayerScore: STD_LOGIC_VECTOR(4 downto 0) := "00000";
	SIGNAL DealerScore: STD_LOGIC_VECTOR(4 downto 0) := "00000";
	
	SIGNAL playerBust_INT: std_LOGIC;
	SIGNAL dealerBust_INT: STD_LOGIC;
	
	
BEGIN
	
	--Possible Players cards need to be dealt
	DC_u0: dealcard
		port map(
			Deal => newPlayerCards(0),
			clock => CLOCK,
			Reset => reset,
			RandomCard => PlayerCards_INT(3 downto 0)
		);
		
	DC_u1: dealcard
		port map(
			Deal => newPlayerCards(1),
			clock => CLOCK,
			Reset => reset,
			RandomCard => PlayerCards_INT(7 downto 4)
		);

	DC_u2: dealcard
		port map(
			Deal => newPlayerCards(2),
			clock => CLOCK,
			Reset => reset,
			RandomCard => PlayerCards_INT(11 downto 8)
		);

	DC_u3: dealcard
		port map(
			Deal => newPlayerCards(3),
			clock => CLOCK,
			Reset => reset,
			RandomCard => PlayerCards_INT(15 downto 12)
		);
	
	--Possible Dealer Cards to be dealt
	DC_u4: dealcard
		port map(
			Deal => newDealerCards(0),
			clock => CLOCK,
			Reset => reset,
			RandomCard => DealerCards_INT(3 downto 0)
		);
		
	DC_u5: dealcard
		port map(
			Deal => newDealerCards(1),
			clock => CLOCK,
			Reset => reset,
			RandomCard => DealerCards_INT(7 downto 4)
		);

	DC_u6: dealcard
		port map(
			Deal => newDealerCards(2),
			clock => CLOCK,
			Reset => reset,
			RandomCard => DealerCards_INT(11 downto 8)
		);

	DC_u7: dealcard
		port map(
			Deal => newDealerCards(3),
			clock => CLOCK,
			Reset => reset,
			RandomCard => DealerCards_INT(15 downto 12)
		);
	
	
	--Instaniate the scorehand components
	SH_u1: scorehand
		port map(
			CardHand => PlayerCards_INT,
			sum => PlayerScore,
			Bust => playerBust_INT
		);

	SH_u2: scorehand
		port map(
			CardHand => DealerCards_INT,
			sum => DealerScore,
			Bust => dealerBust_INT
		);
		
	
	--Link up INs and OUTs
	playerCards <= playerCards_INT;
	dealerCards <= dealerCards_INT;
	
	playerBust <= playerBust_INT;
	dealerBust <= dealerBust_INT;
	
	--Compute DATAPATH logic
		
	process( DealerScore )
	begin
		if( DealerScore >= 17 ) then
			dealerStands <= '1';
		else
			dealerStands <= '0';
		end if;
	end process;
	
	process( PlayerScore, DealerScore, playerBust_INT, dealerBust_INT )
	begin
	--Player wins
		if(((PlayerScore > DealerScore) or (dealerBust_INT = '1')) and (playerBust_INT = '0')) then
			playerWins <= '1';
			dealerWins <= '0';

	--Dealer wins
		elsif(((PlayerScore < DealerScore) or (playerBust_INT = '1'))and (dealerBust_INT = '0')) then
			playerWins <= '0';
			dealerWins <= '1';

	--Nobody wins
		else
			playerWins <= '0';
			dealerWins <= '0';
		end if;
	end process;


END Behavioural;
