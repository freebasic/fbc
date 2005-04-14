''
''
'' evthandler -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __evthandler_bi__
#define __evthandler_bi__

#include once "wx-c/wx.bi"


type EventListener as sub (byval as wxEvent ptr, byval as integer)

type wxProxyData
	iListener as integer
end type

declare sub wxEvtHandler_proxy cdecl alias "wxEvtHandler_proxy" (byval self as wxEvtHandler ptr, byval listener as EventListener)
declare sub wxEvtHandler_Connect cdecl alias "wxEvtHandler_Connect" (byval self as wxEvtHandler ptr, byval evtType as integer, byval id as integer, byval lastId as integer, byval iListener as integer)
declare function wxEvtHandler_ProcessEvent cdecl alias "wxEvtHandler_ProcessEvent" (byval self as wxEvtHandler ptr, byval event as wxEvent ptr) as integer
declare sub wxEvtHandler_AddPendingEvent cdecl alias "wxEvtHandler_AddPendingEvent" (byval self as wxEvtHandler ptr, byval event as wxEvent ptr)

#endif
