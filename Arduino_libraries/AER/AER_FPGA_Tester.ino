
#include "FPGA_Controller.h"

//
// This is an example on how to use the JTAG_Interface: The file FPGA_Bitstream.h is
// generated from Intel Quartus and supposed to be replaced by your own. Make sure to
// take a look at the attached Quartus project, where you can extend this project or copy
// the Verilog modules related to the JTAG interface and paste them into your own design.
//
// Those JTAG related modules and the corresponding attached C++ functions allow you
// to easily and reliably send and read data from and to the FPGA. The point of this
// project is to make it as easy as possible for any new user to establish a communication
// between the CPU and the FPGA, as most commonly the first problem you encounter when creating
// your own bitstream is that you lose the ability to talk to the FPGA.
//
// When replacing this bitstream with your own, make sure to compile it correctly with Intel Quartus
//  (try the attached Quartus project which the default bitstream is generated from).
//
// When successfully compiled, take the output file ( output_files/MKRVIDOR4000.ttf ) and
// bit-reverse it using ReverseByte. For info on that, refer to:
//
// 		https://systemes-embarques.fr/wp/archives/mkr-vidor-4000-programmation-du-fpga-partie-1/
// 
// When the bitstream is finally reversed, simply rename it to "FPGA_Bitstream.h" and paste it
// into the FPGA_Controller folder of the library, which will overwrite the default bitstream.
//

void setup() {

	Serial.begin(115200); // Serial.begin() should be called before uploadBitstream

	// Upload the bitstream to the FPGA
	uploadBitstream();

	while(!Serial);

	Serial.println("Welcome!");

	// Warning: The digital pins 6, 7 and 8 are configured as outputs
	// on the FPGA, so shortening them out or configuring them as outputs
	// on the CPU as well may kill your Arduino permanently

	initJTAG();

  delay(500);
    
  uint32_t AER_input;
  uint32_t AER;
 // Simulate the clock cycle of 2*500 ms
 for (int i = 0; i <= 5; i++) {
    // spikes = 0b11011 || preset = 0b0 || write_en = 0b1 || reset = 0b0 || clock = 0b0;
    AER_input = 0b110110100;
    // Write to register #1 as we connected the the AER system to that port:
    writeJTAG(1,AER_input);

    delay(500);
    
    // spikes = 0b11011 || preset = 0b0 || write_en = 0b1 || reset = 0b0 || clock = 0b1;
    AER_input = 0b110110101;
    // Write to register #1 as we connected the the AER system to that port:
    writeJTAG(1,AER_input);

    delay(500);
    
    // The output of the AER system as been connected to input bus #1, so we're gonna read this now
    AER = readJTAG(1);
    Serial.print("\nThe results of the AER system are:\n ");
    Serial.print("EN_NEURON: "); Serial.println((AER & 0b001) > 0);
    Serial.print("FIFO_full: "); Serial.println((AER & 0b010) > 0);
    Serial.print("FIFO_empty: "); Serial.println((AER & 0b100) > 0);
    Serial.print("AER: "); Serial.println((AER), BIN);
 }
  

}

void loop() {

	// Make some space
	Serial.println("\n\n\n\n");

	// In the FPGA code we connected the analog ports 0-2 to the lowest 3 bits of input bus 0,
	// so we're gonna read this bus and extract the first 3 bits to read them
	// It's only a digital signal in our case

	// Read the input band with id 0
	uint32_t inputs = readJTAG(0);
	Serial.print("A0: "); Serial.println((inputs & 0b001) > 0);
	Serial.print("A1: "); Serial.println((inputs & 0b010) > 0);
	Serial.print("A2: "); Serial.println((inputs & 0b100) > 0);



	// Write to register #0 as we connected its lowest 3 bits to digital outputs 6, 7 and 8
	// Let's set the pins to random values:
	bool d6 = rand() % 2 == 0;
	bool d7 = rand() % 2 == 0;
	bool d8 = rand() % 2 == 0;

	uint32_t output = (d8 << 2) | (d7 << 1) | d6;	// Write the value to register #0, which the
	writeJTAG(0, output);							// digital pins are constantly reading from

	Serial.print("\nSet D6 to "); Serial.println(d6);
	Serial.print("Set D7 to "); Serial.println(d7);
	Serial.print("Set D8 to "); Serial.println(d8);

	delay(500);

}
