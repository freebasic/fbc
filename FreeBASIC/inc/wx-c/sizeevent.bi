''
''
'' sizeevent -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __sizeevent_bi__
#define __sizeevent_bi__

#include once "wx-c/wx.bi"

declare function wxSizeEvent cdecl alias "wxSizeEvent_ctor" () as wxSizeEvent ptr
declare sub wxSizeEvent_GetSize cdecl alias "wxSizeEvent_GetSize" (byval self as wxSizeEvent ptr, byval size as wxSize ptr)

#endif
