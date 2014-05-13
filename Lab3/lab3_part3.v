/* lab3_part3.v - Master Slave D latch
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


       +--------------------------------------+
       |     +------+              +------+   |
  D  --+-----+D    Q+--------------+D    Q+---+-- Q
       |     |      |              |      |   |
       |   ~ |     _|              |     _|   |   _
  Clk -+-+--- Clk  Q|            +--Clk  Q+---+-- Q
       | |   +------+            | +------+   |
       | |                       |            |
       | +-----------------------+            |
       |                                      |
       +--------------------------------------+

  +-------------+
  |D  Q  > Qnext|
  |0  X  F   0  |
  |1  X  F   1  |
  +-------------+

*/

module lab3_part3 (SW, LEDR, LEDG);

	input [1:0] SW;
	output [1:0] LEDR, LEDG;
	assign LEDR = SW;
	
	wire Q;

	MSDF F0(SW[1],SW[0],LEDG[0]);

endmodule

module MSDF(Clk,D,Q);
	
	input Clk, D;
	output Q;

	wire Q_m;

	Dflop D0 (~Clk, D, Q_m);
	Dflop D1 (Clk, D, Q);

endmodule

module Dflop (Clk, D, Q);
  input Clk, D;
  output Q;

  wire S,R;
  
  assign S = D;
  assign R = ~D;
  
  wire R_g, S_g, Qa, Qb /* synthesis keep */ ;
  
/*  S_g truth table
 +--+---+----+
 | D|Clk|S_g |
 | 0| 0 | 1  |
 | 0| 1 | 1  |
 | 1| 0 | 1  |
 | 1| 1 | 0  |
 +--+---+----+
 */

	assign S_g = S & Clk;

/* R_g truth table
 +--+---+----+
 | D|Clk|R_g |
 | 0| 0 | 1  |
 | 0| 1 | 0  |
 | 1| 0 | 1  |
 | 1| 1 | 1  |
 +--+---+----+
*/

	assign R_g = R & Clk;
	
	assign Qa = ~(R_g & Qb);
	assign Qb = ~(S_g & Qa);
	
	assign Q = Qa;

endmodule
