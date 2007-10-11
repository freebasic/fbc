''
''
'' statusbar -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __wxc_statusbar_bi__
#define __wxc_statusbar_bi__

#include once "wx.bi"


declare function wxStatusBar alias "wxStatusBar_ctor" () as wxStatusBar ptr
declare function wxStatusBar_Create (byval self as wxStatusBar ptr, byval parent as wxWindow ptr, byval id as wxWindowID, byval style as uinteger, byval name as zstring ptr) as integer
declare sub wxStatusBar_SetFieldsCount (byval self as wxStatusBar ptr, byval number as integer, byval widths as integer ptr)
declare function wxStatusBar_GetFieldRect (byval self as wxStatusBar ptr, byval i as integer, byval rect as wxRect ptr) as integer
declare function wxStatusBar_GetBorderY (byval self as wxStatusBar ptr) as integer
declare function wxStatusBar_GetStatusText (byval self as wxStatusBar ptr, byval number as integer) as wxString ptr
declare function wxStatusBar_GetBorderX (byval self as wxStatusBar ptr) as integer
declare sub wxStatusBar_SetStatusText (byval self as wxStatusBar ptr, byval text as zstring ptr, byval number as integer)
declare sub wxStatusBar_SetStatusWidths (byval self as wxStatusBar ptr, byval n as integer, byval widths_field as integer ptr)
declare function wxStatusBar_GetFieldsCount (byval self as wxStatusBar ptr) as integer
declare sub wxStatusBar_PopStatusText (byval self as wxStatusBar ptr, byval field as integer)
declare sub wxStatusBar_PushStatusText (byval self as wxStatusBar ptr, byval xstring as zstring ptr, byval field as integer)
declare sub wxStatusBar_SetMinHeight (byval self as wxStatusBar ptr, byval height as integer)
declare sub wxStatusBar_SetStatusStyles (byval self as wxStatusBar ptr, byval n as integer, byval styles as integer ptr)

#endif
