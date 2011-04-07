''
''
'' contextmenuevent -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __wxc_contextmenuevent_bi__
#define __wxc_contextmenuevent_bi__

#include once "wx.bi"

declare function wxContextMenuEvent alias "wxContextMenuEvent_ctor" (byval type as wxEventType) as wxContextMenuEvent ptr
declare sub wxContextMenuEvent_GetPosition (byval self as wxContextMenuEvent ptr, byval inp as wxPoint ptr)
declare sub wxContextMenuEvent_SetPosition (byval self as wxContextMenuEvent ptr, byval inp as wxPoint ptr)

#endif
