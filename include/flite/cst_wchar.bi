''
''
'' cst_wchar -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __cst_wchar_bi__
#define __cst_wchar_bi__

declare function cst_cstr2wstr cdecl alias "cst_cstr2wstr" (byval s as zstring ptr) as wchar_t ptr
declare function cst_wstr2cstr cdecl alias "cst_wstr2cstr" (byval s as wchar_t ptr) as zstring ptr

#endif
