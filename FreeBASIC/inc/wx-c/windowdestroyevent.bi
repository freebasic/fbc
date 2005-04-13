''
''
'' windowdestroyevent -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __windowdestroyevent_bi__
#define __windowdestroyevent_bi__

#include once "wx-c/wx.bi"

declare function wxWindowDestroyEvent cdecl alias "wxWindowDestroyEvent_ctor" (byval win as wxWindow ptr) as wxWindowDestroyEvent ptr
declare function wxWindowDestroyEvent_GetWindow cdecl alias "wxWindowDestroyEvent_GetWindow" (byval self as wxWindowDestroyEvent ptr) as wxWindow ptr

#endif
