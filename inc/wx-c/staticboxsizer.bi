''
''
'' staticboxsizer -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __wxc_staticboxsizer_bi__
#define __wxc_staticboxsizer_bi__

#include once "wx.bi"
#include once "sizer.bi"

declare function wxStaticBoxSizer alias "wxStaticBoxSizer_ctor" (byval box as wxStaticBox ptr, byval orient as integer) as wxStaticBoxSizer ptr
declare function wxStaticBoxSizer_GetStaticBox (byval self as wxStaticBoxSizer ptr) as wxStaticBox ptr

#endif
