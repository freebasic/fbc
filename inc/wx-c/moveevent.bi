''
''
'' moveevent -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __wxc_moveevent_bi__
#define __wxc_moveevent_bi__

#include once "wx.bi"

declare function wxMoveEvent alias "wxMoveEvent_ctor" () as wxMoveEvent ptr
declare sub wxMoveEvent_GetPosition (byval self as wxMoveEvent ptr, byval point as wxPoint ptr)

#endif
