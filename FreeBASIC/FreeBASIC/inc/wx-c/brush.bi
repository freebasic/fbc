''
''
'' brush -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __wxc_brush_bi__
#define __wxc_brush_bi__

#include once "wx.bi"

declare function wxBrush alias "wxBrush_ctor" () as wxBrush ptr
declare function wxBrush_Ok (byval self as wxBrush ptr) as integer
declare function wxBrush_GetStyle (byval self as wxBrush ptr) as integer
declare function wxBrush_GetStipple (byval self as wxBrush ptr) as wxBitmap ptr
declare sub wxBrush_SetColour (byval self as wxBrush ptr, byval col as wxColour ptr)
declare function wxBrush_GetColour (byval self as wxBrush ptr) as wxColour ptr
declare sub wxBrush_SetStyle (byval self as wxBrush ptr, byval style as integer)
declare sub wxBrush_SetStipple (byval self as wxBrush ptr, byval stipple as wxBitmap ptr)

#endif
