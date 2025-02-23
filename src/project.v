// 8-bit priority encoder with 7-segment decoder.
// Find index of most significant input data bit set to 1, and output result as 7-segment code (segments abcdefg).
// Binary data bit 7 has highest priority, bit 0 lowest.
// If no data bits are set then all 7-segments are off, but output pin None (decimal point dp) is on instead.
// Implemented with 8-bit priority encoder followed by 3-bit to 7-segment decoder.

module tt_um_priority_encoder_to_7_segment_display (input [7:0] data, output [6:0] segments, output none);

    // Interface between priority encoder and 7-segment decoder

    wire [2:0] code;

    // 7-segment decoding of digits

    //wire [6:0] digit [2:0] = '{
    reg [6:0] digit [7:0];
    initial begin
	//            gfedcba
	digit[0] = 7'b0111111, // zero
	digit[1] = 7'b0000110, // one
	digit[2] = 7'b1011011, // two
	digit[3] = 7'b1001111, // three
	digit[4] = 7'b1100110, // four
	digit[5] = 7'b1101101, // five
	digit[6] = 7'b1111101, // six
	digit[7] = 7'b0000111  // seven
	// };

    // Priority encoding

    assign code[2] = data[7] | data[6] | data[5] | data[4];
    assign code[1] = data[7] | data[6] | ~data[5] & ~data[4] & (data[3] | data[2]);
    assign code[0] = data[7] | ~data[6] & (data[5] | ~data[4] & (data[3] | ~data[2] & data[1]));

    // Output to 7-segment display with decimal point that indicates no data

    assign none = ~data[7] & ~data[6] & ~data[5] & ~data[4] & ~data[3] & ~data[2] & ~data[1] & ~data[0];
    assign segments = (none) ? 7'b0000000 : digit[code];

endmodule
