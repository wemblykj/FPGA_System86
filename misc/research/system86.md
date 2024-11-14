# System 86 Investigation

## Custom Chips

Name|Purpose|References
-|:-|-
 CUS27|Clock-generator, pixel-clock and video synchronisation|
 CUS42|Tile-map address generator|
 CUS43|Tile-map pixel generator|
 
### CUS27
 
#### Overview

##### Clock-generation
 
 - 48Mhz master clock input
 - Clock-divider producing the following output clock signals
   - 24M - 24 Mhz clock (unused)
   - 12M - 12 Mhz clock (unused)
   - 6M - 6 Mhz clock
 
##### Video synchronisation
 - 6 Mhz pixel clock input (from self-generated 6M clock signal)
 - horizontal and vertical timing signals
 *reset, sync and blank*
 - pixel-address signals
   *1H->4H* - [visible] LSBs of scan-line position in binary form 0->7
   *1V->4V* - [visible] line number in binary form 0->224
   *A0->A10* - [not sure - maybe screen tile index 0 = top-left 31 = top-right ] 
   *A0->A4* - [?] equal to horizontal tile index 0->31, and therefore also the MSBs of scan-line position?
   *A5->A9* - [?] equal to vertical tile index 0->31 and therefore the MSBs of scan-line number; Pac-Land and Pac-Mania imply 8V->128V with A5 = 8V in both [2], [3]
   *A10* - ? at a guess 256V
   *S1H* - need to work this out for sure - at a guess precedes 1H (see S2H)
   *S2H*  - precedes 2H? (need to work this out for sure) - drives CPU address bus multiplexer (2H drives the control signals)
 - HRESET is shown as an input by convention of it being routed from the left-hand side
   there is, however, no external driver for this signal 
   update 2024: the silicon die for the chip shows that the pin (pin 10) can be used as input or an output

#### Silicon reverse engineering  

##### Overview
 - Uses bipolar junction logic
 - Chip provides a net of configurable base cells in a 19 x 18 grid
 - A base cell provides the necessary components to be able to configure it as a 4 input NAND gate [11, 12]
 - Power rails run vertically and horizontally through the cells (through the  middle of a group of four mirrored cells)
 - A single cell, configured as a NAND gate, with a single input will act as an inverter [6, 9, 10]
 - There is a four input NAND gate according to [9] however this would appear to have been spread over two consecutive cells
   I can only presume this is for the benefit of more simplified routing on the upper metal layers
 - More complex standard cells can be created from one or more cells [9]
   - AND gate	(2 cells)
   - D-type flip-flop (6 cells)
   - JK flip-flop (7 cells)
   - toggle (6 cells)
   - AND OR INVERT (AOI) (2 cells) [15]
 
##### Structure of a cell
- input stage
  - 4 transistors
    - can possibly be thought of as a single transistor, that we'll refer to as **Q1**, with multiple inputs (like a multi-emitter transister)
    - each transister has discrete base and emitter junctions and a common collector
    - assumed to be PNP
    - an input is connected to one of the bases
    - for AND/NAND functionality, the emitters of all used input transisters are tied together and pulled high via resister **R1**
  - 1 pull-up resister **R1**
- 1 phase-splitter stage
  - 1 NPN transister **Q2**
  - 1 pull-up resistor **R2**
- output stage (totem-pole)
  - 1 NPN pull-up transistor **Q3**
  - 1 NPN pull-down transistor **Q4**
  - 1 biasing diode **D1** [12, Notes and references - point 12]
  - 1 pull-down reister **R3**
  
### CUS42
 
 
### CUS43

I was hoping that this chip would simply be of the same form as the CUS27 only with a different configuration. However this is not the case and
the chip, whilst still a grid of configurable 'cells' it would appear to be vastly larger (68 pins) and is mainly column after column of a repreated basic components (one presumes transistors)


## References
1. Rolling Thunder Schematic Package Suppliment (SP300)
2. Pac-Land U.R Preliminary Electrical Section (M051-00B64-A013)
3. Pac-Mania Schematics Package (SP315)
4. Ghost 'n' Goblins schematics (CR7E-56-3.96E or 1168-056-009)
5. CUS27 reverse-engineering @ UKvAc [https://www.ukvac.com/forum/threads/namco-cus27-in-fpga-cus130-wip.50342/]
6. Publicly available die photos from siliconpr0n [https://siliconpr0n.org/map/namco/]
7. CUS42 die photo [https://siliconpr0n.org/map/namco/27/caps0ff_mz_mit20x/]
8. CUS43 die photo [https://siliconpr0n.org/map/namco/43/caps0ff_mz_mit20x2/]
9. SiliconRE @ furrtek [https://github.com/furrtek/SiliconRE/tree/master/Namco]
10. CUS27 schematics @ furrtek [https://github.com/furrtek/SiliconRE/blob/master/Namco/CUS27/CUS27_schematics.pdf]
11. Ken Shirriff's blog [https://www.righto.com/]
12. Inside the 74181 ALU chip: die photos and reverse engineering [https://www.righto.com/2017/01/die-photos-and-reverse-engineering.html#fn:diode]
13. Looking inside a vintage Soviet TTL logic integrated circuit [https://www.righto.com/2020/03/looking-inside-vintage-soviet-ttl-logic.html]
14. Circuit Simulator [https://www.falstad.com/circuit/]
15. AND-OR-invert [https://en.wikipedia.org/wiki/AND-OR-invert#:~:text=AND%2DOR%2Dinvert%20(AOI,part%20of%20%22AOI%22).]