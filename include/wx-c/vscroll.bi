''
''
'' vscroll -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __wxc_vscroll_bi__
#define __wxc_vscroll_bi__

#include once "wx.bi"

#ifndef Virtual_IntInt
type Virtual_IntInt as function WXCALL (byval as integer) as integer
#endif

declare function wxVScrollWnd (byval parent as wxWindow ptr, byval id as wxWindowID, byval pos as wxPoint ptr, byval size as wxSize ptr, byval style as integer, byval name as zstring ptr) as wxVScrolledWindow ptr
declare sub wxVScrolledWindow_RegisterVirtual (byval self as _VScrolledWindow ptr, byval onGetLineHeight as Virtual_IntInt)
declare function wxVScrolledWindow_Create (byval self as _VScrolledWindow ptr, byval parent as wxWindow ptr, byval id as wxWindowID, byval pos as wxPoint ptr, byval size as wxSize ptr, byval style as integer, byval name as zstring ptr) as integer
declare sub wxVScrolledWindow_SetLineCount (byval self as _VScrolledWindow ptr, byval count as integer)
declare function wxVScrolledWindow_ScrollToLine (byval self as _VScrolledWindow ptr, byval line as integer) as integer
declare function wxVScrolledWindow_ScrollLines (byval self as _VScrolledWindow ptr, byval lines as integer) as integer
declare function wxVScrolledWindow_ScrollPages (byval self as _VScrolledWindow ptr, byval pages as integer) as integer
declare sub wxVScrolledWindow_RefreshLine (byval self as _VScrolledWindow ptr, byval line as integer)
declare sub wxVScrolledWindow_RefreshLines (byval self as _VScrolledWindow ptr, byval from as integer, byval to as integer)
declare function wxVScrolledWindow_HitTest (byval self as _VScrolledWindow ptr, byval x as wxCoord, byval y as wxCoord) as integer
declare function wxVScrolledWindow_HitTest2 (byval self as _VScrolledWindow ptr, byval pt as wxPoint ptr) as integer
declare sub wxVScrolledWindow_RefreshAll (byval self as _VScrolledWindow ptr)
declare function wxVScrolledWindow_GetLineCount (byval self as _VScrolledWindow ptr) as integer
declare function wxVScrolledWindow_GetFirstVisisbleLine (byval self as _VScrolledWindow ptr) as integer
declare function wxVScrolledWindow_GetLastVisibleLine (byval self as _VScrolledWindow ptr) as integer
declare function wxVScrolledWindow_IsVisible (byval self as _VScrolledWindow ptr, byval line as integer) as integer

#endif
