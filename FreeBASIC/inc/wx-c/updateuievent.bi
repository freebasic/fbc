''
''
'' updateuievent -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __updateuievent_bi__
#define __updateuievent_bi__

#include once "wx-c/wx.bi"

declare function wxUpdateUIEvent cdecl alias "wxUpdateUIEvent_ctor" (byval commandId as wxWindowID) as wxUpdateUIEvent ptr
declare function wxUpdateUIEvent_CanUpdate cdecl alias "wxUpdateUIEvent_CanUpdate" (byval window as wxWindow ptr) as integer
declare sub wxUpdUIEvt_Enable cdecl alias "wxUpdUIEvt_Enable" (byval self as wxUpdateUIEvent ptr, byval enable as integer)
declare sub wxUpdUIEvt_Check cdecl alias "wxUpdUIEvt_Check" (byval self as wxUpdateUIEvent ptr, byval check as integer)
declare function wxUpdateUIEvent_GetChecked cdecl alias "wxUpdateUIEvent_GetChecked" (byval self as wxUpdateUIEvent ptr) as integer
declare function wxUpdateUIEvent_GetEnabled cdecl alias "wxUpdateUIEvent_GetEnabled" (byval self as wxUpdateUIEvent ptr) as integer
declare function wxUpdateUIEvent_GetSetChecked cdecl alias "wxUpdateUIEvent_GetSetChecked" (byval self as wxUpdateUIEvent ptr) as integer
declare function wxUpdateUIEvent_GetSetEnabled cdecl alias "wxUpdateUIEvent_GetSetEnabled" (byval self as wxUpdateUIEvent ptr) as integer
declare function wxUpdateUIEvent_GetSetText cdecl alias "wxUpdateUIEvent_GetSetText" (byval self as wxUpdateUIEvent ptr) as integer
declare function wxUpdateUIEvent_GetText cdecl alias "wxUpdateUIEvent_GetText" (byval self as wxUpdateUIEvent ptr) as wxString ptr
declare function wxUpdateUIEvent_GetMode cdecl alias "wxUpdateUIEvent_GetMode" () as wxUpdateUIMode
declare function wxUpdateUIEvent_GetUpdateInterval cdecl alias "wxUpdateUIEvent_GetUpdateInterval" () as integer
declare sub wxUpdateUIEvent_ResetUpdateTime cdecl alias "wxUpdateUIEvent_ResetUpdateTime" ()
declare sub wxUpdateUIEvent_SetMode cdecl alias "wxUpdateUIEvent_SetMode" (byval mode as wxUpdateUIMode)
declare sub wxUpdateUIEvent_SetText cdecl alias "wxUpdateUIEvent_SetText" (byval self as wxUpdateUIEvent ptr, byval text as zstring ptr)
declare sub wxUpdateUIEvent_SetUpdateInterval cdecl alias "wxUpdateUIEvent_SetUpdateInterval" (byval updateInterval as integer)

#endif
