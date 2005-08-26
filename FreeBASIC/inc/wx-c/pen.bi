''
''
'' pen -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __pen_bi__
#define __pen_bi__

#include once "wx-c/wx.bi"

declare function wxPen_ctorByName cdecl alias "wxPen_ctorByName" (byval name as zstring ptr, byval width as integer, byval style as integer) as wxPen ptr
declare function wxPen cdecl alias "wxPen_ctor" (byval col as wxColour ptr, byval width as integer, byval style as integer) as wxPen ptr
declare sub wxPen_SetWidth cdecl alias "wxPen_SetWidth" (byval self as wxPen ptr, byval width as integer)
declare function wxPen_GetWidth cdecl alias "wxPen_GetWidth" (byval self as wxPen ptr) as integer
declare function wxPen_GetColour cdecl alias "wxPen_GetColour" (byval self as wxPen ptr) as wxColour ptr
declare sub wxPen_SetColour cdecl alias "wxPen_SetColour" (byval self as wxPen ptr, byval col as wxColour ptr)
declare function wxPen_GetCap cdecl alias "wxPen_GetCap" (byval self as wxPen ptr) as integer
declare function wxPen_GetJoin cdecl alias "wxPen_GetJoin" (byval self as wxPen ptr) as integer
declare function wxPen_GetStyle cdecl alias "wxPen_GetStyle" (byval self as wxPen ptr) as integer
declare function wxPen_Ok cdecl alias "wxPen_Ok" (byval self as wxPen ptr) as integer
declare sub wxPen_SetCap cdecl alias "wxPen_SetCap" (byval self as wxPen ptr, byval capStyle as integer)
declare sub wxPen_SetJoin cdecl alias "wxPen_SetJoin" (byval self as wxPen ptr, byval join_style as integer)
declare sub wxPen_SetStyle cdecl alias "wxPen_SetStyle" (byval self as wxPen ptr, byval style as integer)

#endif
