/* lab3_part4.v - Three different storage elements:
 *	- gated D latch;
 * - positive-edge triggered D flipflop;
 *	- negative-edge triggered D flip-flop.
 *
 * Copyright (c) 2014, Artem Tovbin <arty99 at gmail dot com>
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License version 2 as
 * published by the Free Software Foundation.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.

           +----+
   D  ---+-+D  Q+--- Qa
         | |   _|    _
 Clock-+-+-+ClkQ+--- Qa
       | | +----+
       | |
       | |
       | |
       | | +----+
       | +-+D  Q+--- Qb
       | | |   _|    _
      +--+-+>  Q+--- Qb
      |  | +----+
      |  |
      |  |
      |  |
      |  | +----+
      |  +-+D  Q+--- Qc
      |    |   _|    _
      +---o+>  Q+--- Qc
           +----+


*/

module lab3_part4 (D, Clk, Qa, Qb, Qc);

	input D, Clk;
	output Qa, Qb, Qc;
		
	wire D, Clk;

	Dflop D0 (D, Clk, Qa);
	PED P0 (D, Clk, Qb);
	NED N0 (D, Clk, Qc);
	
	
	
endmodule

module NED (D, Clk, Q);
	
	input D, Clk;
	output reg Q;

	always @ (negedge Clk)
		
		Q = D;
		
endmodule


module PED (D, Clk, Q);
	
	input D, Clk;
	output reg Q;

	always @ (posedge Clk)
		
		Q = D;
	
endmodule

module Dflop (D, Clk, Q);
  input D, Clk;
  output reg Q;

  always @ (D, Clk)
	if (Clk)
		Q = D;
		
endmodule
