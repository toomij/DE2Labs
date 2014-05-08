/* b2d.v - A decoder from 4-bit input to 7seg Displays
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
 

module b2d(SW,HEX0,HEX1,HEX2,HEX3);

	// Input Port(s)
	input [17:0] SW;
	
	// Output Port(s)
	output [0:6] HEX0,HEX1,HEX2,HEX3;
	
	b2d_7seg B0 (SW[3:0], HEX0);
   b2d_7seg B1 (SW[7:4], HEX1);
   b2d_7seg B2 (SW[11:8], HEX2);
   b2d_7seg B3 (SW[15:12], HEX3);

endmodule
	
/*
***************************************************************
Truth Table "A 4-to-7 Decoder"

+--- +----+----+----+----+-----+----+----+----+----+-----+------+
|SW15|SW14|SW13|SW12|HEX0|HEX1 |HEX2|HEX3|HEX4|HEX5|HEX6 | BCD  |
+--- +----+----+----+----+-----+----+----+----+----+-----+------+
| 0  | 0  | 0  | 0  | 0  | 0   | 0  | 0  | 0  | 0  | 1   |  0   |
+----+----+----+----+----+-----+----+----+----+----+-----+------+
| 0  | 0  | 0  | 1  | 1  | 0   | 0  | 1  | 1  | 1  | 1   |  1   |
+----+----+----+----+----+-----+----+----+----+----+-----+------+
| 0  | 0  | 1  | 0  | 0  | 0   | 1  | 0  | 0  | 1  | 0   |  2   |
+----+----+----+----+----+-----+----+----+----+----+-----+------+
| 0  | 0  | 1  | 1  | 0  | 0   | 0  | 0  | 1  | 1  | 0   |  3   |
+--- +----+----+----+----+-----+----+----+----+----+-----+------+
| 0  | 1  | 0  | 0  | 1  | 0   | 0  | 1  | 1  | 0  | 0   |  4   |
+----+----+----+----+----+-----+----+----+----+----+-----+------+
| 0  | 1  | 0  | 1  | 0  | 1   | 0  | 0  | 1  | 0  | 0   |  5   |
+----+----+----+----+----+-----+----+----+----+----+-----+------+
| 0  | 1  | 1  | 0  | 1  | 1   | 0  | 0  | 0  | 0  | 0   |  6   |
+----+----+----+----+----+-----+----+----+----+----+-----+------+
| 0  | 1  | 1  | 1  | 0  | 0   | 0  | 1  | 1  | 1  | 1   |  7   |
+--- +----+----+----+----+-----+----+----+----+----+-----+------+
| 1  | 0  | 0  | 0  | 0  | 0   | 0  | 0  | 0  | 0  | 0   |  8   |
+----+----+----+----+----+-----+----+----+----+----+-----+------+
| 1  | 0  | 0  | 1  | 0  | 0   | 0  | 0  | 1  | 0  | 0   |  9   |
+----+----+----+----+----+-----+----+----+----+----+-----+------+
| 1  | 0  | 1  | 0  | 1  | 1   | 0  | 0  | 0  | 0  | 0   |  E   |
+----+----+----+----+----+-----+----+----+----+----+-----+------+
| 1  | 0  | 1  | 1  | 1  | 1   | 0  | 0  | 0  | 0  | 0   |  E   |
+----+----+----+----+----+-----+----+----+----+----+-----+------+
| 1  | 1  | 1  | 0  | 1  | 1   | 0  | 0  | 0  | 0  | 0   |  E   |
+----+----+----+----+----+-----+----+----+----+----+-----+------+
| 1  | 1  | 1  | 1  | 1  | 1   | 0  | 0  | 0  | 0  | 0   |  E   |
+----+----+----+----+----+-----+----+----+----+----+-----+------+

        HEX3 [0:6]
  +----------0---------+
  ||+----------------+||  HEX3[0] = (~SW[15] & ~SW[14] & ~SW[13] & SW[12])
  ||||              ||||
  ||||              ||||
  ||||              ||||
  ||||              ||||
  ||5|              ||1|
  ||||              ||||
  ||||              ||||
  ||||              ||||
  ||||              ||||
  |||+------6-------++||
  |||+--------------++||
  ||||              ||||
  ||||              ||||
  ||||              ||||
  |4||              ||2|
  ||||              ||||
  ||||              ||||
  ||||              ||||
  ||||              ||||
  ||+--------3-------+||
  +--------------------+
					       	
*****************************************************************
*/


module b2d_7seg (X,SSD);

input [3:0] X;
output [0:6] SSD;

assign SSD[0] = ((~X[3] & ~X[2] & ~X[1] & X[0]) | (~X[3] & X[2] & ~X[1] & ~X[0]) | (X[3] & ~X[2] & X[1] & ~X[0]));
assign SSD[1] = ((~X[3] & X[2] & ~X[1] & X[0]) | (~X[3] & X[2] & X[1] & ~X[0]) | (X[3] & ~X[2] & X[1] & ~X[0]) | (X[3] & ~X[2] & X[1] & X[0]) | (X[3] & X[2] & X[1] & X[0]) | (X[3] & X[2] & X[1] & ~X[0]) | (X[3] & X[2] & ~X[1] & ~X[0]) | (X[3] & X[2] & ~X[1] & X[0]));
assign SSD[2] = ((~X[3] & ~X[2] & X[1] & ~X[0]) | (X[3] & ~X[2] & X[1] & ~X[0]) | (X[3] & ~X[2] & X[1] & X[0]) | (X[3] & X[2] & X[1] & X[0]) | (X[3] & X[2] & X[1] & ~X[0]) | (X[3] & X[2] & ~X[1] & ~X[0]) | (X[3] & X[2] & ~X[1] & X[0]));
assign SSD[3] = ((~X[3] & ~X[2] & ~X[1] & X[0]) | (~X[3] & X[2] & ~X[1] & ~X[0]) | (~X[3] & X[2] & X[1] & X[0]));
assign SSD[4] = ((~X[3] & ~X[2] & ~X[1] & X[0]) | (~X[3] & ~X[2] & X[1] & X[0]) | (~X[3] & X[2] & ~X[1] & ~X[0]) | (~X[3] & X[2] & ~X[1] & X[0]) | (X[3] & ~X[2] & ~X[1] & X[0]) | (~X[3] & X[2] & X[1] & X[0]));
assign SSD[5] = ((~X[3] & ~X[2] & ~X[1] & X[0]) | (~X[3] & ~X[2] & X[1] & ~X[0]) | (~X[3] & ~X[2] & X[1] & X[0]) | (~X[3] & X[2] & X[1] & X[0]));
assign SSD[6] = ((~X[3] & ~X[2] & ~X[1] & X[0]) | (~X[3] & ~X[2] & ~X[1] & ~X[0]) | (~X[3] & X[2] & X[1] & X[0]));

endmodule