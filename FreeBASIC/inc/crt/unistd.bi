''
''
'' unistd -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __crt_unistd_bi__
#define __crt_unistd_bi__

#if defined(__FB_WIN32__)
#include once "crt/win32/unistd.bi"
#elseif defined(__FB_DOS__)
#include once "crt/dos/unistd.bi"
#elseif defined(__FB_LINUX__)
#include once "crt/linux/unistd.bi"
#else
#error unsupported platform
#endif

#endif
