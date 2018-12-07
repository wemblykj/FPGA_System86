# FPGA_System86
Investigation into an FPGA implementation of the Namco System 86 arcade board

The following project started out as an exercise into learning Verilog. In order to pique my interest a bit more I thought I'd start by recreating the basics of an arcade game. Byt what arcade game should I recreate? Well it turns out that a simple, early 80s era, arcade game would be far to simple so I have decided to jump straight into the deep end with a game that I remember watching with awe when I was youngster.

The game I have chosen is Rolling Thunder release by U.S. Gold in 1986 and running on Namco's System [19]86 hardware.

I was already aware that comprehensive schematics are available for this game and so it seemed to good to turn it down.

TODO: add hardware specs

The objectives for this project are as follows:

1. Attempt to implement a chip for chip implementation of the System 86 hardware in a Verilog simulation environment

1.1. Game PCB

1.1.1. Emulate the dual 6809, associated custom chips, system bus and primary memories such that the RT code for primary CPU and secondary CPU will execute unhindered

- EEPROM emulation (for Verilog simulations)
- 6264 RAM emulation (for Verilog simulations)
- CUS27 system timing
- CUS41 CPU#1 address generator
- CUS47 CPU#2 address generator
- 
- Supporting TTL logic
- Master CPU bus and multiplexer
- rudimentary GFX ram support (required for initial system test)
- rudimentary sprite ram support (required for initial system test)

1.1.2. Implement the tilemap pipeline for a single layer

- CUS42 CPU#1 address generator
- CUS43 CPU#1 address generator
- Palette generation
- RGB stream generation

1.1.3. Extend the tilemap pipeline for all four layers

1.1.4. Implement the sprite pipeline

TBD.

1.2. Sub PCB

TBD.

1.2.1. Sound

TBD.

2.0 Move from simulation to FPGA hardware

TBD

Feasability:
- Simulate RAM and EEPROM access using SDRAM back end?
