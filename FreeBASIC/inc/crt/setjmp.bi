''
''
'' setjmp -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __setjmp_bi__
#define __setjmp_bi__

#define _JBLEN 16

type jmp_buf as integer ptr

declare function _setjmp cdecl alias "_setjmp" (byval as jmp_buf) as integer
declare sub longjmp cdecl alias "longjmp" (byval as jmp_buf, byval as integer)

#endif
