''
''
'' odemath -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __ode_odemath_bi__
#define __ode_odemath_bi__

#include once "ode/common.bi"

declare sub dNormalize3 cdecl alias "dNormalize3" (byval a as dVector3)
declare sub dNormalize4 cdecl alias "dNormalize4" (byval a as dVector4)
declare sub dPlaneSpace cdecl alias "dPlaneSpace" (byval n as dVector3, byval p as dVector3, byval q as dVector3)

#endif
