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

#include once "wx.bi"


declare function wxScrollBar alias "wxScrollBar_ctor" () as wxScrollBar ptr
declare function wxScrollBar_Create (byval self as wxScrollBar ptr, byval parent as wxWindow ptr, byval id as wxWindowID, byval pos as wxPoint ptr, byval size as wxSize ptr, byval style as integer, byval validator as wxValidator ptr, byval name as zstring ptr) as integer
declare function wxScrollBar_GetThumbPosition (byval self as wxScrollBar ptr) as integer
declare function wxScrollBar_GetThumbSize (byval self as wxScrollBar ptr) as integer
declare function wxScrollBar_GetPageSize (byval self as wxScrollBar ptr) as integer
declare function wxScrollBar_GetRange (byval self as wxScrollBar ptr) as integer
declare function wxScrollBar_IsVertical (byval self as wxScrollBar ptr) as integer
declare sub wxScrollBar_SetThumbPosition (byval self as wxScrollBar ptr, byval viewStart as integer)
declare sub wxScrollBar_SetScrollbar (byval self as wxScrollBar ptr, byval position as integer, byval thumbSize as integer, byval range as integer, byval pageSize as integer, byval refresh as integer)

#endif
