### Project description
Design an RSA encryption/decryption circuit that meets the following requirements:

1. The design must implement the RSA encryption algorithm.
2. Encrypt/decrypt a message of length 128 bits as fast as possible.
3. The target frequency is 50MHz.
4. The design must use less that 50% of the resources in
a Xilinx Zynq®-7000 device.
5. The design entity declaration must match the RSACore entity below.
6. The design must implement the interface in Fig 2.

		entity RSACore is
			port(
				Clk          : in std_logic;
				Resetn       : in std_logic;
				InitRsa      : in std_logic;
				StartRsa     : in std_logic;
				DataIn       : in std_logic_vector(31 downto 0);
				DataOut      : out std_logic_vector(31 downto 0);
				CoreFinished : out std_logic
				);
		end RSACore;
