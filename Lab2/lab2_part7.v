/* lab2_part7.v
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


module lab2_part7 (SW, LEDR, HEX1, HEX0);
  input [5:0] SW;
  output [0:6] HEX1, HEX0;
  output [5:0] LEDR;

  reg [3:0] TENS, ONES;

  assign LEDR = SW;

  always begin
    if (SW[5:0] > 59) begin
      TENS = 6;
      ONES = SW[5:0] - 60;
    end else if (SW[5:0] > 49) begin
      TENS = 5;
      ONES = SW[5:0] - 50;
    end else if (SW[5:0] > 39) begin
      TENS = 4;
      ONES = SW[5:0] - 40;
    end else if (SW[5:0] > 29) begin
      TENS = 3;
      ONES = SW[5:0] - 30;
    end else if (SW[5:0] > 19) begin
      TENS = 2;
      ONES = SW[5:0] - 20;
    end else if (SW[5:0] > 9) begin
      TENS = 1;
      ONES = SW[5:0] - 10;
    end else begin
      TENS = 0;
      ONES = SW[5:0];
    end //if
  end //always

  b2d_7seg H1 (TENS, HEX1);
  b2d_7seg H0 (ONES, HEX0);

endmodule

module b2d_7seg (X, SSD);
  input [3:0] X;
  output [0:6] SSD;

  assign SSD[0] = ((~X[3] & ~X[2] & ~X[1] &  X[0]) | (~X[3] &  X[2] & ~X[1] & ~X[0]));
  assign SSD[1] = ((~X[3] &  X[2] & ~X[1] &  X[0]) | (~X[3] &  X[2] &  X[1] & ~X[0]));
  assign SSD[2] =  (~X[3] & ~X[2] &  X[1] & ~X[0]);
  assign SSD[3] = ((~X[3] & ~X[2] & ~X[1] &  X[0]) | (~X[3] &  X[2] & ~X[1] & ~X[0]) | (~X[3] &  X[2] & X[1] & X[0]) | (X[3] & ~X[2] & ~X[1] & X[0]));
  assign SSD[4] = ~((~X[2] & ~X[0]) | (X[1] & ~X[0]));
  assign SSD[5] = ((~X[3] & ~X[2] & ~X[1] &  X[0]) | (~X[3] & ~X[2] &  X[1] & ~X[0]) | (~X[3] & ~X[2] & X[1] & X[0]) | (~X[3] & X[2] & X[1] & X[0]));
  assign SSD[6] = ((~X[3] & ~X[2] & ~X[1] &  X[0]) | (~X[3] & ~X[2] & ~X[1] & ~X[0]) | (~X[3] &  X[2] & X[1] & X[0]));
endmodule
