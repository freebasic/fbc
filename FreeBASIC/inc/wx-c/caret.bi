''
''
'' caret -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __wxc_caret_bi__
#define __wxc_caret_bi__

#include once "wx-c/wx.bi"

declare function wxCaret cdecl alias "wxCaret_ctor" () as wxCaret ptr
declare sub wxCaret_dtor cdecl alias "wxCaret_dtor" (byval self as wxCaret ptr)
declare function wxCaret_Create cdecl alias "wxCaret_Create" (byval self as wxCaret ptr, byval window as wxWindow ptr, byval width as integer, byval height as integer) as integer
declare function wxCaret_IsOk cdecl alias "wxCaret_IsOk" (byval self as wxCaret ptr) as integer
declare function wxCaret_IsVisible cdecl alias "wxCaret_IsVisible" (byval self as wxCaret ptr) as integer
declare sub wxCaret_GetPosition cdecl alias "wxCaret_GetPosition" (byval self as wxCaret ptr, byval x as integer ptr, byval y as integer ptr)
declare sub wxCaret_GetSize cdecl alias "wxCaret_GetSize" (byval self as wxCaret ptr, byval width as integer ptr, byval height as integer ptr)
declare function wxCaret_GetWindow cdecl alias "wxCaret_GetWindow" (byval self as wxCaret ptr) as wxWindow ptr
declare sub wxCaret_SetSize cdecl alias "wxCaret_SetSize" (byval self as wxCaret ptr, byval width as integer, byval height as integer)
declare sub wxCaret_Move cdecl alias "wxCaret_Move" (byval self as wxCaret ptr, byval x as integer, byval y as integer)
declare sub wxCaret_Show cdecl alias "wxCaret_Show" (byval self as wxCaret ptr, byval show as integer)
declare sub wxCaret_Hide cdecl alias "wxCaret_Hide" (byval self as wxCaret ptr)
declare function wxCaret_GetBlinkTime cdecl alias "wxCaret_GetBlinkTime" () as integer
declare sub wxCaret_SetBlinkTime cdecl alias "wxCaret_SetBlinkTime" (byval milliseconds as integer)
declare function wxCaretSuspend cdecl alias "wxCaretSuspend_ctor" (byval win as wxWindow ptr) as wxCaretSuspend ptr
declare sub wxCaretSuspend_dtor cdecl alias "wxCaretSuspend_dtor" (byval self as wxCaretSuspend ptr)

#endif
