#ifndef __ode_odemath_bi__
#define __ode_odemath_bi__

#include once "common.bi"

declare sub dNormalize3 cdecl alias "dNormalize3" ( a as dVector3 ptr)
declare sub dNormalize4 cdecl alias "dNormalize4" ( a as dVector4 ptr)
declare sub dPlaneSpace cdecl alias "dPlaneSpace" ( n as dVector3 ptr, _
                                                    p as dVector3 ptr, _
                                                    q as dVector3 ptr)

#define dACCESS33(A,i,j) ((A)[(i)*4+(j)])

#macro dOP(a,op,b,c)
    (a)[0] = ((b)[0]) op ((c)[0]):
    (a)[1] = ((b)[1]) op ((c)[1]):
    (a)[2] = ((b)[2]) op ((c)[2]):
#endmacro
#macro dOPC(a,op,b,c)
    (a)[0] = ((b)[0]) op (c):
    (a)[1] = ((b)[1]) op (c):
    (a)[2] = ((b)[2]) op (c):
#endmacro
#macro dOPE(a,op,b)
    (a)[0] op ((b)[0]):
    (a)[1] op ((b)[1]):
    (a)[2] op ((b)[2]):
#endmacro
#macro dOPEC(a,op,c)
    (a)[0] op (c):
    (a)[1] op (c):
    (a)[2] op (c):
#endmacro

#define dLENGTHSQUARED(a) (((a)[0])*((a)[0]) + ((a)[1])*((a)[1]) + ((a)[2])*((a)[2]))

#define dLENGTH(a) ( dSqrt( ((a)[0])*((a)[0]) + ((a)[1])*((a)[1]) + ((a)[2])*((a)[2]) ) )

#define dDOTpq(a,b,p,q) ((a)[0]*(b)[0] + (a)[p]*(b)[q] + (a)[2*(p)]*(b)[2*(q)])

#define dDOT(a,b)   dDOTpq(a,b,1,1)
#define dDOT13(a,b) dDOTpq(a,b,1,3)
#define dDOT31(a,b) dDOTpq(a,b,3,1)
#define dDOT33(a,b) dDOTpq(a,b,3,3)
#define dDOT14(a,b) dDOTpq(a,b,1,4)
#define dDOT41(a,b) dDOTpq(a,b,4,1)
#define dDOT44(a,b) dDOTpq(a,b,4,4)

#macro dCROSS(a,op,b,c)
  (a)[0] op ((b)[1]*(c)[2] - (b)[2]*(c)[1]):
  (a)[1] op ((b)[2]*(c)[0] - (b)[0]*(c)[2]):
  (a)[2] op ((b)[0]*(c)[1] - (b)[1]*(c)[0]):
#endmacro
#macro dCROSSpqr(a,op,b,c,p,q,r)
  (a)[  0] op ((b)[  q]*(c)[2*r] - (b)[2*q]*(c)[  r]):
  (a)[  p] op ((b)[2*q]*(c)[  0] - (b)[  0]*(c)[2*r]):
  (a)[2*p] op ((b)[  0]*(c)[  r] - (b)[  q]*(c)[  0]):
#endmacro

#define dCROSS114(a,op,b,c) dCROSSpqr(a,op,b,c,1,1,4)
#define dCROSS141(a,op,b,c) dCROSSpqr(a,op,b,c,1,4,1)
#define dCROSS144(a,op,b,c) dCROSSpqr(a,op,b,c,1,4,4)
#define dCROSS411(a,op,b,c) dCROSSpqr(a,op,b,c,4,1,1)
#define dCROSS414(a,op,b,c) dCROSSpqr(a,op,b,c,4,1,4)
#define dCROSS441(a,op,b,c) dCROSSpqr(a,op,b,c,4,4,1)
#define dCROSS444(a,op,b,c) dCROSSpqr(a,op,b,c,4,4,4)

#macro dDISTANCE(a,b) \
	dSqrt( ((a)[0]-(b)[0])*((a)[0]-(b)[0]) _
      + ((a)[1]-(b)[1])*((a)[1]-(b)[1]) _
      + ((a)[2]-(b)[2])*((a)[2]-(b)[2]) )
