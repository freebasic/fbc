''
''
'' misc -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __misc_bi__
#define __misc_bi__

#include once "ode/common.bi"

declare function dTestRand cdecl alias "dTestRand" () as integer
declare function dRand cdecl alias "dRand" () as uinteger
declare function dRandGetSeed cdecl alias "dRandGetSeed" () as uinteger
declare sub dRandSetSeed cdecl alias "dRandSetSeed" (byval s as uinteger)
declare function dRandInt cdecl alias "dRandInt" (byval n as integer) as integer
declare function dRandReal cdecl alias "dRandReal" () as dReal
declare sub dPrintMatrix cdecl alias "dPrintMatrix" (byval A as dReal ptr, byval n as integer, byval m as integer, byval fmt as zstring ptr, byval f as FILE ptr)
declare sub dMakeRandomVector cdecl alias "dMakeRandomVector" (byval A as dReal ptr, byval n as integer, byval range as dReal)
declare sub dMakeRandomMatrix cdecl alias "dMakeRandomMatrix" (byval A as dReal ptr, byval n as integer, byval m as integer, byval range as dReal)
declare sub dClearUpperTriangle cdecl alias "dClearUpperTriangle" (byval A as dReal ptr, byval n as integer)
declare function dMaxDifference cdecl alias "dMaxDifference" (byval A as dReal ptr, byval B as dReal ptr, byval n as integer, byval m as integer) as dReal
declare function dMaxDifferenceLowerTriangle cdecl alias "dMaxDifferenceLowerTriangle" (byval A as dReal ptr, byval B as dReal ptr, byval n as integer) as dReal

#endif
