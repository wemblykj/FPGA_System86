`ifndef _roms_vh_
`define _roms_vh_
//`define ROM_PATH "../roms"
//`define ROM_PATH "D:/Development/Xilinx/system86/roms"

`define MAKE_ROM_PATH(game, rom_name) {`ROM_PATH, "/", ``game``, "/", ``rom_name``}

`endif //_roms_vh_