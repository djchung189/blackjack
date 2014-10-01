library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

ENTITY datapath IS
	PORT(
		clock : IN STD_LOGIC;
		reset : IN STD_LOGIC;

		newPlayerCard : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
		newDealerCard : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);

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
	
	SIGNAL PlayerScore: STD_LOGIC_VECTOR(4 downto 0);
	SIGNAL DealerScore: STD_LOGIC_VECTOR(4 downto 0);
	
	SIGNAL playerBust_INT: std_LOGIC;
	SIGNAL dealerBust_INT: STD_LOGIC;
	
	
BEGIN
	
	--Possible Players cards need to be dealt
	DC_u0: dealcard
		port map(
			Deal => newPlayerCard(0),
			clock => CLOCK,
			Reset => reset,
			RandomCard => PlayerCards_INT(3 downto 0)
		);
		
	DC_u1: dealcard
		port map(
			Deal => newPlayerCard(1),
			clock => CLOCK,
			Reset => reset,
			RandomCard => PlayerCards_INT(7 downto 4)
		);

	DC_u2: dealcard
		port map(
			Deal => newPlayerCard(2),
			clock => CLOCK,
			Reset => reset,
			RandomCard => PlayerCards_INT(11 downto 8)
		);

	DC_u3: dealcard
		port map(
			Deal => newPlayerCard(3),
			clock => CLOCK,
			Reset => reset,
			RandomCard => PlayerCards_INT(15 downto 12)
		);
	
	--Possible Dealer Cards to be dealt
	DC_u4: dealcard
		port map(
			Deal => newDealerCard(0),
			clock => CLOCK,
			Reset => reset,
			RandomCard => DealerCards_INT(3 downto 0)
		);
		
	DC_u5: dealcard
		port map(
			Deal => newDealerCard(1),
			clock => CLOCK,
			Reset => reset,
			RandomCard => DealerCards_INT(7 downto 4)
		);

	DC_u6: dealcard
		port map(
			Deal => newDealerCard(2),
			clock => CLOCK,
			Reset => reset,
			RandomCard => DealerCards_INT(11 downto 8)
		);

	DC_u7: dealcard
		port map(
			Deal => newDealerCard(3),
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
			Bust => DealerBust_INT
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
	
	process( PlayerScore, DealerScore, PlayerBust_INT, DealerBust_INT )
	begin
	--Player wins
		if((PlayerScore > DealerScore) and (PlayerBust_INT = '0')) then
			PlayerWins <= '1';
			DealerWins <= '0';
	--Dealer wins
		elsif((PlayerScore < DealerScore) and (DealerBust_INT = '0')) then
			PlayerWins <= '0';
			DealerWins <= '1';
	--Nobody wins
		else
			PlayerWins <= '0';
			DealerWins <= '0';
		end if;
	end process;


END Behavioural;
