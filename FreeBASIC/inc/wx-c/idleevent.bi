''
''
'' idleevent -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __wxc_idleevent_bi__
#define __wxc_idleevent_bi__

#include once "wx.bi"

declare function wxIdleEvent alias "wxIdleEvent_ctor" () as wxIdleEvent ptr
declare sub wxIdleEvent_RequestMore (byval self as wxIdleEvent ptr, byval needMore as integer)
declare function wxIdleEvent_MoreRequested (byval self as wxIdleEvent ptr) as integer
declare sub wxIdleEvent_SetMode (byval mode as wxIdleMode)
declare function wxIdleEvent_GetMode () as wxIdleMode
declare function wxIdleEvent_CanSend (byval win as wxWindow ptr) as integer

#endif
