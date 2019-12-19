// This module will take incoming horizontal and veritcal blank signals and
// create Row and Column counters based on the active pixel area.
// It will align the Row/Col counters to the output blank signals.
// Useful for any module that needs to keep track of which Row/Col position we
// are on in the active portion of a frame
`include "../../../../../../../lib/video_lib/rtl/Blanking_To_Count.v"
