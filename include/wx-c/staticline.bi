''
''
'' staticline -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __wxc_staticline_bi__
#define __wxc_staticline_bi__

#include once "wx.bi"


declare function wxStaticLine alias "wxStaticLine_ctor" () as wxStaticLine ptr
declare function wxStaticLine_Create (byval self as wxStaticLine ptr, byval parent as wxWindow ptr, byval id as wxWindowID, byval pos as wxPoint ptr, byval size as wxSize ptr, byval style as integer, byval name as zstring ptr) as integer
declare function wxStaticLine_IsVertical (byval self as wxStaticLine ptr) as integer
declare function wxStaticLine_GetDefaultSize (byval self as wxStaticLine ptr) as integer

#endif
