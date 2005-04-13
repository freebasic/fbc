''
''
'' keyevent -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __keyevent_bi__
#define __keyevent_bi__

#include once "wx-c/wx.bi"

declare function wxKeyEvent cdecl alias "wxKeyEvent_ctor" (byval type as wxEventType) as wxKeyEvent ptr
declare function wxKeyEvent_ControlDown cdecl alias "wxKeyEvent_ControlDown" (byval self as wxKeyEvent ptr) as integer
declare function wxKeyEvent_ShiftDown cdecl alias "wxKeyEvent_ShiftDown" (byval self as wxKeyEvent ptr) as integer
declare function wxKeyEvent_AltDown cdecl alias "wxKeyEvent_AltDown" (byval self as wxKeyEvent ptr) as integer
declare function wxKeyEvent_MetaDown cdecl alias "wxKeyEvent_MetaDown" (byval self as wxKeyEvent ptr) as integer
declare function wxKeyEvent_GetRawKeyCode cdecl alias "wxKeyEvent_GetRawKeyCode" (byval self as wxKeyEvent ptr) as uinteger
declare function wxKeyEvent_GetKeyCode cdecl alias "wxKeyEvent_GetKeyCode" (byval self as wxKeyEvent ptr) as integer
declare function wxKeyEvent_GetRawKeyFlags cdecl alias "wxKeyEvent_GetRawKeyFlags" (byval self as wxKeyEvent ptr) as uinteger
declare function wxKeyEvent_HasModifiers cdecl alias "wxKeyEvent_HasModifiers" (byval self as wxKeyEvent ptr) as integer
declare sub wxKeyEvent_GetPosition cdecl alias "wxKeyEvent_GetPosition" (byval self as wxKeyEvent ptr, byval pt as wxPoint ptr)
declare function wxKeyEvent_GetX cdecl alias "wxKeyEvent_GetX" (byval self as wxKeyEvent ptr) as integer
declare function wxKeyEvent_GetY cdecl alias "wxKeyEvent_GetY" (byval self as wxKeyEvent ptr) as integer
declare function wxKeyEvent_CmdDown cdecl alias "wxKeyEvent_CmdDown" (byval self as wxKeyEvent ptr) as integer

#endif
