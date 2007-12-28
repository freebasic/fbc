''
''
'' object -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __wxc_object_bi__
#define __wxc_object_bi__

#include once "wx.bi"

declare function wxObject_GetTypeName (byval obj as wxObject ptr) as wxString ptr
declare sub wxObject_dtor (byval self as wxObject ptr)
declare function wxGetTranslation_func (byval str as zstring ptr) as wxString ptr

#endif
