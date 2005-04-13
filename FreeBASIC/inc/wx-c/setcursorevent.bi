''
''
'' setcursorevent -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __setcursorevent_bi__
#define __setcursorevent_bi__

#include once "wx-c/wx.bi"

declare function wxSetCursorEvent cdecl alias "wxSetCursorEvent_ctor" (byval type as wxEventType) as wxSetCursorEvent ptr
declare function wxSetCursorEvent_GetX cdecl alias "wxSetCursorEvent_GetX" (byval self as wxSetCursorEvent ptr) as integer
declare function wxSetCursorEvent_GetY cdecl alias "wxSetCursorEvent_GetY" (byval self as wxSetCursorEvent ptr) as integer
declare sub wxSetCursorEvent_SetCursor cdecl alias "wxSetCursorEvent_SetCursor" (byval self as wxSetCursorEvent ptr, byval cursor as wxCursor ptr)
declare function wxSetCursorEvent_GetCursor cdecl alias "wxSetCursorEvent_GetCursor" (byval self as wxSetCursorEvent ptr) as wxCursor ptr
declare function wxSetCursorEvent_HasCursor cdecl alias "wxSetCursorEvent_HasCursor" (byval self as wxSetCursorEvent ptr) as integer

#endif
