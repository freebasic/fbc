''
''
'' staticbox -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __wxc_staticbox_bi__
#define __wxc_staticbox_bi__

#include once "wx.bi"


declare function wxStaticBox alias "wxStaticBox_ctor" () as wxStaticBox ptr
declare sub wxStaticBox_dtor (byval self as wxStaticBox ptr)
declare function wxStaticBox_Create (byval self as wxStaticBox ptr, byval parent as wxWindow ptr, byval id as wxWindowID, byval label as zstring ptr, byval pos as wxPoint ptr, byval size as wxSize ptr, byval style as integer, byval name as zstring ptr) as integer

#endif
