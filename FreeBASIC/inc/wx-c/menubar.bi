''
''
'' menubar -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __menubar_bi__
#define __menubar_bi__

#include once "wx-c/wx.bi"


declare function wxMenuBar cdecl alias "wxMenuBar_ctor" () as wxMenuBar ptr
declare function wxMenuBar_ctor2 cdecl alias "wxMenuBar_ctor2" (byval style as integer) as wxMenuBar ptr
declare function wxMenuBar_Append cdecl alias "wxMenuBar_Append" (byval self as wxMenuBar ptr, byval menu as wxMenu ptr, byval title as string) as integer
declare sub wxMenuBar_Check cdecl alias "wxMenuBar_Check" (byval self as wxMenuBar ptr, byval id as integer, byval check as integer)
declare function wxMenuBar_IsChecked cdecl alias "wxMenuBar_IsChecked" (byval self as wxMenuBar ptr, byval id as integer) as integer
declare function wxMenuBar_Insert cdecl alias "wxMenuBar_Insert" (byval self as wxMenuBar ptr, byval pos as integer, byval menu as wxMenu ptr, byval title as string) as integer
declare function wxMenuBar_FindItem cdecl alias "wxMenuBar_FindItem" (byval self as wxMenuBar ptr, byval id as integer, byval menu as wxMenu ptr ptr) as wxMenuItem ptr
declare function wxMenuBar_GetMenuCount cdecl alias "wxMenuBar_GetMenuCount" (byval self as wxMenuBar ptr) as integer
declare function wxMenuBar_GetMenu cdecl alias "wxMenuBar_GetMenu" (byval self as wxMenuBar ptr, byval pos as integer) as wxMenu ptr
declare function wxMenuBar_Replace cdecl alias "wxMenuBar_Replace" (byval self as wxMenuBar ptr, byval pos as integer, byval menu as wxMenu ptr, byval title as string) as wxMenu ptr
declare function wxMenuBar_Remove cdecl alias "wxMenuBar_Remove" (byval self as wxMenuBar ptr, byval pos as integer) as wxMenu ptr
declare sub wxMenuBar_EnableTop cdecl alias "wxMenuBar_EnableTop" (byval self as wxMenuBar ptr, byval pos as integer, byval enable as integer)
declare sub wxMenuBar_Enable cdecl alias "wxMenuBar_Enable" (byval self as wxMenuBar ptr, byval id as integer, byval enable as integer)
declare function wxMenuBar_FindMenu cdecl alias "wxMenuBar_FindMenu" (byval self as wxMenuBar ptr, byval title as string) as integer
declare function wxMenuBar_FindMenuItem cdecl alias "wxMenuBar_FindMenuItem" (byval self as wxMenuBar ptr, byval menustring as string, byval itemString as string) as integer
declare function wxMenuBar_GetHelpString cdecl alias "wxMenuBar_GetHelpString" (byval self as wxMenuBar ptr, byval id as integer) as wxString ptr
declare function wxMenuBar_GetLabel cdecl alias "wxMenuBar_GetLabel" (byval self as wxMenuBar ptr, byval id as integer) as wxString ptr
declare function wxMenuBar_GetLabelTop cdecl alias "wxMenuBar_GetLabelTop" (byval self as wxMenuBar ptr, byval pos as integer) as wxString ptr
declare function wxMenuBar_IsEnabled cdecl alias "wxMenuBar_IsEnabled" (byval self as wxMenuBar ptr, byval id as integer) as integer
declare sub wxMenuBar_Refresh cdecl alias "wxMenuBar_Refresh" (byval self as wxMenuBar ptr)
declare sub wxMenuBar_SetHelpString cdecl alias "wxMenuBar_SetHelpString" (byval self as wxMenuBar ptr, byval id as integer, byval helpstring as string)
declare sub wxMenuBar_SetLabel cdecl alias "wxMenuBar_SetLabel" (byval self as wxMenuBar ptr, byval id as integer, byval label as string)
declare sub wxMenuBar_SetLabelTop cdecl alias "wxMenuBar_SetLabelTop" (byval self as wxMenuBar ptr, byval pos as integer, byval label as string)

#endif
