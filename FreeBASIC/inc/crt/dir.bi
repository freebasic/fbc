''
''
'' dir -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __crt_dir_bi__
#define __crt_dir_bi__

#if defined(__FB_WIN32__)
#include once "crt/io.bi"
#elseif defined(__FB_DOS__)
#include once "crt/dos/dir.bi"
#else
#error Unsupported platform
#endif

#endif
