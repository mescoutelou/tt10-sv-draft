/*
 * Copyright (c) 2025 HerdWare
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module tt_um_sv (
    input  logic [7:0] ui_in,    // Dedicated inputs
    output logic [7:0] uo_out,   // Dedicated outputs
    input  logic [7:0] uio_in,   // IOs: Input path
    output logic [7:0] uio_out,  // IOs: Output path
    output logic [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  logic       ena,      // always 1 when the design is powered, so you can ignore it
    input  logic       clk,      // clock
    input  logic       rst_n     // reset_n - low to reset
);

  logic [7:0] r_cnt;

  // All output pins must be assigned. If not used, assign to 0.
//  assign uo_out  = ui_in + uio_in;  // Example: ou_out is the sum of ui_in and uio_in
  assign uio_out = 0;
  assign uio_oe  = 0;

  // List all unused inputs to prevent warnings
  logic _unused = &{ena, clk, rst_n, 1'b0};

  always_ff @(posedge clk) begin
    if (~rst_n) begin
      uo_out <= 'h00; 
      r_cnt <= 'h00;          
    end 
    else begin
      uo_out <= ui_in + uio_in + r_cnt;
      r_cnt <= r_cnt + 'h1;
    end
  end

endmodule
