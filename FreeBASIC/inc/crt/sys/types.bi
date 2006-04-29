''
''
'' types -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __crt_sys_types_bi__
#define __crt_sys_types_bi__

#include once "crt/stddef.bi"

#if defined(__FB_WIN32__)
#include once "crt/sys/win32/types.bi"
#elseif defined(__FB_DOS__)
#include once "crt/sys/dos/types.bi"
#elseif defined(__FB_LINUX__)
#include once "crt/sys/linux/types.bi"
#else
#error Platform unsupported
#endif

#endif
