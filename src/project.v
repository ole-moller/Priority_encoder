// 8-bit priority encoder with 7-segment decoder.
// Find index of most significant input data bit set to 1, and output result as 7-segment code (segments abcdefg).
// Binary data bit 7 has highest priority, bit 0 lowest.
// If no data bits are set then all 7-segments are off, while output pin no_data (decimal point dp) is on instead.
// Implemented with 8-bit priority encoder followed by 3-bit to 7-segment decoder.

// module tt_um_ole_moller_priority_encoder_to_7_segment_decoder (input [7:0] data, output [6:0] segments, output none);

module priority_encoder_to_7_segment_decoder (
    input  wire [7:0] data,	// Dedicated inputs
    output wire [6:0] digit,	// Dedicated outputs
    output wire [7] no_data); 	// Dedicated outputs

//module tt_um_ole_moller_priority_encoder_to_7_segment_decoder (
//    input  wire [7:0] ui_in,    // Dedicated inputs
//    output wire [7:0] uo_out,   // Dedicated outputs
//    input  wire [7:0] uio_in,   // IOs: Input path
//    output wire [7:0] uio_out,  // IOs: Output path
//    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
//    input  wire       ena,      // always 1 when the design is powered, so you can ignore it
//    input  wire       clk,      // clock
//    input  wire       rst_n);   // reset_n - low to reset

//    // Declare internal signals

//    wire [7:0] data;		// Input to priority encoder
//    wire [2:0] code;		// Interface between priority encoder and 7-segment decoder
//    wire [6:0] digit [7:0];	// Output to 7-segment display
//    wire no_data;		// Output to decimal point of 7-segment display

//    // Connect template signals to internal signals

//    assign data = ui_in;
//    assign uo_out[6:0] = digit;
//    assign uo_out[7] = none;
//    assign uio_oe = 0;
//    assign uio_out = 0;

    // 7-segment decoding of digits

    wire [6:0] digit [7:0];

    initial begin
	//Segment     gfedcba
	digit[0] = 7'b0111111; // zero
	digit[1] = 7'b0000110; // one
	digit[2] = 7'b1011011; // two
	digit[3] = 7'b1001111; // three
	digit[4] = 7'b1100110; // four
	digit[5] = 7'b1101101; // five
	digit[6] = 7'b1111101; // six
	digit[7] = 7'b0000111; // seven
    end

    // Priority encoding

    assign code[2] = data[7] | data[6] | data[5] | data[4];
    assign code[1] = data[7] | data[6] | ~data[5] & ~data[4] & (data[3] | data[2]);
    assign code[0] = data[7] | ~data[6] & (data[5] | ~data[4] & (data[3] | ~data[2] & data[1]));

    // Output to 7-segment display with decimal point that indicates no data

    assign no_data = ~data[7] & ~data[6] & ~data[5] & ~data[4] & ~data[3] & ~data[2] & ~data[1] & ~data[0];
    assign segments = (no_data) ? 7'b0000000 : digit[code];

endmodule
