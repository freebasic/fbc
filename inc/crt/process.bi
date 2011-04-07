''
''
'' process -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __crt_process_bi__
#define __crt_process_bi__

#if defined(__FB_WIN32__)
#include once "crt/win32/process.bi"
#else
#error unsupported platform
#endif

#endif
