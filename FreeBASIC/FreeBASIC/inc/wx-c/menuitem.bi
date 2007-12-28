''
''
'' menuitem -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __wxc_menuitem_bi__
#define __wxc_menuitem_bi__

#include once "wx.bi"

declare function wxMenuItem alias "wxMenuItem_ctor" (byval parentMenu as wxMenu ptr, byval id as integer, byval text as zstring ptr, byval help as zstring ptr, byval kind as wxItemKind, byval subMenu as wxMenu ptr) as wxMenuItem ptr
declare function wxMenuItem_GetMenu (byval self as wxMenuItem ptr) as wxMenu ptr
declare sub wxMenuItem_SetMenu (byval self as wxMenuItem ptr, byval menu as wxMenu ptr)
declare sub wxMenuItem_SetId (byval self as wxMenuItem ptr, byval id as integer)
declare function wxMenuItem_GetId (byval self as wxMenuItem ptr) as integer
declare function wxMenuItem_IsSeparator (byval self as wxMenuItem ptr) as integer
declare sub wxMenuItem_SetText (byval self as wxMenuItem ptr, byval str as zstring ptr)
declare function wxMenuItem_GetLabel (byval self as wxMenuItem ptr) as wxString ptr
declare function wxMenuItem_GetText (byval self as wxMenuItem ptr) as wxString ptr
declare function wxMenuItem_GetLabelFromText (byval self as wxMenuItem ptr, byval text as zstring ptr) as wxString ptr
declare function wxMenuItem_GetKind (byval self as wxMenuItem ptr) as wxItemKind
declare sub wxMenuItem_SetCheckable (byval self as wxMenuItem ptr, byval checkable as integer)
declare function wxMenuItem_IsCheckable (byval self as wxMenuItem ptr) as integer
declare function wxMenuItem_IsSubMenu (byval self as wxMenuItem ptr) as integer
declare sub wxMenuItem_SetSubMenu (byval self as wxMenuItem ptr, byval menu as wxMenu ptr)
declare function wxMenuItem_GetSubMenu (byval self as wxMenuItem ptr) as wxMenu ptr
declare sub wxMenuItem_Enable (byval self as wxMenuItem ptr, byval enable as integer)
declare function wxMenuItem_IsEnabled (byval self as wxMenuItem ptr) as integer
declare sub wxMenuItem_Check (byval self as wxMenuItem ptr, byval check as integer)
declare function wxMenuItem_IsChecked (byval self as wxMenuItem ptr) as integer
declare sub wxMenuItem_Toggle (byval self as wxMenuItem ptr)
declare sub wxMenuItem_SetHelp (byval self as wxMenuItem ptr, byval str as zstring ptr)
declare function wxMenuItem_GetHelp (byval self as wxMenuItem ptr) as wxString ptr
declare function wxMenuItem_GetAccel (byval self as wxMenuItem ptr) as wxAcceleratorEntry ptr
declare sub wxMenuItem_SetAccel (byval self as wxMenuItem ptr, byval accel as wxAcceleratorEntry ptr)
declare sub wxMenuItem_SetName (byval self as wxMenuItem ptr, byval str as zstring ptr)
declare function wxMenuItem_GetName (byval self as wxMenuItem ptr) as wxString ptr
declare function wxMenuItem_NewCheck (byval parentMenu as wxMenu ptr, byval id as integer, byval text as zstring ptr, byval help as zstring ptr, byval isCheckable as integer, byval subMenu as wxMenu ptr) as wxMenuItem ptr
declare function wxMenuItem_New (byval parentMenu as wxMenu ptr, byval id as integer, byval text as zstring ptr, byval help as zstring ptr, byval kind as wxItemKind, byval subMenu as wxMenu ptr) as wxMenuItem ptr
declare sub wxMenuItem_SetBitmap (byval self as wxMenuItem ptr, byval bitmap as wxBitmap ptr)
declare function wxMenuItem_GetBitmap (byval self as wxMenuItem ptr) as wxBitmap ptr

#endif
