''
''
'' eraseevent -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __eraseevent_bi__
#define __eraseevent_bi__

#include once "wx-c/wx.bi"

declare function wxEraseEvent cdecl alias "wxEraseEvent_ctor" (byval type as wxEventType) as wxEraseEvent ptr
declare function wxEraseEvent_GetDC cdecl alias "wxEraseEvent_GetDC" (byval self as wxEraseEvent ptr) as wxDC ptr

#endif
