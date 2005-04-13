''
''
'' boxsizer -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __boxsizer_bi__
#define __boxsizer_bi__

#include once "wx-c/wx.bi"


type Virtual_voidvoid as sub cdecl( )
type Virtual_sizevoid as function cdecl( ) as wxSize

declare sub wxBoxSizer_RegisterVirtual cdecl alias "wxBoxSizer_RegisterVirtual" (byval self as _BoxSizer ptr, byval recalcSizes as Virtual_voidvoid, byval calcMin as Virtual_sizevoid)
declare function wxBoxSizer cdecl alias "wxBoxSizer_ctor" (byval orient as integer) as wxBoxSizer ptr
declare sub wxBoxSizer_RegisterDisposable cdecl alias "wxBoxSizer_RegisterDisposable" (byval self as _BoxSizer ptr, byval onDispose as Virtual_Dispose)
declare sub wxBoxSizer_RecalcSizes cdecl alias "wxBoxSizer_RecalcSizes" (byval self as _BoxSizer ptr)
declare function wxBoxSizer_CalcMin cdecl alias "wxBoxSizer_CalcMin" (byval self as _BoxSizer ptr) as wxSize ptr
declare function wxBoxSizer_GetOrientation cdecl alias "wxBoxSizer_GetOrientation" (byval self as _BoxSizer ptr) as integer
declare sub wxBoxSizer_SetOrientation cdecl alias "wxBoxSizer_SetOrientation" (byval self as _BoxSizer ptr, byval orient as integer)

#endif
