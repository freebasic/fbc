''
''
'' panel -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __wxc_panel_bi__
#define __wxc_panel_bi__

#include once "wx.bi"


declare function wxPanel alias "wxPanel_ctor" () as wxPanel ptr
declare function wxPanel_ctor2 (byval parent as wxWindow ptr, byval id as wxWindowID, byval pos as wxPoint ptr, byval size as wxSize ptr, byval style as integer, byval name as zstring ptr) as wxPanel ptr
declare function wxPanel_Create (byval self as wxPanel ptr, byval parent as wxWindow ptr, byval id as wxWindowID, byval pos as wxPoint ptr, byval size as wxSize ptr, byval style as integer, byval name as zstring ptr) as integer
declare sub wxPanel_InitDialog (byval self as wxPanel ptr)
declare sub wxPanel_SetDefaultItem (byval self as wxPanel ptr, byval btn as wxButton ptr)
declare function wxPanel_GetDefaultItem (byval self as wxPanel ptr) as wxButton ptr

#endif
