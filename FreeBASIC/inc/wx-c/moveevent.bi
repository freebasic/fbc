''
''
'' moveevent -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __moveevent_bi__
#define __moveevent_bi__

#include once "wx-c/wx.bi"

declare function wxMoveEvent cdecl alias "wxMoveEvent_ctor" () as wxMoveEvent ptr
declare sub wxMoveEvent_GetPosition cdecl alias "wxMoveEvent_GetPosition" (byval self as wxMoveEvent ptr, byval point as wxPoint ptr)

#endif
