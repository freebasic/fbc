''
''
'' setjmp -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __crt_setjmp_bi__
#define __crt_setjmp_bi__

#define _JBLEN 16
type jmp_buf as integer

#ifdef __FB_WIN32__
declare function setjmp cdecl alias "_setjmp" (byval as jmp_buf ptr) as integer
#else
declare function setjmp cdecl alias "setjmp" (byval as jmp_buf ptr) as integer
#endif

declare sub longjmp cdecl alias "longjmp" (byval as jmp_buf ptr, byval as integer)

#endif
