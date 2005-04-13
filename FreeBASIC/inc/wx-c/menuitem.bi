''
''
'' menuitem -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __menuitem_bi__
#define __menuitem_bi__

#include once "wx-c/wx.bi"

declare function wxMenuItem cdecl alias "wxMenuItem_ctor" (byval parentMenu as wxMenu ptr, byval id as integer, byval text as string, byval help as string, byval kind as wxItemKind, byval subMenu as wxMenu ptr) as wxMenuItem ptr
declare function wxMenuItem_GetMenu cdecl alias "wxMenuItem_GetMenu" (byval self as wxMenuItem ptr) as wxMenu ptr
declare sub wxMenuItem_SetMenu cdecl alias "wxMenuItem_SetMenu" (byval self as wxMenuItem ptr, byval menu as wxMenu ptr)
declare sub wxMenuItem_SetId cdecl alias "wxMenuItem_SetId" (byval self as wxMenuItem ptr, byval id as integer)
declare function wxMenuItem_GetId cdecl alias "wxMenuItem_GetId" (byval self as wxMenuItem ptr) as integer
declare function wxMenuItem_IsSeparator cdecl alias "wxMenuItem_IsSeparator" (byval self as wxMenuItem ptr) as integer
declare sub wxMenuItem_SetText cdecl alias "wxMenuItem_SetText" (byval self as wxMenuItem ptr, byval str as string)
declare function wxMenuItem_GetLabel cdecl alias "wxMenuItem_GetLabel" (byval self as wxMenuItem ptr) as wxString ptr
declare function wxMenuItem_GetText cdecl alias "wxMenuItem_GetText" (byval self as wxMenuItem ptr) as wxString ptr
declare function wxMenuItem_GetLabelFromText cdecl alias "wxMenuItem_GetLabelFromText" (byval self as wxMenuItem ptr, byval text as string) as wxString ptr
declare function wxMenuItem_GetKind cdecl alias "wxMenuItem_GetKind" (byval self as wxMenuItem ptr) as wxItemKind
declare sub wxMenuItem_SetCheckable cdecl alias "wxMenuItem_SetCheckable" (byval self as wxMenuItem ptr, byval checkable as integer)
declare function wxMenuItem_IsCheckable cdecl alias "wxMenuItem_IsCheckable" (byval self as wxMenuItem ptr) as integer
declare function wxMenuItem_IsSubMenu cdecl alias "wxMenuItem_IsSubMenu" (byval self as wxMenuItem ptr) as integer
declare sub wxMenuItem_SetSubMenu cdecl alias "wxMenuItem_SetSubMenu" (byval self as wxMenuItem ptr, byval menu as wxMenu ptr)
declare function wxMenuItem_GetSubMenu cdecl alias "wxMenuItem_GetSubMenu" (byval self as wxMenuItem ptr) as wxMenu ptr
declare sub wxMenuItem_Enable cdecl alias "wxMenuItem_Enable" (byval self as wxMenuItem ptr, byval enable as integer)
declare function wxMenuItem_IsEnabled cdecl alias "wxMenuItem_IsEnabled" (byval self as wxMenuItem ptr) as integer
declare sub wxMenuItem_Check cdecl alias "wxMenuItem_Check" (byval self as wxMenuItem ptr, byval check as integer)
declare function wxMenuItem_IsChecked cdecl alias "wxMenuItem_IsChecked" (byval self as wxMenuItem ptr) as integer
declare sub wxMenuItem_Toggle cdecl alias "wxMenuItem_Toggle" (byval self as wxMenuItem ptr)
declare sub wxMenuItem_SetHelp cdecl alias "wxMenuItem_SetHelp" (byval self as wxMenuItem ptr, byval str as string)
declare function wxMenuItem_GetHelp cdecl alias "wxMenuItem_GetHelp" (byval self as wxMenuItem ptr) as wxString ptr
declare function wxMenuItem_GetAccel cdecl alias "wxMenuItem_GetAccel" (byval self as wxMenuItem ptr) as wxAcceleratorEntry ptr
declare sub wxMenuItem_SetAccel cdecl alias "wxMenuItem_SetAccel" (byval self as wxMenuItem ptr, byval accel as wxAcceleratorEntry ptr)
declare sub wxMenuItem_SetName cdecl alias "wxMenuItem_SetName" (byval self as wxMenuItem ptr, byval str as string)
declare function wxMenuItem_GetName cdecl alias "wxMenuItem_GetName" (byval self as wxMenuItem ptr) as wxString ptr
declare function wxMenuItem_NewCheck cdecl alias "wxMenuItem_NewCheck" (byval parentMenu as wxMenu ptr, byval id as integer, byval text as string, byval help as string, byval isCheckable as integer, byval subMenu as wxMenu ptr) as wxMenuItem ptr
declare function wxMenuItem_New cdecl alias "wxMenuItem_New" (byval parentMenu as wxMenu ptr, byval id as integer, byval text as string, byval help as string, byval kind as wxItemKind, byval subMenu as wxMenu ptr) as wxMenuItem ptr
declare sub wxMenuItem_SetBitmap cdecl alias "wxMenuItem_SetBitmap" (byval self as wxMenuItem ptr, byval bitmap as wxBitmap ptr)
declare function wxMenuItem_GetBitmap cdecl alias "wxMenuItem_GetBitmap" (byval self as wxMenuItem ptr) as wxBitmap ptr

#endif
