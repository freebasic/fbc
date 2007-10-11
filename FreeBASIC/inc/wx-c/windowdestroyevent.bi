''
''
'' windowdestroyevent -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __wxc_windowdestroyevent_bi__
#define __wxc_windowdestroyevent_bi__

#include once "wx.bi"

declare function wxWindowDestroyEvent alias "wxWindowDestroyEvent_ctor" (byval win as wxWindow ptr) as wxWindowDestroyEvent ptr
declare function wxWindowDestroyEvent_GetWindow (byval self as wxWindowDestroyEvent ptr) as wxWindow ptr

#endif
