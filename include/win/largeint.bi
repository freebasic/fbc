''
''
'' largeint -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __win_largeint_bi__
#define __win_largeint_bi__

#inclib "ntdll"

#include once "windows.bi"

#define LargeIntegerAdd(a,b) (a.QuadPart + b.QuadPart)
#define LargeIntegerSubtract(a,b) (a.QuadPart - b.QuadPart)
#define LargeIntegerRightShift(i,n) (i.QuadPart shr (n))
#define LargeIntegerArithmeticShift LargeIntegerRightShift
#define LargeIntegerLeftShift(i,n) (i.QuadPart shl (n))
#define LargeIntegerNegate(i) (- i.QuadPart)
#define EnlargedIntegerMultiply(a,b) (a.QuadPart * b.QuadPart)
#define EnlargedUnsignedMultiply(a,b) (a.QuadPart * b.QuadPart)
#define ExtendedIntegerMultiply(a,b) (a.QuadPart * b.QuadPart)
#define LargeIntegerMultiply(a,b) (a.QuadPart * b.QuadPart)
#define ConvertLongToLargeInteger(l) (l.QuadPart)
#define ConvertUlongToLargeInteger(l) (l.QuadPart)

declare function LargeIntegerDivide alias "LargeIntegerDivide" (byval as LARGE_INTEGER, byval as LARGE_INTEGER, byval as PLARGE_INTEGER) as LARGE_INTEGER
declare function EnlargedUnsignedDivide alias "EnlargedUnsignedDivide" (byval as ULARGE_INTEGER, byval as ULONG, byval as PULONG) as ULONG
declare function ExtendedLargeIntegerDivide alias "ExtendedLargeIntegerDivide" (byval as LARGE_INTEGER, byval as ULONG, byval as PULONG) as LARGE_INTEGER
declare function ExtendedMagicDivide alias "ExtendedMagicDivide" (byval as LARGE_INTEGER, byval as LARGE_INTEGER, byval as integer) as LARGE_INTEGER

#define LargeIntegerAnd(dest, src, m) dest.QuadPart = src.QuadPart and m.QuadPart
#define LargeIntegerGreaterThan(a,b) (a.QuadPart > b.QuadPart)
#define LargeIntegerGreaterThanOrEqual(a,b) (a.QuadPart >= b.QuadPart)
#define LargeIntegerEqualTo(a,b) (a.QuadPart = b.QuadPart)
#define LargeIntegerNotEqualTo(a,b) (a.QuadPart <> b.QuadPart)
#define LargeIntegerLessThan(a,b) (a.QuadPart < b.QuadPart)
#define LargeIntegerLessThanOrEqualTo(a,b) (a.QuadPart <= b.QuadPart)
#define LargeIntegerGreaterThanZero(a) (a.QuadPart > 0)
#define LargeIntegerGreaterOrEqualToZero(a) (a.HighPart > 0)
#define LargeIntegerEqualToZero(a) (a.QuadPart = 0)
#define LargeIntegerNotEqualToZero(a) (a.QuadPart <> 0)
#define LargeIntegerLessThanZero(a) (a.HighPart < 0)
#define LargeIntegerLessOrEqualToZero(a) (a.QuadPart <= 0)

#endif
