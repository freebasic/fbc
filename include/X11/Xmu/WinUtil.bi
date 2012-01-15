''
''
'' WinUtil -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __WinUtil_bi__
#define __WinUtil_bi__

declare function XmuScreenOfWindow cdecl alias "XmuScreenOfWindow" (byval dpy as Display ptr, byval w as Window) as Screen ptr

#endif
