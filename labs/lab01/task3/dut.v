module dut(
  input  [3:0] a,
  input  [3:0] b,
  input        cin,
  output [3:0] sum,
  output       cout
);

  // Option 1: Ripple-Carry Adder
  // rca U_IMPL (.a(a), .b(b), .cin(cin), .sum(sum), .cout(cout));

  // Option 2: Gate-Level Carry-Lookahead Adder
  // cla4 U_IMPL (.a(a), .b(b), .cin(cin), .sum(sum), .cout(cout));

  // Option 3: Dataflow Carry-Lookahead Adder
  cla4_dataflow U_IMPL (.a(a), .b(b), .cin(cin), .sum(sum), .cout(cout));

endmodule