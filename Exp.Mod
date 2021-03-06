ORP.Compile @\s  ORL.Link M0  ORL.StartV24  ORL.Load  ORL.Flush
TestTRM.SR  0~

MODULE M0;
  IMPORT RS232, SYSTEM;
  VAR x, y, z: REAL; k: INTEGER;

  PROCEDURE exp0(x: REAL): REAL;
    CONST
      c1 = 1.4426951;  (*1/ln(2) *)
      p0 = 1.513864173E3;
      p1 = 2.020170000E1;
      p2 = 2.309432127E-2;
      q0 = 4.368088670E3;
      q1 = 2.331782320E2;
    VAR n: INTEGER; p, y, yy: REAL;
  BEGIN y := c1*x;  (*1/ln(2)*)
    n := FLOOR(y + 0.5); y := y - FLT(n);
    yy := y*y;
    p := ((p2*yy + p1)*yy + p0)*y;
    p := p/((yy + q1)*yy + q0 - p) + 0.5;
    IF y < 0.0 THEN p := p+p ELSE n := n+1 END ;
    PACK(p, n); RETURN p
  END exp0;

  PROCEDURE exp1(x: REAL): REAL;
    CONST
      c1 = 1.44269504; (*1/ln(2) *)
      c2 = 7.21504768;
      c3 = 0.05769958;
      c4 = 20.8182288;
    VAR n: INTEGER; p, y, yy: REAL;
  BEGIN y := c1*x;  (*1/ln(2)*)
    n := FLOOR(y + 0.5); y := y - FLT(n);
    yy := y*y;
    p := (c2 + c3*yy)*y;
    p := p/(c4 + yy - p) + 0.5;
    IF y < 0.0 THEN p := p+p ELSE n := n+1 END ;
    PACK(p, n); RETURN p
  END exp1;

BEGIN SYSTEM.PUT(-60, 2);
  REPEAT 
    RS232.RecInt(k); x := 0.0;
    REPEAT RS232.SendReal(x); y := exp0(x); RS232.SendReal(y); z := exp0(-x); RS232.SendReal(z); RS232.SendReal(y*z - 1.0);
      y := exp1(x); RS232.SendReal(y); z := exp1(-x); RS232.SendReal(z); RS232.SendReal(y*z - 1.0);
      RS232.Line; x := x + 0.125
    UNTIL x > 2.0;
    RS232.End
  UNTIL FALSE
END M0.

  0.0000000E+00  1.0000000E+00  1.0000000E+00  0.0000000E+00  1.0000000E+00  1.0000000E+00  0.0000000E+00
  1.2500000E-01  1.1331484E+00  8.8249695E-01  0.0000000E+00  1.1331484E+00  8.8249695E-01  0.0000000E+00
  2.5000000E-01  1.2840253E+00  7.7880073E-01 -1.1920929E-07  1.2840253E+00  7.7880085E-01  0.0000000E+00
  3.7500000E-01  1.4549916E+00  6.8728924E-01  0.0000000E+00  1.4549913E+00  6.8728936E-01  0.0000000E+00
  5.0000000E-01  1.6487212E+00  6.0653067E-01  0.0000000E+00  1.6487212E+00  6.0653067E-01  0.0000000E+00
  6.2500000E-01  1.8682461E+00  5.3526139E-01  0.0000000E+00  1.8682461E+00  5.3526127E-01 -2.3841858E-07
  7.5000000E-01  2.1170001E+00  4.7236657E-01  0.0000000E+00  2.1169999E+00  4.7236609E-01 -1.0728836E-06
  8.7500000E-01  2.3988752E+00  4.1686201E-01  0.0000000E+00  2.3988750E+00  4.1686082E-01 -2.9802322E-06
  1.0000000E+00  2.7182820E+00  3.6787951E-01  2.3841858E-07  2.7182815E+00  3.6787641E-01 -8.3446503E-06
  1.1250000E+00  3.0802174E+00  3.2465243E-01  0.0000000E+00  3.0802169E+00  3.2465249E-01  0.0000000E+00
  1.2500000E+00  3.4903436E+00  2.8650481E-01  1.1920929E-07  3.4903431E+00  2.8650481E-01  0.0000000E+00
  1.3750000E+00  3.9550772E+00  2.5283957E-01  0.0000000E+00  3.9550772E+00  2.5283951E-01 -2.3841858E-07
  1.5000000E+00  4.4816895E+00  2.2313017E-01  0.0000000E+00  4.4816885E+00  2.2312987E-01 -1.4305115E-06
  1.6250000E+00  5.0784187E+00  1.9691169E-01  0.0000000E+00  5.0784178E+00  1.9691074E-01 -5.0067902E-06
  1.7500000E+00  5.7546034E+00  1.7377394E-01  1.1920929E-07  5.7546015E+00  1.7377397E-01  0.0000000E+00
  1.8750000E+00  6.5208197E+00  1.5335494E-01 -1.1920929E-07  6.5208187E+00  1.5335497E-01  0.0000000E+00
  2.0000000E+00  7.3890572E+00  1.3533527E-01  0.0000000E+00  7.3890562E+00  1.3533527E-01 -1.1920929E-07
