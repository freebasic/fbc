''
''
'' jslong -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __jslong_bi__
#define __jslong_bi__

#include once "spidermonkey/jstypes.bi"

declare function JSLL_MaxInt cdecl alias "JSLL_MaxInt" () as JSInt64
declare function JSLL_MinInt cdecl alias "JSLL_MinInt" () as JSInt64
declare function JSLL_Zero cdecl alias "JSLL_Zero" () as JSInt64

#endif
