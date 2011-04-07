''
''
'' evthandler -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __wxc_evthandler_bi__
#define __wxc_evthandler_bi__

#include once "wx.bi"


type EventListener as sub WXCALL (byval as wxEvent ptr, byval as integer)

type wxProxyData
	iListener as integer
end type

declare sub wxEvtHandler_proxy (byval self as wxEvtHandler ptr, byval listener as EventListener)
declare sub wxEvtHandler_Connect (byval self as wxEvtHandler ptr, byval evtType as integer, byval id as integer, byval lastId as integer, byval iListener as integer)
declare function wxEvtHandler_ProcessEvent (byval self as wxEvtHandler ptr, byval event as wxEvent ptr) as integer
declare sub wxEvtHandler_AddPendingEvent (byval self as wxEvtHandler ptr, byval event as wxEvent ptr)

#endif
