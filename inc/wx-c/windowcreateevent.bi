''
''
'' windowcreateevent -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __wxc_windowcreateevent_bi__
#define __wxc_windowcreateevent_bi__

#include once "wx.bi"

declare function wxWindowCreateEvent alias "wxWindowCreateEvent_ctor" (byval win as wxWindow ptr) as wxWindowCreateEvent ptr
declare function wxWindowCreateEvent_GetWindow (byval self as wxWindowCreateEvent ptr) as wxWindow ptr

#endif
