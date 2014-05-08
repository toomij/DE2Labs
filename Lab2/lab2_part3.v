/* lab2_part3.v - 4-bit to decimal (0..15)
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

module lab2_part3 (SW, LEDG, LEDR);
  input [17:0] SW;
  output [8:0] LEDR, LEDG;

  assign LEDR[8:0] = SW[8:0];

  wire c1, c2, c3;

  fulladder A0 (SW[0], SW[4], SW[8], LEDG[0], c1);
  fulladder A1 (SW[1], SW[5], c1, LEDG[1], c2);
  fulladder A2 (SW[2], SW[6], c2, LEDG[2], c3);
  fulladder A3 (SW[3], SW[7], c3, LEDG[3], LEDG[4]);
endmodule

module fulladder (a, b, ci, s, co);
  input a, b, ci;
  output co, s;

  wire d;

  assign d = a ^ b;
  assign s = d ^ ci;
  assign co = (b & ~d) | (d & ci);
endmodule
