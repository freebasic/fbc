''
''
'' menubar -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __wxc_menubar_bi__
#define __wxc_menubar_bi__

#include once "wx.bi"


declare function wxMenuBar alias "wxMenuBar_ctor" () as wxMenuBar ptr
declare function wxMenuBar_ctor2 (byval style as integer) as wxMenuBar ptr
declare function wxMenuBar_Append (byval self as wxMenuBar ptr, byval menu as wxMenu ptr, byval title as zstring ptr) as integer
declare sub wxMenuBar_Check (byval self as wxMenuBar ptr, byval id as integer, byval check as integer)
declare function wxMenuBar_IsChecked (byval self as wxMenuBar ptr, byval id as integer) as integer
declare function wxMenuBar_Insert (byval self as wxMenuBar ptr, byval pos as integer, byval menu as wxMenu ptr, byval title as zstring ptr) as integer
declare function wxMenuBar_FindItem (byval self as wxMenuBar ptr, byval id as integer, byval menu as wxMenu ptr ptr) as wxMenuItem ptr
declare function wxMenuBar_GetMenuCount (byval self as wxMenuBar ptr) as integer
declare function wxMenuBar_GetMenu (byval self as wxMenuBar ptr, byval pos as integer) as wxMenu ptr
declare function wxMenuBar_Replace (byval self as wxMenuBar ptr, byval pos as integer, byval menu as wxMenu ptr, byval title as zstring ptr) as wxMenu ptr
declare function wxMenuBar_Remove (byval self as wxMenuBar ptr, byval pos as integer) as wxMenu ptr
declare sub wxMenuBar_EnableTop (byval self as wxMenuBar ptr, byval pos as integer, byval enable as integer)
declare sub wxMenuBar_Enable (byval self as wxMenuBar ptr, byval id as integer, byval enable as integer)
declare function wxMenuBar_FindMenu (byval self as wxMenuBar ptr, byval title as zstring ptr) as integer
declare function wxMenuBar_FindMenuItem (byval self as wxMenuBar ptr, byval menustring as zstring ptr, byval itemString as zstring ptr) as integer
declare function wxMenuBar_GetHelpString (byval self as wxMenuBar ptr, byval id as integer) as wxString ptr
declare function wxMenuBar_GetLabel (byval self as wxMenuBar ptr, byval id as integer) as wxString ptr
declare function wxMenuBar_GetLabelTop (byval self as wxMenuBar ptr, byval pos as integer) as wxString ptr
declare function wxMenuBar_IsEnabled (byval self as wxMenuBar ptr, byval id as integer) as integer
declare sub wxMenuBar_Refresh (byval self as wxMenuBar ptr)
declare sub wxMenuBar_SetHelpString (byval self as wxMenuBar ptr, byval id as integer, byval helpstring as zstring ptr)
declare sub wxMenuBar_SetLabel (byval self as wxMenuBar ptr, byval id as integer, byval label as zstring ptr)
declare sub wxMenuBar_SetLabelTop (byval self as wxMenuBar ptr, byval pos as integer, byval label as zstring ptr)

#endif
