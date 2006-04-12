''
''
'' matrix -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __ode_matrix_bi__
#define __ode_matrix_bi__

#include once "ode/common.bi"

declare sub dSetZero cdecl alias "dSetZero" (byval a as dReal ptr, byval n as integer)
declare sub dSetValue cdecl alias "dSetValue" (byval a as dReal ptr, byval n as integer, byval value as dReal)
declare function dDot cdecl alias "dDot" (byval a as dReal ptr, byval b as dReal ptr, byval n as integer) as dReal
declare sub dMultiply0 cdecl alias "dMultiply0" (byval A as dReal ptr, byval B as dReal ptr, byval C as dReal ptr, byval p as integer, byval q as integer, byval r as integer)
declare sub dMultiply1 cdecl alias "dMultiply1" (byval A as dReal ptr, byval B as dReal ptr, byval C as dReal ptr, byval p as integer, byval q as integer, byval r as integer)
declare sub dMultiply2 cdecl alias "dMultiply2" (byval A as dReal ptr, byval B as dReal ptr, byval C as dReal ptr, byval p as integer, byval q as integer, byval r as integer)
declare function dFactorCholesky cdecl alias "dFactorCholesky" (byval A as dReal ptr, byval n as integer) as integer
declare sub dSolveCholesky cdecl alias "dSolveCholesky" (byval L as dReal ptr, byval b as dReal ptr, byval n as integer)
declare function dInvertPDMatrix cdecl alias "dInvertPDMatrix" (byval A as dReal ptr, byval Ainv as dReal ptr, byval n as integer) as integer
declare function dIsPositiveDefinite cdecl alias "dIsPositiveDefinite" (byval A as dReal ptr, byval n as integer) as integer
declare sub dFactorLDLT cdecl alias "dFactorLDLT" (byval A as dReal ptr, byval d as dReal ptr, byval n as integer, byval nskip as integer)
declare sub dSolveL1 cdecl alias "dSolveL1" (byval L as dReal ptr, byval b as dReal ptr, byval n as integer, byval nskip as integer)
declare sub dSolveL1T cdecl alias "dSolveL1T" (byval L as dReal ptr, byval b as dReal ptr, byval n as integer, byval nskip as integer)
declare sub dVectorScale cdecl alias "dVectorScale" (byval a as dReal ptr, byval d as dReal ptr, byval n as integer)
declare sub dSolveLDLT cdecl alias "dSolveLDLT" (byval L as dReal ptr, byval d as dReal ptr, byval b as dReal ptr, byval n as integer, byval nskip as integer)
declare sub dLDLTAddTL cdecl alias "dLDLTAddTL" (byval L as dReal ptr, byval d as dReal ptr, byval a as dReal ptr, byval n as integer, byval nskip as integer)
declare sub dLDLTRemove cdecl alias "dLDLTRemove" (byval A as dReal ptr ptr, byval p as integer ptr, byval L as dReal ptr, byval d as dReal ptr, byval n1 as integer, byval n2 as integer, byval r as integer, byval nskip as integer)
declare sub dRemoveRowCol cdecl alias "dRemoveRowCol" (byval A as dReal ptr, byval n as integer, byval nskip as integer, byval r as integer)

#endif
