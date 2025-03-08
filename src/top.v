/*
 * Copyright (c) 2024 Ole Henrik Møller
 * SPDX-License-Identifier: Apache-2.0
 */

`define default_netname none

module tt_um_Ole_Henrik_Moller_Priority encoder (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // will go high when the design is enabled
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

  // All output pins must be assigned. If not used, assign to 0.

  assign uio_out = 0;
  assign uio_oe  = 0;
  
  // Insert Priority encoder logic here 
  signed_unsigned_4x4_bit_multiplier mult( 
    .multiplicand(ui_in[7:4]),
    .multiplier(ui_in[3:0]),
    .signed_mode(uio_in[0]),
    .product(uo_out[7:0]));

    



endmodule
