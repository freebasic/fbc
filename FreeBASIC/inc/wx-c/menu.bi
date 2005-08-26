''
''
'' menu -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __menu_bi__
#define __menu_bi__

#include once "wx-c/wx.bi"


declare function wxMenuBase_ctor1 cdecl alias "wxMenuBase_ctor1" (byval title as zstring ptr, byval style as integer) as wxMenuBase ptr
declare function wxMenuBase_ctor2 cdecl alias "wxMenuBase_ctor2" (byval style as integer) as wxMenuBase ptr
declare function wxMenuBase_Append cdecl alias "wxMenuBase_Append" (byval self as wxMenuBase ptr, byval id as integer, byval item as zstring ptr, byval helpString as zstring ptr, byval kind as wxItemKind) as wxMenuItem ptr
declare function wxMenuBase_AppendSeparator cdecl alias "wxMenuBase_AppendSeparator" (byval self as wxMenuBase ptr) as wxMenuItem ptr
declare function wxMenuBase_AppendCheckItem cdecl alias "wxMenuBase_AppendCheckItem" (byval self as wxMenuBase ptr, byval itemid as integer, byval text as zstring ptr, byval help as zstring ptr) as wxMenuItem ptr
declare function wxMenuBase_AppendRadioItem cdecl alias "wxMenuBase_AppendRadioItem" (byval self as wxMenuBase ptr, byval itemid as integer, byval text as zstring ptr, byval help as zstring ptr) as wxMenuItem ptr
declare function wxMenuBase_AppendSubMenu cdecl alias "wxMenuBase_AppendSubMenu" (byval self as wxMenuBase ptr, byval id as integer, byval item as zstring ptr, byval subMenu as wxMenu ptr, byval helpString as zstring ptr) as wxMenuItem ptr
declare function wxMenuBase_AppendItem cdecl alias "wxMenuBase_AppendItem" (byval self as wxMenuBase ptr, byval item as wxMenuItem ptr) as wxMenuItem ptr
declare sub wxMenuBase_Break cdecl alias "wxMenuBase_Break" (byval self as wxMenuBase ptr)
declare function wxMenuBase_Insert cdecl alias "wxMenuBase_Insert" (byval self as wxMenuBase ptr, byval pos as integer, byval item as wxMenuItem ptr) as wxMenuItem ptr
declare function wxMenuBase_Insert2 cdecl alias "wxMenuBase_Insert2" (byval self as wxMenuBase ptr, byval pos as integer, byval itemid as integer, byval text as zstring ptr, byval help as zstring ptr, byval kind as wxItemKind) as wxMenuItem ptr
declare function wxMenuBase_InsertSeparator cdecl alias "wxMenuBase_InsertSeparator" (byval self as wxMenuBase ptr, byval pos as integer) as wxMenuItem ptr
declare function wxMenuBase_InsertCheckItem cdecl alias "wxMenuBase_InsertCheckItem" (byval self as wxMenuBase ptr, byval pos as integer, byval itemid as integer, byval text as zstring ptr, byval help as zstring ptr) as wxMenuItem ptr
declare function wxMenuBase_InsertRadioItem cdecl alias "wxMenuBase_InsertRadioItem" (byval self as wxMenuBase ptr, byval pos as integer, byval itemid as integer, byval text as zstring ptr, byval help as zstring ptr) as wxMenuItem ptr
declare function wxMenuBase_InsertSubMenu cdecl alias "wxMenuBase_InsertSubMenu" (byval self as wxMenuBase ptr, byval pos as integer, byval itemid as integer, byval text as zstring ptr, byval submenu as wxMenu ptr, byval help as zstring ptr) as wxMenuItem ptr
declare function wxMenuBase_Prepend cdecl alias "wxMenuBase_Prepend" (byval self as wxMenuBase ptr, byval item as wxMenuItem ptr) as wxMenuItem ptr
declare function wxMenuBase_Prepend2 cdecl alias "wxMenuBase_Prepend2" (byval self as wxMenuBase ptr, byval itemid as integer, byval text as zstring ptr, byval help as zstring ptr, byval kind as wxItemKind) as wxMenuItem ptr
declare function wxMenuBase_PrependSeparator cdecl alias "wxMenuBase_PrependSeparator" (byval self as wxMenuBase ptr) as wxMenuItem ptr
declare function wxMenuBase_PrependCheckItem cdecl alias "wxMenuBase_PrependCheckItem" (byval self as wxMenuBase ptr, byval itemid as integer, byval text as zstring ptr, byval help as zstring ptr) as wxMenuItem ptr
declare function wxMenuBase_PrependRadioItem cdecl alias "wxMenuBase_PrependRadioItem" (byval self as wxMenuBase ptr, byval itemid as integer, byval text as zstring ptr, byval help as zstring ptr) as wxMenuItem ptr
declare function wxMenuBase_PrependSubMenu cdecl alias "wxMenuBase_PrependSubMenu" (byval self as wxMenuBase ptr, byval itemid as integer, byval text as zstring ptr, byval submenu as wxMenu ptr, byval help as zstring ptr) as wxMenuItem ptr
declare function wxMenuBase_Remove cdecl alias "wxMenuBase_Remove" (byval self as wxMenuBase ptr, byval itemid as integer) as wxMenuItem ptr
declare function wxMenuBase_Remove2 cdecl alias "wxMenuBase_Remove2" (byval self as wxMenuBase ptr, byval item as wxMenuItem ptr) as wxMenuItem ptr
declare function wxMenuBase_Delete cdecl alias "wxMenuBase_Delete" (byval self as wxMenuBase ptr, byval itemid as integer) as integer
declare function wxMenuBase_Delete2 cdecl alias "wxMenuBase_Delete2" (byval self as wxMenuBase ptr, byval item as wxMenuItem ptr) as integer
declare function wxMenuBase_Destroy cdecl alias "wxMenuBase_Destroy" (byval self as wxMenuBase ptr, byval itemid as integer) as integer
declare function wxMenuBase_Destroy2 cdecl alias "wxMenuBase_Destroy2" (byval self as wxMenuBase ptr, byval item as wxMenuItem ptr) as integer
declare function wxMenuBase_GetMenuItemCount cdecl alias "wxMenuBase_GetMenuItemCount" (byval self as wxMenuBase ptr) as integer
declare function wxMenuBase_FindItem cdecl alias "wxMenuBase_FindItem" (byval self as wxMenuBase ptr, byval item as zstring ptr) as integer
declare function wxMenuBase_FindItem2 cdecl alias "wxMenuBase_FindItem2" (byval self as wxMenuBase ptr, byval itemid as integer, byval menu as wxMenu ptr ptr) as wxMenuItem ptr
declare function wxMenuBase_FindItemByPosition cdecl alias "wxMenuBase_FindItemByPosition" (byval self as wxMenuBase ptr, byval position as integer) as wxMenuItem ptr
declare sub wxMenuBase_Enable cdecl alias "wxMenuBase_Enable" (byval self as wxMenuBase ptr, byval itemid as integer, byval enable as integer)
declare function wxMenuBase_IsEnabled cdecl alias "wxMenuBase_IsEnabled" (byval self as wxMenuBase ptr, byval itemid as integer) as integer
declare sub wxMenuBase_Check cdecl alias "wxMenuBase_Check" (byval self as wxMenuBase ptr, byval itemid as integer, byval check as integer)
declare function wxMenuBase_IsChecked cdecl alias "wxMenuBase_IsChecked" (byval self as wxMenuBase ptr, byval itemid as integer) as integer
declare sub wxMenuBase_SetLabel cdecl alias "wxMenuBase_SetLabel" (byval self as wxMenuBase ptr, byval itemid as integer, byval label as zstring ptr)
declare function wxMenuBase_GetLabel cdecl alias "wxMenuBase_GetLabel" (byval self as wxMenuBase ptr, byval itemid as integer) as wxString ptr
declare sub wxMenuBase_SetHelpString cdecl alias "wxMenuBase_SetHelpString" (byval self as wxMenuBase ptr, byval itemid as integer, byval helpString as zstring ptr)
declare function wxMenuBase_GetHelpString cdecl alias "wxMenuBase_GetHelpString" (byval self as wxMenuBase ptr, byval itemid as integer) as wxString ptr
declare sub wxMenuBase_SetTitle cdecl alias "wxMenuBase_SetTitle" (byval self as wxMenuBase ptr, byval title as zstring ptr)
declare function wxMenuBase_GetTitle cdecl alias "wxMenuBase_GetTitle" (byval self as wxMenuBase ptr) as wxString ptr
declare sub wxMenuBase_SetEventHandler cdecl alias "wxMenuBase_SetEventHandler" (byval self as wxMenuBase ptr, byval handler as wxEvtHandler ptr)
declare function wxMenuBase_GetEventHandler cdecl alias "wxMenuBase_GetEventHandler" (byval self as wxMenuBase ptr) as wxEvtHandler ptr
declare sub wxMenuBase_SetInvokingWindow cdecl alias "wxMenuBase_SetInvokingWindow" (byval self as wxMenuBase ptr, byval win as wxWindow ptr)
declare function wxMenuBase_GetInvokingWindow cdecl alias "wxMenuBase_GetInvokingWindow" (byval self as wxMenuBase ptr) as wxWindow ptr
declare function wxMenuBase_GetStyle cdecl alias "wxMenuBase_GetStyle" (byval self as wxMenuBase ptr) as integer
declare sub wxMenuBase_UpdateUI cdecl alias "wxMenuBase_UpdateUI" (byval self as wxMenuBase ptr, byval source as wxEvtHandler ptr)
declare function wxMenuBase_GetMenuBar cdecl alias "wxMenuBase_GetMenuBar" (byval self as wxMenuBase ptr) as wxMenuBar ptr
declare function wxMenuBase_IsAttached cdecl alias "wxMenuBase_IsAttached" (byval self as wxMenuBase ptr) as integer
declare sub wxMenuBase_SetParent cdecl alias "wxMenuBase_SetParent" (byval self as wxMenuBase ptr, byval parent as wxMenu ptr)
declare function wxMenuBase_GetParent cdecl alias "wxMenuBase_GetParent" (byval self as wxMenuBase ptr) as wxMenu ptr
declare function wxMenuBase_FindChildItem cdecl alias "wxMenuBase_FindChildItem" (byval self as wxMenuBase ptr, byval itemid as integer, byval pos as integer ptr) as wxMenuItem ptr
declare function wxMenuBase_FindChildItem2 cdecl alias "wxMenuBase_FindChildItem2" (byval self as wxMenuBase ptr, byval itemid as integer) as wxMenuItem ptr
declare function wxMenuBase_SendEvent cdecl alias "wxMenuBase_SendEvent" (byval self as wxMenuBase ptr, byval itemid as integer, byval checked as integer) as integer

declare function wxMenu cdecl alias "wxMenu_ctor" (byval titel as zstring ptr, byval style as integer) as wxMenu ptr
declare function wxMenu_ctor2 cdecl alias "wxMenu_ctor2" (byval style as integer) as wxMenu ptr

#endif
