''
''
'' windowcreateevent -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __windowcreateevent_bi__
#define __windowcreateevent_bi__

#include once "wx-c/wx.bi"

declare function wxWindowCreateEvent cdecl alias "wxWindowCreateEvent_ctor" (byval win as wxWindow ptr) as wxWindowCreateEvent ptr
declare function wxWindowCreateEvent_GetWindow cdecl alias "wxWindowCreateEvent_GetWindow" (byval self as wxWindowCreateEvent ptr) as wxWindow ptr

#endif
