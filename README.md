# modified-ram-controller

## Short Description
This project is my course project. The task was to develop a RAM controller on SystemVerilog. The device must be able to write and read data from the memory array (*two-dimensional array reg/logic*). The word width is 32 bits, the number of words is set by the parameter (*the memory array itself can be declared as reg[31:0] mem [p_mem_size]*). 
Basic properties of the device:
+ 32-bit data input
+	32-bit data output
+	address input (width is calculated depending on the number of words in memory)
+	type of operation (read/write)
+	operation indication.

Next, it was necessary to conduct modeling and verification of the developed device with functions like:
+ write-read to the beginning of the array
+	write-read to the middle of the array
+	write-read to the end of the array
+	write the entire array
+	read the entire array
+	perform N random operations (*the operation and the address of the operation are determined using the random number generation function*).

During development, I decided to modify the controller by implementing additional functionality at the hardware level that provides data writing to the beginning, middle and end of the data array, reading data from the beginning, middle and end of the data array, as well as reading and filling the entire data array with one value.

## Simulation results
### 1. Pre-prepared testing
####  1. Writing data to the beginning, middle and end of the array
1. Wave chart:

2. Results output to the console:
 
         
         1. Writing to the beginning
         An entry of data = 11000000100010010101111010000001 was made to the beginning of the array
         Writing to the beginning of the array completed successfully!
         
         2. Writing to the middle
         An entry of data = 10110001111100000101011001100011 was made to the middle of the array
         Writing to the middle of the array completed successfully! 
         
         3. Writing to the end
         An entry of data = 01000110110111111001100110001101 was made to the end of the array
         Writing to the end of the array completed successfully!
        
####  2. Writing data to the entire array, reading data from the beginning, middle, end and the entire array
1. Wave chart:

2. Results output to the console:
        
 
        4. Writing to the whole array
        An entry was made to the whole array
        Writing to the whole array completed successfully!
        
        
        1. Reading from the beginning
        Data = 10001001001101110101001000010010 has been read from the beginning of the array
        Reading from the beginning of the array completed successfully!
        
        2. Reading from the middle
        Data = 10001001001101110101001000010010 has been read from the middle of the array
        Reading from the middle of the array completed successfully!
        
        3. Reading from the end
        Data = 10001001001101110101001000010010 has been read from the end of the array
        Reading from the end of the array completed successfully!
        
        4. Reading the whole array
        Data has been read from the whole array
        Reading from the whole array completed successfully!
				
### 2. Testing using the built-in random number generator
####  1. Test 1
1. Wave chart:

2. Results output to the console:

        Op_code = 00 	WE = 0 	RE = 0
        Op_code = 00 	WE = 1 	RE = 0
        An entry of data = 11100011001101110010010011000110 was made to the beginning of the array
        Writing to the beginning of the array completed successfully!
        
        Op_code = 10 	WE = 1 	RE = 0
        An entry of data = 10111011110100100111001001110111 was made to the end of the array
        Writing to the end of the array completed successfully!
        
####  2. Test 2
1. Wave chart:

2. Results output to the console:

        Op_code = 11 	WE = 0 	RE = 1
        Data has been read from the whole array
        Reading from the whole array completed successfully!
        
        Op_code = 00 	WE = 1 	RE = 0
        An entry of data = 00101110010110000100100101011100 was made to the beginning of the array
        Writing to the beginning of the array completed successfully!
        
        Op_code = 01 	WE = 1 	RE = 0
        An entry of data = 10110001111011110110001001100011 was made to the middle of the array
        Writing to the middle of the array completed successfully!
        
        Op_code = 00 	WE = 0 	RE = 1
        Data = 00101110010110000100100101011100 has been read from the beginning of the array
        Reading from the beginning of the array completed successfully!
        
        Op_code = 01 	WE = 0 	RE = 1
        Data = 10110001111011110110001001100011 has been read from the middle of the array
        Reading from the middle of the array completed successfully!
        
####  3. Test 3
1. Wave chart:

2. Results output to the console:
        Op_code = 01 	WE = 1 	RE = 0
        An entry of data = 00110101100111111101110101101011 was made to the middle of the array
        Writing to the middle of the array completed successfully!
        
        Op_code = 10 	WE = 0 	RE = 1
        Data = 10111011110100100111001001110111 has been read from the end of the array
        Reading from the end of the array completed successfully!
        
        Op_code = 11 	WE = 1 	RE = 0
        An entry was made to the whole array
        Writing to the whole array completed successfully!
        
        Op_code = 00 	WE = 0 	RE = 1
        Data = 00000101000010010110010100001010 has been read from the beginning of the array
        Reading from the beginning of the array completed successfully!
        
        Op_code = 01 	WE = 0 	RE = 1
        Data = 00000101000010010110010100001010 has been read from the middle of the array
        Reading from the middle of the array completed successfully!

## Resource costs

## RTL-module

## Project Setup
This project has been developed with Cyclon V Quartus.

## Timings/frequency of memory operation

## Summary table of pin voltages






