''
''
'' iconizeevent -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __wxc_iconizeevent_bi__
#define __wxc_iconizeevent_bi__

#include once "wx.bi"

declare function wxIconizeEvent alias "wxIconizeEvent_ctor" (byval type as wxEventType) as wxIconizeEvent ptr
declare function wxIconizeEvent_Iconized (byval self as wxIconizeEvent ptr) as integer

#endif
