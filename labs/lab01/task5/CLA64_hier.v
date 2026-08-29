module cla64_hier(
  input  [63:0] a,
  input  [63:0] b,
  input         cin,
  output [63:0] sum,
  output        cout
);

  // Carry between the 16 CLA4 blocks
  wire [16:0] c;

  // Block propagate and generate
  wire [15:0] Pblk;
  wire [15:0] Gblk;

  assign c[0] = cin;

  // --------------------------------------------------
  // 16 x 4-bit CLA blocks
  // --------------------------------------------------

  cla4 block0 (
    .a(a[3:0]),
    .b(b[3:0]),
    .cin(c[0]),
    .sum(sum[3:0]),
    .cout(),
    .Pblk(Pblk[0]),
    .Gblk(Gblk[0])
  );

  cla4 block1 (
    .a(a[7:4]),
    .b(b[7:4]),
    .cin(c[1]),
    .sum(sum[7:4]),
    .cout(),
    .Pblk(Pblk[1]),
    .Gblk(Gblk[1])
  );

  cla4 block2 (
    .a(a[11:8]),
    .b(b[11:8]),
    .cin(c[2]),
    .sum(sum[11:8]),
    .cout(),
    .Pblk(Pblk[2]),
    .Gblk(Gblk[2])
  );

  cla4 block3 (
    .a(a[15:12]),
    .b(b[15:12]),
    .cin(c[3]),
    .sum(sum[15:12]),
    .cout(),
    .Pblk(Pblk[3]),
    .Gblk(Gblk[3])
  );

  cla4 block4 (
    .a(a[19:16]),
    .b(b[19:16]),
    .cin(c[4]),
    .sum(sum[19:16]),
    .cout(),
    .Pblk(Pblk[4]),
    .Gblk(Gblk[4])
  );

  cla4 block5 (
    .a(a[23:20]),
    .b(b[23:20]),
    .cin(c[5]),
    .sum(sum[23:20]),
    .cout(),
    .Pblk(Pblk[5]),
    .Gblk(Gblk[5])
  );

  cla4 block6 (
    .a(a[27:24]),
    .b(b[27:24]),
    .cin(c[6]),
    .sum(sum[27:24]),
    .cout(),
    .Pblk(Pblk[6]),
    .Gblk(Gblk[6])
  );

  cla4 block7 (
    .a(a[31:28]),
    .b(b[31:28]),
    .cin(c[7]),
    .sum(sum[31:28]),
    .cout(),
    .Pblk(Pblk[7]),
    .Gblk(Gblk[7])
  );

  cla4 block8 (
    .a(a[35:32]),
    .b(b[35:32]),
    .cin(c[8]),
    .sum(sum[35:32]),
    .cout(),
    .Pblk(Pblk[8]),
    .Gblk(Gblk[8])
  );

  cla4 block9 (
    .a(a[39:36]),
    .b(b[39:36]),
    .cin(c[9]),
    .sum(sum[39:36]),
    .cout(),
    .Pblk(Pblk[9]),
    .Gblk(Gblk[9])
  );

  cla4 block10 (
    .a(a[43:40]),
    .b(b[43:40]),
    .cin(c[10]),
    .sum(sum[43:40]),
    .cout(),
    .Pblk(Pblk[10]),
    .Gblk(Gblk[10])
  );

  cla4 block11 (
    .a(a[47:44]),
    .b(b[47:44]),
    .cin(c[11]),
    .sum(sum[47:44]),
    .cout(),
    .Pblk(Pblk[11]),
    .Gblk(Gblk[11])
  );

  cla4 block12 (
    .a(a[51:48]),
    .b(b[51:48]),
    .cin(c[12]),
    .sum(sum[51:48]),
    .cout(),
    .Pblk(Pblk[12]),
    .Gblk(Gblk[12])
  );

  cla4 block13 (
    .a(a[55:52]),
    .b(b[55:52]),
    .cin(c[13]),
    .sum(sum[55:52]),
    .cout(),
    .Pblk(Pblk[13]),
    .Gblk(Gblk[13])
  );

  cla4 block14 (
    .a(a[59:56]),
    .b(b[59:56]),
    .cin(c[14]),
    .sum(sum[59:56]),
    .cout(),
    .Pblk(Pblk[14]),
    .Gblk(Gblk[14])
  );

  cla4 block15 (
    .a(a[63:60]),
    .b(b[63:60]),
    .cin(c[15]),
    .sum(sum[63:60]),
    .cout(),
    .Pblk(Pblk[15]),
    .Gblk(Gblk[15])
  );

  // --------------------------------------------------
  // Second-level carry lookahead
  // --------------------------------------------------

  assign #(2) c[1] =
      Gblk[0]
    | (Pblk[0] & cin);

  assign #(2) c[2] =
      Gblk[1]
    | (Pblk[1] & Gblk[0])
    | (Pblk[1] & Pblk[0] & cin);

  assign #(2) c[3] =
      Gblk[2]
    | (Pblk[2] & Gblk[1])
    | (Pblk[2] & Pblk[1] & Gblk[0])
    | (Pblk[2] & Pblk[1] & Pblk[0] & cin);

  assign #(2) c[4] =
      Gblk[3]
    | (Pblk[3] & Gblk[2])
    | (Pblk[3] & Pblk[2] & Gblk[1])
    | (Pblk[3] & Pblk[2] & Pblk[1] & Gblk[0])
    | (Pblk[3] & Pblk[2] & Pblk[1] & Pblk[0] & cin);

  assign #(2) c[5] =
      Gblk[4]
    | (Pblk[4] & Gblk[3])
    | (Pblk[4] & Pblk[3] & Gblk[2])
    | (Pblk[4] & Pblk[3] & Pblk[2] & Gblk[1])
    | (Pblk[4] & Pblk[3] & Pblk[2] & Pblk[1] & Gblk[0])
    | (Pblk[4] & Pblk[3] & Pblk[2] & Pblk[1] & Pblk[0] & cin);

  assign #(2) c[6] =
      Gblk[5]
    | (Pblk[5] & Gblk[4])
    | (Pblk[5] & Pblk[4] & Gblk[3])
    | (Pblk[5] & Pblk[4] & Pblk[3] & Gblk[2])
    | (Pblk[5] & Pblk[4] & Pblk[3] & Pblk[2] & Gblk[1])
    | (Pblk[5] & Pblk[4] & Pblk[3] & Pblk[2] & Pblk[1] & Gblk[0])
    | (Pblk[5] & Pblk[4] & Pblk[3] & Pblk[2] & Pblk[1] & Pblk[0] & cin);

  assign #(2) c[7] =
      Gblk[6]
    | (Pblk[6] & Gblk[5])
    | (Pblk[6] & Pblk[5] & Gblk[4])
    | (Pblk[6] & Pblk[5] & Pblk[4] & Gblk[3])
    | (Pblk[6] & Pblk[5] & Pblk[4] & Pblk[3] & Gblk[2])
    | (Pblk[6] & Pblk[5] & Pblk[4] & Pblk[3] & Pblk[2] & Gblk[1])
    | (Pblk[6] & Pblk[5] & Pblk[4] & Pblk[3] & Pblk[2] & Pblk[1] & Gblk[0])
    | (Pblk[6] & Pblk[5] & Pblk[4] & Pblk[3] & Pblk[2] & Pblk[1] & Pblk[0] & cin);

  assign #(2) c[8] =
      Gblk[7]
    | (Pblk[7] & Gblk[6])
    | (Pblk[7] & Pblk[6] & Gblk[5])
    | (Pblk[7] & Pblk[6] & Pblk[5] & Gblk[4])
    | (Pblk[7] & Pblk[6] & Pblk[5] & Pblk[4] & Gblk[3])
    | (Pblk[7] & Pblk[6] & Pblk[5] & Pblk[4] & Pblk[3] & Gblk[2])
    | (Pblk[7] & Pblk[6] & Pblk[5] & Pblk[4] & Pblk[3] & Pblk[2] & Gblk[1])
    | (Pblk[7] & Pblk[6] & Pblk[5] & Pblk[4] & Pblk[3] & Pblk[2] & Pblk[1] & Gblk[0])
    | (Pblk[7] & Pblk[6] & Pblk[5] & Pblk[4] & Pblk[3] & Pblk[2] & Pblk[1] & Pblk[0] & cin);

  assign #(2) c[9] =
      Gblk[8]
    | (Pblk[8] & Gblk[7])
    | (Pblk[8] & Pblk[7] & Gblk[6])
    | (Pblk[8] & Pblk[7] & Pblk[6] & Gblk[5])
    | (Pblk[8] & Pblk[7] & Pblk[6] & Pblk[5] & Gblk[4])
    | (Pblk[8] & Pblk[7] & Pblk[6] & Pblk[5] & Pblk[4] & Gblk[3])
    | (Pblk[8] & Pblk[7] & Pblk[6] & Pblk[5] & Pblk[4] & Pblk[3] & Gblk[2])
    | (Pblk[8] & Pblk[7] & Pblk[6] & Pblk[5] & Pblk[4] & Pblk[3] & Pblk[2] & Gblk[1])
    | (Pblk[8] & Pblk[7] & Pblk[6] & Pblk[5] & Pblk[4] & Pblk[3] & Pblk[2] & Pblk[1] & Gblk[0])
    | (Pblk[8] & Pblk[7] & Pblk[6] & Pblk[5] & Pblk[4] & Pblk[3] & Pblk[2] & Pblk[1] & Pblk[0] & cin);

  assign #(2) c[10] =
      Gblk[9]
    | (Pblk[9] & Gblk[8])
    | (Pblk[9] & Pblk[8] & Gblk[7])
    | (Pblk[9] & Pblk[8] & Pblk[7] & Gblk[6])
    | (Pblk[9] & Pblk[8] & Pblk[7] & Pblk[6] & Gblk[5])
    | (Pblk[9] & Pblk[8] & Pblk[7] & Pblk[6] & Pblk[5] & Gblk[4])
    | (Pblk[9] & Pblk[8] & Pblk[7] & Pblk[6] & Pblk[5] & Pblk[4] & Gblk[3])
    | (Pblk[9] & Pblk[8] & Pblk[7] & Pblk[6] & Pblk[5] & Pblk[4] & Pblk[3] & Gblk[2])
    | (Pblk[9] & Pblk[8] & Pblk[7] & Pblk[6] & Pblk[5] & Pblk[4] & Pblk[3] & Pblk[2] & Gblk[1])
    | (Pblk[9] & Pblk[8] & Pblk[7] & Pblk[6] & Pblk[5] & Pblk[4] & Pblk[3] & Pblk[2] & Pblk[1] & Gblk[0])
    | (Pblk[9] & Pblk[8] & Pblk[7] & Pblk[6] & Pblk[5] & Pblk[4] & Pblk[3] & Pblk[2] & Pblk[1] & Pblk[0] & cin);

  assign #(2) c[11] =
      Gblk[10]
    | (Pblk[10] & Gblk[9])
    | (Pblk[10] & Pblk[9] & Gblk[8])
    | (Pblk[10] & Pblk[9] & Pblk[8] & Gblk[7])
    | (Pblk[10] & Pblk[9] & Pblk[8] & Pblk[7] & Gblk[6])
    | (Pblk[10] & Pblk[9] & Pblk[8] & Pblk[7] & Pblk[6] & Gblk[5])
    | (Pblk[10] & Pblk[9] & Pblk[8] & Pblk[7] & Pblk[6] & Pblk[5] & Gblk[4])
    | (Pblk[10] & Pblk[9] & Pblk[8] & Pblk[7] & Pblk[6] & Pblk[5] & Pblk[4] & Gblk[3])
    | (Pblk[10] & Pblk[9] & Pblk[8] & Pblk[7] & Pblk[6] & Pblk[5] & Pblk[4] & Pblk[3] & Gblk[2])
    | (Pblk[10] & Pblk[9] & Pblk[8] & Pblk[7] & Pblk[6] & Pblk[5] & Pblk[4] & Pblk[3] & Pblk[2] & Gblk[1])
    | (Pblk[10] & Pblk[9] & Pblk[8] & Pblk[7] & Pblk[6] & Pblk[5] & Pblk[4] & Pblk[3] & Pblk[2] & Pblk[1] & Gblk[0])
    | (Pblk[10] & Pblk[9] & Pblk[8] & Pblk[7] & Pblk[6] & Pblk[5] & Pblk[4] & Pblk[3] & Pblk[2] & Pblk[1] & Pblk[0] & cin);

  assign #(2) c[12] =
      Gblk[11]
    | (Pblk[11] & Gblk[10])
    | (Pblk[11] & Pblk[10] & Gblk[9])
    | (Pblk[11] & Pblk[10] & Pblk[9] & Gblk[8])
    | (Pblk[11] & Pblk[10] & Pblk[9] & Pblk[8] & Gblk[7])
    | (Pblk[11] & Pblk[10] & Pblk[9] & Pblk[8] & Pblk[7] & Gblk[6])
    | (Pblk[11] & Pblk[10] & Pblk[9] & Pblk[8] & Pblk[7] & Pblk[6] & Gblk[5])
    | (Pblk[11] & Pblk[10] & Pblk[9] & Pblk[8] & Pblk[7] & Pblk[6] & Pblk[5] & Gblk[4])
    | (Pblk[11] & Pblk[10] & Pblk[9] & Pblk[8] & Pblk[7] & Pblk[6] & Pblk[5] & Pblk[4] & Gblk[3])
    | (Pblk[11] & Pblk[10] & Pblk[9] & Pblk[8] & Pblk[7] & Pblk[6] & Pblk[5] & Pblk[4] & Pblk[3] & Gblk[2])
    | (Pblk[11] & Pblk[10] & Pblk[9] & Pblk[8] & Pblk[7] & Pblk[6] & Pblk[5] & Pblk[4] & Pblk[3] & Pblk[2] & Gblk[1])
    | (Pblk[11] & Pblk[10] & Pblk[9] & Pblk[8] & Pblk[7] & Pblk[6] & Pblk[5] & Pblk[4] & Pblk[3] & Pblk[2] & Pblk[1] & Gblk[0])
    | (Pblk[11] & Pblk[10] & Pblk[9] & Pblk[8] & Pblk[7] & Pblk[6] & Pblk[5] & Pblk[4] & Pblk[3] & Pblk[2] & Pblk[1] & Pblk[0] & cin);

  assign #(2) c[13] =
      Gblk[12]
    | (Pblk[12] & Gblk[11])
    | (Pblk[12] & Pblk[11] & Gblk[10])
    | (Pblk[12] & Pblk[11] & Pblk[10] & Gblk[9])
    | (Pblk[12] & Pblk[11] & Pblk[10] & Pblk[9] & Gblk[8])
    | (Pblk[12] & Pblk[11] & Pblk[10] & Pblk[9] & Pblk[8] & Gblk[7])
    | (Pblk[12] & Pblk[11] & Pblk[10] & Pblk[9] & Pblk[8] & Pblk[7] & Gblk[6])
    | (Pblk[12] & Pblk[11] & Pblk[10] & Pblk[9] & Pblk[8] & Pblk[7] & Pblk[6] & Gblk[5])
    | (Pblk[12] & Pblk[11] & Pblk[10] & Pblk[9] & Pblk[8] & Pblk[7] & Pblk[6] & Pblk[5] & Gblk[4])
    | (Pblk[12] & Pblk[11] & Pblk[10] & Pblk[9] & Pblk[8] & Pblk[7] & Pblk[6] & Pblk[5] & Pblk[4] & Gblk[3])
    | (Pblk[12] & Pblk[11] & Pblk[10] & Pblk[9] & Pblk[8] & Pblk[7] & Pblk[6] & Pblk[5] & Pblk[4] & Pblk[3] & Gblk[2])
    | (Pblk[12] & Pblk[11] & Pblk[10] & Pblk[9] & Pblk[8] & Pblk[7] & Pblk[6] & Pblk[5] & Pblk[4] & Pblk[3] & Pblk[2] & Gblk[1])
    | (Pblk[12] & Pblk[11] & Pblk[10] & Pblk[9] & Pblk[8] & Pblk[7] & Pblk[6] & Pblk[5] & Pblk[4] & Pblk[3] & Pblk[2] & Pblk[1] & Gblk[0])
    | (Pblk[12] & Pblk[11] & Pblk[10] & Pblk[9] & Pblk[8] & Pblk[7] & Pblk[6] & Pblk[5] & Pblk[4] & Pblk[3] & Pblk[2] & Pblk[1] & Pblk[0] & cin);

  assign #(2) c[14] =
      Gblk[13]
    | (Pblk[13] & Gblk[12])
    | (Pblk[13] & Pblk[12] & Gblk[11])
    | (Pblk[13] & Pblk[12] & Pblk[11] & Gblk[10])
    | (Pblk[13] & Pblk[12] & Pblk[11] & Pblk[10] & Gblk[9])
    | (Pblk[13] & Pblk[12] & Pblk[11] & Pblk[10] & Pblk[9] & Gblk[8])
    | (Pblk[13] & Pblk[12] & Pblk[11] & Pblk[10] & Pblk[9] & Pblk[8] & Gblk[7])
    | (Pblk[13] & Pblk[12] & Pblk[11] & Pblk[10] & Pblk[9] & Pblk[8] & Pblk[7] & Gblk[6])
    | (Pblk[13] & Pblk[12] & Pblk[11] & Pblk[10] & Pblk[9] & Pblk[8] & Pblk[7] & Pblk[6] & Gblk[5])
    | (Pblk[13] & Pblk[12] & Pblk[11] & Pblk[10] & Pblk[9] & Pblk[8] & Pblk[7] & Pblk[6] & Pblk[5] & Gblk[4])
    | (Pblk[13] & Pblk[12] & Pblk[11] & Pblk[10] & Pblk[9] & Pblk[8] & Pblk[7] & Pblk[6] & Pblk[5] & Pblk[4] & Gblk[3])
    | (Pblk[13] & Pblk[12] & Pblk[11] & Pblk[10] & Pblk[9] & Pblk[8] & Pblk[7] & Pblk[6] & Pblk[5] & Pblk[4] & Pblk[3] & Gblk[2])
    | (Pblk[13] & Pblk[12] & Pblk[11] & Pblk[10] & Pblk[9] & Pblk[8] & Pblk[7] & Pblk[6] & Pblk[5] & Pblk[4] & Pblk[3] & Pblk[2] & Gblk[1])
    | (Pblk[13] & Pblk[12] & Pblk[11] & Pblk[10] & Pblk[9] & Pblk[8] & Pblk[7] & Pblk[6] & Pblk[5] & Pblk[4] & Pblk[3] & Pblk[2] & Pblk[1] & Gblk[0])
    | (Pblk[13] & Pblk[12] & Pblk[11] & Pblk[10] & Pblk[9] & Pblk[8] & Pblk[7] & Pblk[6] & Pblk[5] & Pblk[4] & Pblk[3] & Pblk[2] & Pblk[1] & Pblk[0] & cin);

  assign #(2) c[15] =
      Gblk[14]
    | (Pblk[14] & Gblk[13])
    | (Pblk[14] & Pblk[13] & Gblk[12])
    | (Pblk[14] & Pblk[13] & Pblk[12] & Gblk[11])
    | (Pblk[14] & Pblk[13] & Pblk[12] & Pblk[11] & Gblk[10])
    | (Pblk[14] & Pblk[13] & Pblk[12] & Pblk[11] & Pblk[10] & Gblk[9])
    | (Pblk[14] & Pblk[13] & Pblk[12] & Pblk[11] & Pblk[10] & Pblk[9] & Gblk[8])
    | (Pblk[14] & Pblk[13] & Pblk[12] & Pblk[11] & Pblk[10] & Pblk[9] & Pblk[8] & Gblk[7])
    | (Pblk[14] & Pblk[13] & Pblk[12] & Pblk[11] & Pblk[10] & Pblk[9] & Pblk[8] & Pblk[7] & Gblk[6])
    | (Pblk[14] & Pblk[13] & Pblk[12] & Pblk[11] & Pblk[10] & Pblk[9] & Pblk[8] & Pblk[7] & Pblk[6] & Gblk[5])
    | (Pblk[14] & Pblk[13] & Pblk[12] & Pblk[11] & Pblk[10] & Pblk[9] & Pblk[8] & Pblk[7] & Pblk[6] & Pblk[5] & Gblk[4])
    | (Pblk[14] & Pblk[13] & Pblk[12] & Pblk[11] & Pblk[10] & Pblk[9] & Pblk[8] & Pblk[7] & Pblk[6] & Pblk[5] & Pblk[4] & Gblk[3])
    | (Pblk[14] & Pblk[13] & Pblk[12] & Pblk[11] & Pblk[10] & Pblk[9] & Pblk[8] & Pblk[7] & Pblk[6] & Pblk[5] & Pblk[4] & Pblk[3] & Gblk[2])
    | (Pblk[14] & Pblk[13] & Pblk[12] & Pblk[11] & Pblk[10] & Pblk[9] & Pblk[8] & Pblk[7] & Pblk[6] & Pblk[5] & Pblk[4] & Pblk[3] & Pblk[2] & Gblk[1])
    | (Pblk[14] & Pblk[13] & Pblk[12] & Pblk[11] & Pblk[10] & Pblk[9] & Pblk[8] & Pblk[7] & Pblk[6] & Pblk[5] & Pblk[4] & Pblk[3] & Pblk[2] & Pblk[1] & Gblk[0])
    | (Pblk[14] & Pblk[13] & Pblk[12] & Pblk[11] & Pblk[10] & Pblk[9] & Pblk[8] & Pblk[7] & Pblk[6] & Pblk[5] & Pblk[4] & Pblk[3] & Pblk[2] & Pblk[1] & Pblk[0] & cin);

  assign #(2) c[16] =
      Gblk[15]
    | (Pblk[15] & Gblk[14])
    | (Pblk[15] & Pblk[14] & Gblk[13])
    | (Pblk[15] & Pblk[14] & Pblk[13] & Gblk[12])
    | (Pblk[15] & Pblk[14] & Pblk[13] & Pblk[12] & Gblk[11])
    | (Pblk[15] & Pblk[14] & Pblk[13] & Pblk[12] & Pblk[11] & Gblk[10])
    | (Pblk[15] & Pblk[14] & Pblk[13] & Pblk[12] & Pblk[11] & Pblk[10] & Gblk[9])
    | (Pblk[15] & Pblk[14] & Pblk[13] & Pblk[12] & Pblk[11] & Pblk[10] & Pblk[9] & Gblk[8])
    | (Pblk[15] & Pblk[14] & Pblk[13] & Pblk[12] & Pblk[11] & Pblk[10] & Pblk[9] & Pblk[8] & Gblk[7])
    | (Pblk[15] & Pblk[14] & Pblk[13] & Pblk[12] & Pblk[11] & Pblk[10] & Pblk[9] & Pblk[8] & Pblk[7] & Gblk[6])
    | (Pblk[15] & Pblk[14] & Pblk[13] & Pblk[12] & Pblk[11] & Pblk[10] & Pblk[9] & Pblk[8] & Pblk[7] & Pblk[6] & Gblk[5])
    | (Pblk[15] & Pblk[14] & Pblk[13] & Pblk[12] & Pblk[11] & Pblk[10] & Pblk[9] & Pblk[8] & Pblk[7] & Pblk[6] & Pblk[5] & Gblk[4])
    | (Pblk[15] & Pblk[14] & Pblk[13] & Pblk[12] & Pblk[11] & Pblk[10] & Pblk[9] & Pblk[8] & Pblk[7] & Pblk[6] & Pblk[5] & Pblk[4] & Gblk[3])
    | (Pblk[15] & Pblk[14] & Pblk[13] & Pblk[12] & Pblk[11] & Pblk[10] & Pblk[9] & Pblk[8] & Pblk[7] & Pblk[6] & Pblk[5] & Pblk[4] & Pblk[3] & Gblk[2])
    | (Pblk[15] & Pblk[14] & Pblk[13] & Pblk[12] & Pblk[11] & Pblk[10] & Pblk[9] & Pblk[8] & Pblk[7] & Pblk[6] & Pblk[5] & Pblk[4] & Pblk[3] & Pblk[2] & Gblk[1])
    | (Pblk[15] & Pblk[14] & Pblk[13] & Pblk[12] & Pblk[11] & Pblk[10] & Pblk[9] & Pblk[8] & Pblk[7] & Pblk[6] & Pblk[5] & Pblk[4] & Pblk[3] & Pblk[2] & Pblk[1] & Gblk[0])
    | (Pblk[15] & Pblk[14] & Pblk[13] & Pblk[12] & Pblk[11] & Pblk[10] & Pblk[9] & Pblk[8] & Pblk[7] & Pblk[6] & Pblk[5] & Pblk[4] & Pblk[3] & Pblk[2] & Pblk[1] & Pblk[0] & cin);

  assign cout = c[16];

endmodule