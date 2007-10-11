''
''
'' miniframe -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __wxc_miniframe_bi__
#define __wxc_miniframe_bi__

#include once "wx.bi"


declare function wxMiniFrame alias "wxMiniFrame_ctor" () as wxMiniFrame ptr
declare function wxMiniFrame_Create (byval self as wxMiniFrame ptr, byval parent as wxWindow ptr, byval id as wxWindowID, byval title as zstring ptr, byval pos as wxPoint ptr, byval size as wxSize ptr, byval style as integer, byval name as zstring ptr) as integer

#endif
