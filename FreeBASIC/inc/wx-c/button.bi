''
''
'' button -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __wxc_button_bi__
#define __wxc_button_bi__

#include once "wx-c/wx.bi"



declare function wxButton cdecl alias "wxButton_ctor" () as wxButton ptr
declare function wxButton_Create cdecl alias "wxButton_Create" (byval self as wxButton ptr, byval parent as wxWindow ptr, byval id as wxWindowID, byval label as zstring ptr, byval pos as wxPoint ptr, byval size as wxSize ptr, byval style as integer, byval validator as wxValidator ptr, byval name as zstring ptr) as integer
declare sub wxButton_SetDefault cdecl alias "wxButton_SetDefault" (byval self as wxButton ptr)
declare sub wxButton_GetDefaultSize cdecl alias "wxButton_GetDefaultSize" (byval size as wxSize ptr)
declare sub wxButton_SetImageLabel cdecl alias "wxButton_SetImageLabel" (byval self as wxButton ptr, byval bitmap as wxBitmap ptr)
declare sub wxButton_SetImageMargins cdecl alias "wxButton_SetImageMargins" (byval self as wxButton ptr, byval x as wxCoord, byval y as wxCoord)
declare sub wxButton_SetLabel cdecl alias "wxButton_SetLabel" (byval self as wxButton ptr, byval label as zstring ptr)

#endif
