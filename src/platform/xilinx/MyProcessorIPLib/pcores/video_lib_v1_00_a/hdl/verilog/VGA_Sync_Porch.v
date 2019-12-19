// The purpose of this module is to modify the input HSync and VSync signals to
// include some time for what is called the Front and Back porch.  The front
// and back porch of a VGA interface used to have more meaning when a monitor
// actually used a Cathode Ray Tube (CRT) to draw an image on the screen.  You
// can read more about the details of how old VGA monitors worked.  These
// days, the notion of a front and back porch is maintained, due more to
// convention than to the physics of the monitor.
// New standards like DVI and HDMI which are meant for digital signals have
// removed this notion of the front and back porches.  Remember that VGA is an
// analog interface.
// This module is designed for 640x480 with a 25 MHz input clock.
`include "../../../../../../../lib/video_lib/rtl/VGA_Sync_Porch.v"