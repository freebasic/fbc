''
''
'' closeevent -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __wxc_closeevent_bi__
#define __wxc_closeevent_bi__

#include once "wx.bi"

declare function wxCloseEvent alias "wxCloseEvent_ctor" (byval type as wxEventType) as wxCloseEvent ptr
declare sub wxCloseEvent_SetLoggingOff (byval self as wxCloseEvent ptr, byval logOff as integer)
declare function wxCloseEvent_GetLoggingOff (byval self as wxCloseEvent ptr) as integer
declare sub wxCloseEvent_Veto (byval self as wxCloseEvent ptr, byval veto as integer)
declare sub wxCloseEvent_SetCanVeto (byval self as wxCloseEvent ptr, byval canVeto as integer)
declare function wxCloseEvent_CanVeto (byval self as wxCloseEvent ptr) as integer
declare function wxCloseEvent_GetVeto (byval self as wxCloseEvent ptr) as integer

#endif
