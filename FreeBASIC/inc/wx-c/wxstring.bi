''
''
'' wxstring -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __wxstring_bi__
#define __wxstring_bi__

#include once "wx-c/wx.bi"

declare function wxString cdecl alias "wxString_ctor" (byval str as string) as wxString ptr
declare sub wxString_dtor cdecl alias "wxString_dtor" (byval self as wxString ptr)
declare function wxString_mb_str cdecl alias "wxString_mb_str" (byval self as wxString ptr) as zstring ptr
declare function wxString_Length cdecl alias "wxString_Length" (byval self as wxString ptr) as integer
declare function wxString_CharAt cdecl alias "wxString_CharAt" (byval self as wxString ptr, byval i as integer) as byte
declare function wxString_CharAtInt cdecl alias "wxString_CharAtInt" (byval self as wxString ptr, byval i as integer) as integer

#endif
