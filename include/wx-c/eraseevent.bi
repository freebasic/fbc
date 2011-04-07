''
''
'' eraseevent -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __wxc_eraseevent_bi__
#define __wxc_eraseevent_bi__

#include once "wx.bi"

declare function wxEraseEvent alias "wxEraseEvent_ctor" (byval type as wxEventType) as wxEraseEvent ptr
declare function wxEraseEvent_GetDC (byval self as wxEraseEvent ptr) as wxDC ptr

#endif
