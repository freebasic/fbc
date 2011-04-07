''
''
'' dialog -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __wxc_dialog_bi__
#define __wxc_dialog_bi__

#include once "wx.bi"

declare function wxDialog alias "wxDialog_ctor" () as wxDialog ptr
declare sub wxDialog_dtor (byval self as wxDialog ptr)
declare function wxDialog_Create (byval self as wxDialog ptr, byval parent as wxWindow ptr, byval id as integer, byval title as zstring ptr, byval pos as wxPoint ptr, byval size as wxSize ptr, byval style as integer, byval name as zstring ptr) as integer
declare sub wxDialog_SetReturnCode (byval self as wxDialog ptr, byval returnCode as integer)
declare function wxDialog_GetReturnCode (byval self as wxDialog ptr) as integer
declare function wxDialog_GetTitle (byval self as wxDialog ptr) as wxString ptr
declare sub wxDialog_SetTitle (byval self as wxDialog ptr, byval title as zstring ptr)
declare sub wxDialog_EndModal (byval self as wxDialog ptr, byval retCode as integer)
declare function wxDialog_IsModal (byval self as wxDialog ptr) as integer
declare sub wxDialog_SetModal (byval self as wxDialog ptr, byval modal as integer)
declare sub wxDialog_SetIcon (byval self as wxDialog ptr, byval icon as wxIcon ptr)
declare sub wxDialog_SetIcons (byval self as wxDialog ptr, byval icons as wxIconBundle ptr)
declare function wxDialog_ShowModal (byval self as wxDialog ptr) as integer

#endif
