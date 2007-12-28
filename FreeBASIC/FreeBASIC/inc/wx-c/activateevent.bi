''
''
'' activateevent -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __wxc_activateevent_bi__
#define __wxc_activateevent_bi__

#include once "wx.bi"

declare function wxActivateEvent alias "wxActivateEvent_ctor" (byval type as wxEventType) as wxActivateEvent ptr
declare function wxActivateEvent_GetActive (byval self as wxActivateEvent ptr) as integer

#endif
