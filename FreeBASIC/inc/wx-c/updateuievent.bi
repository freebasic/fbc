''
''
'' updateuievent -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __wxc_updateuievent_bi__
#define __wxc_updateuievent_bi__

#include once "wx.bi"

declare function wxUpdateUIEvent alias "wxUpdateUIEvent_ctor" (byval commandId as wxWindowID) as wxUpdateUIEvent ptr
declare function wxUpdateUIEvent_CanUpdate (byval window as wxWindow ptr) as integer
declare sub wxUpdUIEvt_Enable (byval self as wxUpdateUIEvent ptr, byval enable as integer)
declare sub wxUpdUIEvt_Check (byval self as wxUpdateUIEvent ptr, byval check as integer)
declare function wxUpdateUIEvent_GetChecked (byval self as wxUpdateUIEvent ptr) as integer
declare function wxUpdateUIEvent_GetEnabled (byval self as wxUpdateUIEvent ptr) as integer
declare function wxUpdateUIEvent_GetSetChecked (byval self as wxUpdateUIEvent ptr) as integer
declare function wxUpdateUIEvent_GetSetEnabled (byval self as wxUpdateUIEvent ptr) as integer
declare function wxUpdateUIEvent_GetSetText (byval self as wxUpdateUIEvent ptr) as integer
declare function wxUpdateUIEvent_GetText (byval self as wxUpdateUIEvent ptr) as wxString ptr
declare function wxUpdateUIEvent_GetMode () as wxUpdateUIMode
declare function wxUpdateUIEvent_GetUpdateInterval () as integer
declare sub wxUpdateUIEvent_ResetUpdateTime ()
declare sub wxUpdateUIEvent_SetMode (byval mode as wxUpdateUIMode)
declare sub wxUpdateUIEvent_SetText (byval self as wxUpdateUIEvent ptr, byval text as zstring ptr)
declare sub wxUpdateUIEvent_SetUpdateInterval (byval updateInterval as integer)

#endif
