''
''
'' dialog -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __dialog_bi__
#define __dialog_bi__

#include once "wx-c/wx.bi"

declare function wxDialog cdecl alias "wxDialog_ctor" () as wxDialog ptr
declare sub wxDialog_dtor cdecl alias "wxDialog_dtor" (byval self as wxDialog ptr)
declare function wxDialog_Create cdecl alias "wxDialog_Create" (byval self as wxDialog ptr, byval parent as wxWindow ptr, byval id as integer, byval title as string, byval pos as wxPoint ptr, byval size as wxSize ptr, byval style as integer, byval name as string) as integer
declare sub wxDialog_SetReturnCode cdecl alias "wxDialog_SetReturnCode" (byval self as wxDialog ptr, byval returnCode as integer)
declare function wxDialog_GetReturnCode cdecl alias "wxDialog_GetReturnCode" (byval self as wxDialog ptr) as integer
declare function wxDialog_GetTitle cdecl alias "wxDialog_GetTitle" (byval self as wxDialog ptr) as wxString ptr
declare sub wxDialog_SetTitle cdecl alias "wxDialog_SetTitle" (byval self as wxDialog ptr, byval title as string)
declare sub wxDialog_EndModal cdecl alias "wxDialog_EndModal" (byval self as wxDialog ptr, byval retCode as integer)
declare function wxDialog_IsModal cdecl alias "wxDialog_IsModal" (byval self as wxDialog ptr) as integer
declare sub wxDialog_SetModal cdecl alias "wxDialog_SetModal" (byval self as wxDialog ptr, byval modal as integer)
declare sub wxDialog_SetIcon cdecl alias "wxDialog_SetIcon" (byval self as wxDialog ptr, byval icon as wxIcon ptr)
declare sub wxDialog_SetIcons cdecl alias "wxDialog_SetIcons" (byval self as wxDialog ptr, byval icons as wxIconBundle ptr)
declare function wxDialog_ShowModal cdecl alias "wxDialog_ShowModal" (byval self as wxDialog ptr) as integer

#endif
