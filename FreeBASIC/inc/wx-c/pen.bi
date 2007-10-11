''
''
'' pen -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __wxc_pen_bi__
#define __wxc_pen_bi__

#include once "wx.bi"

declare function wxPen_ctorByName (byval name as zstring ptr, byval width as integer, byval style as integer) as wxPen ptr
declare function wxPen alias "wxPen_ctor" (byval col as wxColour ptr, byval width as integer, byval style as integer) as wxPen ptr
declare sub wxPen_SetWidth (byval self as wxPen ptr, byval width as integer)
declare function wxPen_GetWidth (byval self as wxPen ptr) as integer
declare function wxPen_GetColour (byval self as wxPen ptr) as wxColour ptr
declare sub wxPen_SetColour (byval self as wxPen ptr, byval col as wxColour ptr)
declare function wxPen_GetCap (byval self as wxPen ptr) as integer
declare function wxPen_GetJoin (byval self as wxPen ptr) as integer
declare function wxPen_GetStyle (byval self as wxPen ptr) as integer
declare function wxPen_Ok (byval self as wxPen ptr) as integer
declare sub wxPen_SetCap (byval self as wxPen ptr, byval capStyle as integer)
declare sub wxPen_SetJoin (byval self as wxPen ptr, byval join_style as integer)
declare sub wxPen_SetStyle (byval self as wxPen ptr, byval style as integer)

#endif
