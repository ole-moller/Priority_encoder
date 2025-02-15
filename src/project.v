// Find index of most significant data bit set to 1 among 8 data bits, and output result to 7-segment display.
// Binary data bit 7 has highest priority, bit 0 lowest.
// If no data bits are set then all 7-segments are off, but decimal point (output none) is on.
// Implemented with 8-bit priority encoder followed by 3-bit to 7-segment decoder.

module tt_um_Priority_encoder_to_7_segment_display (
    input  logic data[7:0],
    output logic segments[6:0],
    output logic none);

    // Interface between priority encoder and octal-to-7-segment driver

    logic [2:0] code;

    // 7-segment encoding of digits

    logic [6:0] digit [8] = '{
    //     gfedcba
	7'b0111111, // zero
	7'b0000110, // one
	7'b1011011, // two
	7'b1001111, // three
	7'b1100110, // four
	7'b1101101, // five
	7'b1111101, // six
	7'b0000111  // seven
	};

    // Priority encoding

    code[2] = data[7] | data[6] | data[5] | data[4];
    code[1] = data[7] | data[6] | ~data[5] & ~data[4] & (data[3] | data[2]);
    code[0] = data[7] | ~data[6] & (data[5] | ~data[4] & (data[3] | ~data[2] & data[1]));

    // Output to 7-segment display with decimal point that indicates no data

    always_comb
	begin
	none = ~data[7] & ~data[6] & ~data[5] & ~data[4] & ~data[3] & ~data[2] & ~data[1] & ~data[0];
	if (none) begin	segments = 7'b0000000;
	    end else begin
	segments = digit[code]; end;
	end

endmodule
