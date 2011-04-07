''
''
'' sizeevent -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __wxc_sizeevent_bi__
#define __wxc_sizeevent_bi__

#include once "wx.bi"

declare function wxSizeEvent alias "wxSizeEvent_ctor" () as wxSizeEvent ptr
declare sub wxSizeEvent_GetSize (byval self as wxSizeEvent ptr, byval size as wxSize ptr)

#endif
