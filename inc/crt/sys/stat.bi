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

extern "C"

declare function fstat (byval as long, byval as _stat ptr) as long
declare function chmod (byval as zstring ptr, byval as long) as long
declare function stat (byval as zstring ptr, byval as _stat ptr) as long

end extern

#endif
