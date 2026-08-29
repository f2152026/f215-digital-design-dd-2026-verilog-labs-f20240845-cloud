// cla4_dataflow.v
// 4-bit carry-lookahead adder using dataflow modeling

module cla4_dataflow(
  input  [3:0] a,
  input  [3:0] b,
  input        cin,
  output [3:0] sum,
  output       cout
);

  wire p0, p1, p2, p3;
  wire g0, g1, g2, g3;
  wire c1, c2, c3, c4;

  // Propagate signals
  assign #(2) p0 = a[0] ^ b[0];
  assign #(2) p1 = a[1] ^ b[1];
  assign #(2) p2 = a[2] ^ b[2];
  assign #(2) p3 = a[3] ^ b[3];

  // Generate signals
  assign #(2) g0 = a[0] & b[0];
  assign #(2) g1 = a[1] & b[1];
  assign #(2) g2 = a[2] & b[2];
  assign #(2) g3 = a[3] & b[3];

  // Carry lookahead equations
  assign #(2) c1 = g0
                  | (p0 & cin);

  assign #(2) c2 = g1
                  | (p1 & g0)
                  | (p1 & p0 & cin);

  assign #(2) c3 = g2
                  | (p2 & g1)
                  | (p2 & p1 & g0)
                  | (p2 & p1 & p0 & cin);

  assign #(2) c4 = g3
                  | (p3 & g2)
                  | (p3 & p2 & g1)
                  | (p3 & p2 & p1 & g0)
                  | (p3 & p2 & p1 & p0 & cin);

  // Sum equations
  assign #(2) sum[0] = p0 ^ cin;
  assign #(2) sum[1] = p1 ^ c1;
  assign #(2) sum[2] = p2 ^ c2;
  assign #(2) sum[3] = p3 ^ c3;

  // Final carry
  assign #(2) cout = c4;

endmodule