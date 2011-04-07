''
''
'' statictext -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __wxc_statictext_bi__
#define __wxc_statictext_bi__

#include once "wx.bi"


declare function wxStaticText alias "wxStaticText_ctor" () as wxStaticText ptr
declare function wxStaticText_Create (byval self as wxStaticText ptr, byval parent as wxWindow ptr, byval id as wxWindowID, byval label as zstring ptr, byval pos as wxPoint ptr, byval size as wxSize ptr, byval style as integer, byval name as zstring ptr) as integer

#endif
