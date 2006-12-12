''
''
'' boxsizer -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __wxc_boxsizer_bi__
#define __wxc_boxsizer_bi__

#include once "wx.bi"


type Virtual_voidvoid as sub WXCALL ( )
type Virtual_sizevoid as function WXCALL ( ) as wxSize ptr

declare sub wxBoxSizer_RegisterVirtual (byval self as _BoxSizer ptr, byval recalcSizes as Virtual_voidvoid, byval calcMin as Virtual_sizevoid)
declare function wxBoxSizer alias "wxBoxSizer_ctor" (byval orient as integer) as wxBoxSizer ptr
declare sub wxBoxSizer_RegisterDisposable (byval self as _BoxSizer ptr, byval onDispose as Virtual_Dispose)
declare sub wxBoxSizer_RecalcSizes (byval self as _BoxSizer ptr)
declare function wxBoxSizer_CalcMin (byval self as _BoxSizer ptr) as wxSize ptr
declare function wxBoxSizer_GetOrientation (byval self as _BoxSizer ptr) as integer
declare sub wxBoxSizer_SetOrientation (byval self as _BoxSizer ptr, byval orient as integer)

#endif
