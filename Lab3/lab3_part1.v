/* lab3_part1.v - A gated RS latch
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



// A gated RS latch
module lab3_part1 (Clk, R, S, Q);
  input Clk, R, S;
  output Q;

  wire R_g, S_g, Qa, Qb /* synthesis keep */ ;

  assign R_g = R & Clk;
  assign S_g = S & Clk;
  assign Qa = ~(R_g | Qb);
  assign Qb = ~(S_g | Qa);

  assign Q = Qa;
endmodule