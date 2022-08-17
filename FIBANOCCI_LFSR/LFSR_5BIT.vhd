LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY LFSR_5BIT IS PORT 
(
  CLK, RST, SEED_IN, EN : IN STD_LOGIC;
  LFSR_SEED             : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
  OUTPUT                : OUT STD_LOGIC_VECTOR(4 DOWNTO 0)
);
END ENTITY LFSR_5BIT;

ARCHITECTURE BEHAVIORAL OF LFSR_5BIT IS
SIGNAL OUTPUT_TEMP : STD_LOGIC_VECTOR(4 DOWNTO 0);

BEGIN
  LFSR_PROCESS: PROCESS(CLK, RST)
    BEGIN
	  IF RST = '0' THEN -- ASYNCHRONOUS, ACTIVE LOW RESET
		  OUTPUT_TEMP <= (OTHERS => '1');
      ELSIF RISING_EDGE(CLK) THEN
		IF SEED_IN = '1' THEN
		  OUTPUT_TEMP <= LFSR_SEED;
		ELSIF EN = '1' THEN
		  OUTPUT_TEMP(4) <= OUTPUT_TEMP(0) XOR OUTPUT_TEMP(2) XOR OUTPUT_TEMP(1) ;
          OUTPUT_TEMP(3) <= OUTPUT_TEMP(4);
          OUTPUT_TEMP(2) <= OUTPUT_TEMP(3);
          OUTPUT_TEMP(1) <= OUTPUT_TEMP(2);
          OUTPUT_TEMP(0) <= OUTPUT_TEMP(1);
		END IF;
      END IF;
	END PROCESS;
  OUTPUT <= OUTPUT_TEMP;
END BEHAVIORAL;