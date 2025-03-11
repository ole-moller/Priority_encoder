/*
 * Copyright (c) 2025 Ole Henrik Møller
 * SPDX-License-Identifier: Apache-2.0
 */

`define default_netname none

module tt_um_ole_moller_priority_encoder_to_7_segment_decoder (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // will go high when the design is enabled
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

  // Unused utility and user inputs (avoid warnings)

  wire _unused = &{clk, ena, rst_n, uio_in};

  // All output pins must be assigned. If not used, assign to 0.

  assign uio_out = 0;
  assign uio_oe  = 0;
  
  priority_encoder_to_7_segment_decoder u1 ( 
    .data(ui_in[7:0]),
    .segments(uo_out[6:0]),
    .no_data(uo_out[7]) );

endmodule
