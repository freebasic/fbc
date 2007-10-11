''
''
'' mouseevent -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __wxc_mouseevent_bi__
#define __wxc_mouseevent_bi__

#include once "wx.bi"

declare function wxMouseEvent alias "wxMouseEvent_ctor" (byval mouseType as wxEventType) as wxMouseEvent ptr
declare function wxMouseEvent_IsButton (byval self as wxMouseEvent ptr) as integer
declare function wxMouseEvent_ButtonDown (byval self as wxMouseEvent ptr) as integer
declare function wxMouseEvent_ButtonDown2 (byval self as wxMouseEvent ptr, byval button as integer) as integer
declare function wxMouseEvent_ButtonDClick (byval self as wxMouseEvent ptr, byval but as integer) as integer
declare function wxMouseEvent_ButtonUp (byval self as wxMouseEvent ptr, byval but as integer) as integer
declare function wxMouseEvent_Button (byval self as wxMouseEvent ptr, byval but as integer) as integer
declare function wxMouseEvent_ButtonIsDown (byval self as wxMouseEvent ptr, byval but as integer) as integer
declare function wxMouseEvent_GetButton (byval self as wxMouseEvent ptr) as integer
declare function wxMouseEvent_ControlDown (byval self as wxMouseEvent ptr) as integer
declare function wxMouseEvent_MetaDown (byval self as wxMouseEvent ptr) as integer
declare function wxMouseEvent_AltDown (byval self as wxMouseEvent ptr) as integer
declare function wxMouseEvent_ShiftDown (byval self as wxMouseEvent ptr) as integer
declare function wxMouseEvent_LeftDown (byval self as wxMouseEvent ptr) as integer
declare function wxMouseEvent_MiddleDown (byval self as wxMouseEvent ptr) as integer
declare function wxMouseEvent_RightDown (byval self as wxMouseEvent ptr) as integer
declare function wxMouseEvent_LeftUp (byval self as wxMouseEvent ptr) as integer
declare function wxMouseEvent_MiddleUp (byval self as wxMouseEvent ptr) as integer
declare function wxMouseEvent_RightUp (byval self as wxMouseEvent ptr) as integer
declare function wxMouseEvent_LeftDClick (byval self as wxMouseEvent ptr) as integer
declare function wxMouseEvent_MiddleDClick (byval self as wxMouseEvent ptr) as integer
declare function wxMouseEvent_RightDClick (byval self as wxMouseEvent ptr) as integer
declare function wxMouseEvent_LeftIsDown (byval self as wxMouseEvent ptr) as integer
declare function wxMouseEvent_MiddleIsDown (byval self as wxMouseEvent ptr) as integer
declare function wxMouseEvent_RightIsDown (byval self as wxMouseEvent ptr) as integer
declare function wxMouseEvent_Dragging (byval self as wxMouseEvent ptr) as integer
declare function wxMouseEvent_Moving (byval self as wxMouseEvent ptr) as integer
declare function wxMouseEvent_Entering (byval self as wxMouseEvent ptr) as integer
declare function wxMouseEvent_Leaving (byval self as wxMouseEvent ptr) as integer
declare sub wxMouseEvent_GetPosition (byval self as wxMouseEvent ptr, byval pos as wxPoint ptr)
declare sub wxMouseEvent_LogicalPosition (byval self as wxMouseEvent ptr, byval dc as wxDC ptr, byval pos as wxPoint ptr)
declare function wxMouseEvent_GetWheelRotation (byval self as wxMouseEvent ptr) as integer
declare function wxMouseEvent_GetWheelDelta (byval self as wxMouseEvent ptr) as integer
declare function wxMouseEvent_GetLinesPerAction (byval self as wxMouseEvent ptr) as integer
declare function wxMouseEvent_IsPageScroll (byval self as wxMouseEvent ptr) as integer

#endif
