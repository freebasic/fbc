''
''
'' object -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __object_bi__
#define __object_bi__

#include once "wx-c/wx.bi"

declare function wxObject_GetTypeName cdecl alias "wxObject_GetTypeName" (byval obj as wxObject ptr) as wxString ptr
declare sub wxObject_dtor cdecl alias "wxObject_dtor" (byval self as wxObject ptr)
declare function wxGetTranslation_func cdecl alias "wxGetTranslation_func" (byval str as string) as wxString ptr

#endif