#endmacro

#macro dMULTIPLYOP0_331(A,op,B,C)
  (A)[0] op dDOT((B),(C)):
  (A)[1] op dDOT((B+4),(C)):
  (A)[2] op dDOT((B+8),(C)):
#endmacro

#macro dMULTIPLYOP1_331(A,op,B,C)
  (A)[0] op dDOT41((B),(C)):
  (A)[1] op dDOT41((B+1),(C)):
  (A)[2] op dDOT41((B+2),(C)):
#endmacro

#macro dMULTIPLYOP0_133(A,op,B,C)
  (A)[0] op dDOT14((B),(C)):
  (A)[1] op dDOT14((B),(C+1)):
  (A)[2] op dDOT14((B),(C+2)):
#endmacro

#macro dMULTIPLYOP0_333(A,op,B,C)
  (A)[0] op dDOT14((B),(C)):
  (A)[1] op dDOT14((B),(C+1)):
  (A)[2] op dDOT14((B),(C+2)):
  (A)[4] op dDOT14((B+4),(C)):
  (A)[5] op dDOT14((B+4),(C+1)):
  (A)[6] op dDOT14((B+4),(C+2)):
  (A)[8] op dDOT14((B+8),(C)):
  (A)[9] op dDOT14((B+8),(C+1)):
  (A)[10] op dDOT14((B+8),(C+2)):
#endmacro

#macro dMULTIPLYOP1_333(A,op,B,C)
  (A)[0] op dDOT44((B),(C)):
  (A)[1] op dDOT44((B),(C+1)):
  (A)[2] op dDOT44((B),(C+2)):
  (A)[4] op dDOT44((B+1),(C)):
  (A)[5] op dDOT44((B+1),(C+1)):
  (A)[6] op dDOT44((B+1),(C+2)):
  (A)[8] op dDOT44((B+2),(C)):
  (A)[9] op dDOT44((B+2),(C+1)):
  (A)[10] op dDOT44((B+2),(C+2)):
#endmacro

#macro dMULTIPLYOP2_333(A,op,B,C)
  (A)[0] op dDOT((B),(C)):
  (A)[1] op dDOT((B),(C+4)):
  (A)[2] op dDOT((B),(C+8)):
  (A)[4] op dDOT((B+4),(C)):
  (A)[5] op dDOT((B+4),(C+4)):
  (A)[6] op dDOT((B+4),(C+8)):
  (A)[8] op dDOT((B+8),(C)):
  (A)[9] op dDOT((B+8),(C+4)):
  (A)[10] op dDOT((B+8),(C+8)):
#endmacro


#define dMULTIPLY0_331(A,B,C) dMULTIPLYOP0_331(A,=,B,C)
#define dMULTIPLY1_331(A,B,C) dMULTIPLYOP1_331(A,=,B,C)
#define dMULTIPLY0_133(A,B,C) dMULTIPLYOP0_133(A,=,B,C)
#define dMULTIPLY0_333(A,B,C) dMULTIPLYOP0_333(A,=,B,C)
#define dMULTIPLY1_333(A,B,C) dMULTIPLYOP1_333(A,=,B,C)
#define dMULTIPLY2_333(A,B,C) dMULTIPLYOP2_333(A,=,B,C)

#define dMULTIPLYADD0_331(A,B,C) dMULTIPLYOP0_331(A,+=,B,C)
#define dMULTIPLYADD1_331(A,B,C) dMULTIPLYOP1_331(A,+=,B,C)
#define dMULTIPLYADD0_133(A,B,C) dMULTIPLYOP0_133(A,+=,B,C)
#define dMULTIPLYADD0_333(A,B,C) dMULTIPLYOP0_333(A,+=,B,C)
#define dMULTIPLYADD1_333(A,B,C) dMULTIPLYOP1_333(A,+=,B,C)
#define dMULTIPLYADD2_333(A,B,C) dMULTIPLYOP2_333(A,+=,B,C)

#endif ' __ode_odemath_bi__
