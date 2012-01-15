''
''
'' fcntl -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __crt_fcntl_bi__
#define __crt_fcntl_bi__

#if defined(__FB_WIN32__)
#include once "crt/win32/fcntl.bi"
#elseif defined(__FB_DOS__)
#include once "crt/dos/fcntl.bi"
#elseif defined(__FB_LINUX__)
#include once "crt/linux/fcntl.bi"
#endif

#endif
