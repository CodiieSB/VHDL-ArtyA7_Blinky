library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;
use IEEE.math_real.ALL;
use ieee.numeric_std.all;

entity Blinky is
generic ( 
           NUM_LEDS      : integer := 4;
           CLK_RATE      : integer := 100000000; --50Mhz
           BLINK_RATE    : integer := 2);        --2Mhz default
                        
Port (
           Led_out    : out std_logic_vector(NUM_LEDS - 1 downto 0);
           CLK        : in std_logic;
           RST        : in std_logic 
);
end Blinky;

architecture Behavioral of Blinky is
constant MAX_VAL    : integer := (CLK_RATE / BLINK_RATE);
constant BIT_DEPTH  : integer := integer (ceil(log2(real(MAX_VAL)))); 
 
signal count_reg  : unsigned(BIT_DEPTH -1 DOWNTO 0) := (OTHERS => '0');
signal led_reg    : std_logic_vector(NUM_LEDS -1 downto 0) := "0000";

begin
     
     Led_out <= led_reg;      --Assign the output value to led
                      
     COUNT_PROC : process(CLK) 
     begin
     
            if(rising_edge(clk)) then 
                if((RST = '0') or (count_reg = MAX_VAL)) then
                      count_reg <= (others => '0');
                      
                else 
                      count_reg <= count_reg +1;
                      
                end if;
                
            end if; 
     end process;
            
     OUTPUT_PROC : process(CLK)
     begin 
     
            if(rising_edge(clk))  then
            
                if( count_reg = MAX_VAL) then                                   
                      led_reg <= not led_reg;
                      
                end if;
                
            end if;            
     end process;
     
end Behavioral;
