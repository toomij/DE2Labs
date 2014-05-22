
module lab4_part1 (SW, KEY, LEDG, HEX3, HEX2, HEX1, HEX0);

	input [3:0] SW;
	input [3:0] KEY;
	
	output [7:0] LEDG;
	output [0:6] HEX3, HEX2, HEX1, HEX0;

	wire [7:0] Q;
	wire [3:0] Q2;

	counter_8bit C1 (SW[1], KEY[0], SW[0], Q);

endmodule

module counter_4bit (En, Clk, Clr, Q);
	input En, Clk, Clr;
	output [3:0] Q;

	wire [3:0] T, Qs;

	t_flipflop T0 (En, Clk, Clr, Qs[0]);
	assign T[0] = En & Qs[0];

	t_flipflop T1 (T[0], Clk, Clr, Qs[1]);
	assign T[1] = T[0] & Qs[1];

	t_flipflop T2 (T[1], Clk, Clr, Qs[2]);
	assign T[2] = T[1] & Qs[2];

	t_flipflop T3 (T[2], Clk, Clr, Qs[3]);
	assign T[3] = T[2] & Qs[3];

	assign Q = Qs;

endmodule


module counter_8bit (En, Clk, Clr, Q);
	input En, Clk, Clr;
	output [7:0] Q;

	wire [7:0] T, Qs;

	t_flipflop T0 (En, Clk, Clr, Qs[0]);
	assign T[0] = En & Qs[0];

	t_flipflop T1 (T[0], Clk, Clr, Qs[1]);
	assign T[1] = T[0] & Qs[1];

	t_flipflop T2 (T[1], Clk, Clr, Qs[2]);
	assign T[2] = T[1] & Qs[2];

	t_flipflop T3 (T[2], Clk, Clr, Qs[3]);
	assign T[3] = T[2] & Qs[3];

	t_flipflop T4 (T[3], Clk, Clr, Qs[4]);
	assign T[4] = T[3] & Qs[4];

	t_flipflop T5 (T[4], Clk, Clr, Qs[5]);
	assign T[5] = T[4] & Qs[5];

	t_flipflop T6 (T[5], Clk, Clr, Qs[6]);
	assign T[6] = T[5] & Qs[6];
	
	t_flipflop T7 (T[6], Clk, Clr, Qs[7]);
			
	assign Q = Qs;

endmodule

module t_flipflop (En, Clk, Clr, Q);
  input En, Clk, Clr;
  output reg Q;

  always @ (posedge Clk)
	if (~Clr) begin
		Q <= 1'b0;
	end else if (En) begin
		Q <= !Q;
	end

endmodule


