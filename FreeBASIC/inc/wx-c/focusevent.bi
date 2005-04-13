''
''
'' focusevent -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __focusevent_bi__
#define __focusevent_bi__

#include once "wx-c/wx.bi"

declare function wxFocusEvent cdecl alias "wxFocusEvent_ctor" (byval type as wxEventType) as wxFocusEvent ptr
declare function wxFocusEvent_GetWindow cdecl alias "wxFocusEvent_GetWindow" (byval self as wxFocusEvent ptr) as wxWindow ptr
declare sub wxFocusEvent_SetWindow cdecl alias "wxFocusEvent_SetWindow" (byval self as wxFocusEvent ptr, byval win as wxWindow ptr)

#endif
