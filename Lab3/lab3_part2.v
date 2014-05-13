/* lab3_part1.v - A gated D latch
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
 */

module lab3_part2 (SW,LEDR);

input [17:0] SW;
output [17:0] LEDR;

Dflop(SW[1],SW[0],LEDR[0]);

endmodule
 
module Dflop (Clk, D, Q);
  input Clk, D;
  output Q;

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

assign S_g = ((~D & ~Clk) | (~D & Clk) | (D & ~Clk));

/* R_g truth table
 +--+---+----+
 | D|Clk|R_g |
 | 0| 0 | 1  |
 | 0| 1 | 0  |
 | 1| 0 | 1  |
 | 1| 1 | 1  |
 +--+---+----+
*/

assign R_g = ((~D & ~Clk) | (D & ~Clk) | (D & Clk));

assign Qa = (R_g & ~Qb);
assign Qb = (S_g & ~Qa);

assign Q = Qa;

endmodule
