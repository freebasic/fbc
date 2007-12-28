#ifndef __ode_misc_bi__
#define __ode_misc_bi__

#include once "common.bi"
extern "C"

declare function dTestRand           () as integer
declare function dRand               () as uinteger
declare function dRandGetSeed        () as uinteger
declare sub      dRandSetSeed        (byval s as uinteger)
declare function dRandInt            (byval n as integer) as integer
declare function dRandReal           () as dReal
declare sub      dPrintMatrix        (byval A as dReal ptr, byval n as integer, byval m as integer, byval fmt as zstring ptr, byval f as FILE ptr)
declare sub      dMakeRandomVector   (byval A as dReal ptr, byval n as integer, byval range as dReal)
declare sub      dMakeRandomMatrix   (byval A as dReal ptr, byval n as integer, byval m as integer, byval range as dReal)
declare sub      dClearUpperTriangle (byval A as dReal ptr, byval n as integer)
declare function dMaxDifference      (byval A as dReal ptr, byval B as dReal ptr, byval n as integer, byval m as integer) as dReal
declare function dMaxDifferenceLowerTriangle (byval A as dReal ptr, byval B as dReal ptr, byval n as integer) as dReal

end extern
#endif
