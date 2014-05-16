/* lab3_part5.v - 16-bit latch
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

 Range of hex:
 
 1111-1111-1111-1111
 0 - FFFF (65535)

				  HEX     7      6      5      4
                    +---+  +---+  +---+  +---+
                    |   |  |   |  |   |  |   |
                    | F |  | F |  | F |  | F |
                    +-+-+  +-+-+  +-+-+  +-+-+
                +-----+      |      +----+ |---------+
           +----+-----++-----+----++-----+----++-----+-----+
           |+--+--+--++++--+--+--++++--+--+--++++--+-++--+ |
           ||  |  |  ||||  |  |  ||||  |  |  ||||  |  |  | |
           |1  1  1  1||1  1  1  1||1  1  1  1||1  1  1  1 |
           +----------++----------++----------++-----------+
        SW 15 14 13 12  11 10 9  8  7  6  5  4  3  2  1  0

   +-----+--+                0         0123456
   |0000 | 0|             +-----+      0000001
   |0001 | 1|           5 |     | 1    1001111
   |0010 | 2|             |  6  |      0010010
   |0011 | 3|             +-----+      0001110
   |0100 | 4|           4 |     | 2    1001100
   |0101 | 5|             |     |      0100100
   |0110 | 6|             +-----+      0100000
   |0111 | 7|                3         0001111
   |1000 | 8|                          0000000
   |1001 | 9|                          0001100
   |1010 | A|                          0001000
   |1011 | B|                          1100000
   |1100 | C|                          0110001
   |1101 | D|                          1000010
   |1110 | E|                          0110000
   |1111 | F|                          0111000
   +-----+--+
	   
            |  |   |   |    |   |   |   |
     S    +-+--+---+---+----+---+---+---++
        --+D7  D6  D5  D4  D3  D2  D1  D0|
     Clk--+                              |
          |                              |
     R  --+Q7  Q6  Q5  Q4  Q3  Q2  Q1  Q0|
          +-+---+---+--+---+---+---+---+-+
            |   |   |  |   |   |   |   |
*/

module lab3_part5 (SW, HEX7, HEX6, HEX5, HEX4, HEX3, HEX2, HEX1, HEX0, KEY);
  input [3:0] KEY;
  input [17:0] SW;
  output [0:6] HEX7, HEX6, HEX5, HEX4, HEX3, HEX2, HEX1, HEX0;
  
  reg [15:0] R;
  wire [15:0] Q;

  D_ff_with_sync_clr F0  (~KEY[1], SW[0],  Q[0],  ~KEY[0]);
  D_ff_with_sync_clr F1  (~KEY[1], SW[1],  Q[1],  ~KEY[0]);
  D_ff_with_sync_clr F2  (~KEY[1], SW[2],  Q[2],  ~KEY[0]);
  D_ff_with_sync_clr F3  (~KEY[1], SW[3],  Q[3],  ~KEY[0]);
  D_ff_with_sync_clr F4  (~KEY[1], SW[4],  Q[4],  ~KEY[0]);
  D_ff_with_sync_clr F5  (~KEY[1], SW[5],  Q[5],  ~KEY[0]);
  D_ff_with_sync_clr F6  (~KEY[1], SW[6],  Q[6],  ~KEY[0]);
  D_ff_with_sync_clr F7  (~KEY[1], SW[7],  Q[7],  ~KEY[0]);
  D_ff_with_sync_clr F8  (~KEY[1], SW[8],  Q[8],  ~KEY[0]);
  D_ff_with_sync_clr F9  (~KEY[1], SW[9],  Q[9],  ~KEY[0]);
  D_ff_with_sync_clr F10 (~KEY[1], SW[10], Q[10], ~KEY[0]);
  D_ff_with_sync_clr F11 (~KEY[1], SW[11], Q[11], ~KEY[0]);
  D_ff_with_sync_clr F12 (~KEY[1], SW[12], Q[12], ~KEY[0]);
  D_ff_with_sync_clr F13 (~KEY[1], SW[13], Q[13], ~KEY[0]);
  D_ff_with_sync_clr F14 (~KEY[1], SW[14], Q[14], ~KEY[0]);
  D_ff_with_sync_clr F15 (~KEY[1], SW[15], Q[15], ~KEY[0]);
  
  always
    R = Q;

  hex_ssd H0 (SW[3:0], HEX0);
  hex_ssd H1 (SW[7:4], HEX1);
  hex_ssd H2 (SW[11:8], HEX2);
  hex_ssd H3 (SW[15:12], HEX3);
  hex_ssd H4 (R[3:0], HEX4);
  hex_ssd H5 (R[7:4], HEX5);
  hex_ssd H6 (R[11:8], HEX6);
  hex_ssd H7 (R[15:12], HEX7);

endmodule

module D_ff_with_sync_clr (Clk, D, Q, Clr);
  input Clk, D, Clr;
  output reg Q;
  always @ ( posedge Clk or posedge Clr)
	 if (Clr)
	 begin
		Q <= 1'b0;
	 end else
	 begin
		Q <= D;
	 end
endmodule

module hex_ssd (BIN, SSD);
  input [15:0] BIN;
  output reg [0:6] SSD;

  always begin
    case(BIN)
      0:SSD=7'b0000001;
      1:SSD=7'b1001111;
      2:SSD=7'b0010010;
      3:SSD=7'b0001110;
      4:SSD=7'b1001100;
      5:SSD=7'b0100100;
      6:SSD=7'b0100000;
      7:SSD=7'b0001111;
      8:SSD=7'b0000000;
      9:SSD=7'b0001100;
      10:SSD=7'b0001000;
      11:SSD=7'b1100000;
      12:SSD=7'b0110001;
      13:SSD=7'b1000010;
      14:SSD=7'b0110000;
      15:SSD=7'b0111000;
    endcase
  end
endmodule
