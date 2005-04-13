''
''
'' staticbox -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __staticbox_bi__
#define __staticbox_bi__

#include once "wx-c/wx.bi"


declare function wxStaticBox cdecl alias "wxStaticBox_ctor" () as wxStaticBox ptr
declare sub wxStaticBox_dtor cdecl alias "wxStaticBox_dtor" (byval self as wxStaticBox ptr)
declare function wxStaticBox_Create cdecl alias "wxStaticBox_Create" (byval self as wxStaticBox ptr, byval parent as wxWindow ptr, byval id as wxWindowID, byval label as string, byval pos as wxPoint ptr, byval size as wxSize ptr, byval style as integer, byval name as string) as integer

#endif
