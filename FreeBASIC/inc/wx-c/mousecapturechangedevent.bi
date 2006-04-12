''
''
'' mousecapturechangedevent -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __wxc_mousecapturechangedevent_bi__
#define __wxc_mousecapturechangedevent_bi__

#include once "wx-c/wx.bi"

declare function wxMouseCaptureChangedEvent cdecl alias "wxMouseCaptureChangedEvent_ctor" (byval type as wxEventType) as wxMouseCaptureChangedEvent ptr
declare function wxMouseCaptureChangedEvent_GetCapturedWindow cdecl alias "wxMouseCaptureChangedEvent_GetCapturedWindow" (byval self as wxMouseCaptureChangedEvent ptr) as wxWindow ptr

#endif
