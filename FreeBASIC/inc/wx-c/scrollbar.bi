''
''
'' scrollbar -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __wxc_scrollbar_bi__
#define __wxc_scrollbar_bi__

#include once "wx-c/wx.bi"


declare function wxScrollBar cdecl alias "wxScrollBar_ctor" () as wxScrollBar ptr
declare function wxScrollBar_Create cdecl alias "wxScrollBar_Create" (byval self as wxScrollBar ptr, byval parent as wxWindow ptr, byval id as wxWindowID, byval pos as wxPoint ptr, byval size as wxSize ptr, byval style as integer, byval validator as wxValidator ptr, byval name as zstring ptr) as integer
declare function wxScrollBar_GetThumbPosition cdecl alias "wxScrollBar_GetThumbPosition" (byval self as wxScrollBar ptr) as integer
declare function wxScrollBar_GetThumbSize cdecl alias "wxScrollBar_GetThumbSize" (byval self as wxScrollBar ptr) as integer
declare function wxScrollBar_GetPageSize cdecl alias "wxScrollBar_GetPageSize" (byval self as wxScrollBar ptr) as integer
declare function wxScrollBar_GetRange cdecl alias "wxScrollBar_GetRange" (byval self as wxScrollBar ptr) as integer
declare function wxScrollBar_IsVertical cdecl alias "wxScrollBar_IsVertical" (byval self as wxScrollBar ptr) as integer
declare sub wxScrollBar_SetThumbPosition cdecl alias "wxScrollBar_SetThumbPosition" (byval self as wxScrollBar ptr, byval viewStart as integer)
declare sub wxScrollBar_SetScrollbar cdecl alias "wxScrollBar_SetScrollbar" (byval self as wxScrollBar ptr, byval position as integer, byval thumbSize as integer, byval range as integer, byval pageSize as integer, byval refresh as integer)

#endif
