''
''
'' sys\stat -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __crt_sys_stat_bi__
#define __crt_sys_stat_bi__

#include once "crt/stddef.bi"
#include once "crt/sys/types.bi"

#if defined(__FB_WIN32__)
#include once "crt/sys/win32/stat.bi"
#else
#error Unsupported platform
#endif

declare function fstat cdecl alias "fstat" (byval as integer, byval as _stat ptr) as integer
declare function chmod cdecl alias "chmod" (byval as zstring ptr, byval as integer) as integer
declare function stat cdecl alias "stat" (byval as zstring ptr, byval as _stat ptr) as integer

#endif
