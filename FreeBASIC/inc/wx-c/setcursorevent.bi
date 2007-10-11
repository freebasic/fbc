''
''
'' setcursorevent -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __wxc_setcursorevent_bi__
#define __wxc_setcursorevent_bi__

#include once "wx.bi"

declare function wxSetCursorEvent alias "wxSetCursorEvent_ctor" (byval type as wxEventType) as wxSetCursorEvent ptr
declare function wxSetCursorEvent_GetX (byval self as wxSetCursorEvent ptr) as integer
declare function wxSetCursorEvent_GetY (byval self as wxSetCursorEvent ptr) as integer
declare sub wxSetCursorEvent_SetCursor (byval self as wxSetCursorEvent ptr, byval cursor as wxCursor ptr)
declare function wxSetCursorEvent_GetCursor (byval self as wxSetCursorEvent ptr) as wxCursor ptr
declare function wxSetCursorEvent_HasCursor (byval self as wxSetCursorEvent ptr) as integer

#endif
