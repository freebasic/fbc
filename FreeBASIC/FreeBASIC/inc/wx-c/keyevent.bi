''
''
'' keyevent -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __wxc_keyevent_bi__
#define __wxc_keyevent_bi__

#include once "wx.bi"

declare function wxKeyEvent alias "wxKeyEvent_ctor" (byval type as wxEventType) as wxKeyEvent ptr
declare function wxKeyEvent_ControlDown (byval self as wxKeyEvent ptr) as integer
declare function wxKeyEvent_ShiftDown (byval self as wxKeyEvent ptr) as integer
declare function wxKeyEvent_AltDown (byval self as wxKeyEvent ptr) as integer
declare function wxKeyEvent_MetaDown (byval self as wxKeyEvent ptr) as integer
declare function wxKeyEvent_GetRawKeyCode (byval self as wxKeyEvent ptr) as uinteger
declare function wxKeyEvent_GetKeyCode (byval self as wxKeyEvent ptr) as integer
declare function wxKeyEvent_GetRawKeyFlags (byval self as wxKeyEvent ptr) as uinteger
declare function wxKeyEvent_HasModifiers (byval self as wxKeyEvent ptr) as integer
declare sub wxKeyEvent_GetPosition (byval self as wxKeyEvent ptr, byval pt as wxPoint ptr)
declare function wxKeyEvent_GetX (byval self as wxKeyEvent ptr) as integer
declare function wxKeyEvent_GetY (byval self as wxKeyEvent ptr) as integer
declare function wxKeyEvent_CmdDown (byval self as wxKeyEvent ptr) as integer

#endif
