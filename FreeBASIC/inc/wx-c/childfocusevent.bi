''
''
'' childfocusevent -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __wxc_childfocusevent_bi__
#define __wxc_childfocusevent_bi__

#include once "wx.bi"

declare function wxChildFocusEvent alias "wxChildFocusEvent_ctor" (byval win as wxWindow ptr) as wxChildFocusEvent ptr
declare function wxChildFocusEvent_GetWindow (byval self as wxChildFocusEvent ptr) as wxWindow ptr

#endif
