''
''
'' spinctrl -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __wxc_spinctrl_bi__
#define __wxc_spinctrl_bi__

#include once "wx.bi"


declare function wxSpinCtrl alias "wxSpinCtrl_ctor" () as wxSpinCtrl ptr
declare function wxSpinCtrl_Create (byval self as wxSpinCtrl ptr, byval parent as wxWindow ptr, byval id as wxWindowID, byval value as zstring ptr, byval pos as wxPoint ptr, byval size as wxSize ptr, byval style as integer, byval min as integer, byval max as integer, byval initial as integer, byval name as zstring ptr) as integer
declare sub wxSpinCtrl_dtor (byval self as wxSpinCtrl ptr)
declare sub wxSpinCtrl_SetValue (byval self as wxSpinCtrl ptr, byval val as integer)
declare sub wxSpinCtrl_SetValueStr (byval self as wxSpinCtrl ptr, byval text as zstring ptr)
declare sub wxSpinCtrl_SetRange (byval self as wxSpinCtrl ptr, byval min as integer, byval max as integer)
declare function wxSpinCtrl_GetValue (byval self as wxSpinCtrl ptr) as integer
declare function wxSpinCtrl_GetMin (byval self as wxSpinCtrl ptr) as integer
declare function wxSpinCtrl_GetMax (byval self as wxSpinCtrl ptr) as integer

#endif
