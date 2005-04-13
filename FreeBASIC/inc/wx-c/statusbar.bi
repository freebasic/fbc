''
''
'' statusbar -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __statusbar_bi__
#define __statusbar_bi__

#include once "wx-c/wx.bi"


declare function wxStatusBar cdecl alias "wxStatusBar_ctor" () as wxStatusBar ptr
declare function wxStatusBar_Create cdecl alias "wxStatusBar_Create" (byval self as wxStatusBar ptr, byval parent as wxWindow ptr, byval id as wxWindowID, byval style as uinteger, byval name as string) as integer
declare sub wxStatusBar_SetFieldsCount cdecl alias "wxStatusBar_SetFieldsCount" (byval self as wxStatusBar ptr, byval number as integer, byval widths as integer ptr)
declare function wxStatusBar_GetFieldRect cdecl alias "wxStatusBar_GetFieldRect" (byval self as wxStatusBar ptr, byval i as integer, byval rect as wxRect ptr) as integer
declare function wxStatusBar_GetBorderY cdecl alias "wxStatusBar_GetBorderY" (byval self as wxStatusBar ptr) as integer
declare function wxStatusBar_GetStatusText cdecl alias "wxStatusBar_GetStatusText" (byval self as wxStatusBar ptr, byval number as integer) as wxString ptr
declare function wxStatusBar_GetBorderX cdecl alias "wxStatusBar_GetBorderX" (byval self as wxStatusBar ptr) as integer
declare sub wxStatusBar_SetStatusText cdecl alias "wxStatusBar_SetStatusText" (byval self as wxStatusBar ptr, byval text as string, byval number as integer)
declare sub wxStatusBar_SetStatusWidths cdecl alias "wxStatusBar_SetStatusWidths" (byval self as wxStatusBar ptr, byval n as integer, byval widths_field as integer ptr)
declare function wxStatusBar_GetFieldsCount cdecl alias "wxStatusBar_GetFieldsCount" (byval self as wxStatusBar ptr) as integer
declare sub wxStatusBar_PopStatusText cdecl alias "wxStatusBar_PopStatusText" (byval self as wxStatusBar ptr, byval field as integer)
declare sub wxStatusBar_PushStatusText cdecl alias "wxStatusBar_PushStatusText" (byval self as wxStatusBar ptr, byval xstring as string, byval field as integer)
declare sub wxStatusBar_SetMinHeight cdecl alias "wxStatusBar_SetMinHeight" (byval self as wxStatusBar ptr, byval height as integer)
declare sub wxStatusBar_SetStatusStyles cdecl alias "wxStatusBar_SetStatusStyles" (byval self as wxStatusBar ptr, byval n as integer, byval styles as integer ptr)

#endif
