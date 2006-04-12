''
''
'' combobox -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __wxc_combobox_bi__
#define __wxc_combobox_bi__

#include once "wx-c/wx.bi"


declare function wxComboBox cdecl alias "wxComboBox_ctor" () as wxComboBox ptr
declare function wxComboBox_Create cdecl alias "wxComboBox_Create" (byval self as wxComboBox ptr, byval window as wxWindow ptr, byval id as integer, byval value as zstring ptr, byval pos as wxPoint ptr, byval size as wxSize ptr, byval n as integer, byval choices as byte ptr ptr, byval style as integer, byval validator as wxValidator ptr, byval name as zstring ptr) as integer
declare sub wxComboBox_Append cdecl alias "wxComboBox_Append" (byval self as wxComboBox ptr, byval item as zstring ptr)
declare sub wxComboBox_AppendData cdecl alias "wxComboBox_AppendData" (byval self as wxComboBox ptr, byval item as zstring ptr, byval data as any ptr)
declare sub wxComboBox_Clear cdecl alias "wxComboBox_Clear" (byval self as wxComboBox ptr)
declare sub wxComboBox_Delete cdecl alias "wxComboBox_Delete" (byval self as wxComboBox ptr, byval n as integer)
declare function wxComboBox_FindString cdecl alias "wxComboBox_FindString" (byval self as wxComboBox ptr, byval str as zstring ptr) as integer
declare function wxComboBox_GetCount cdecl alias "wxComboBox_GetCount" (byval self as wxComboBox ptr) as integer
declare function wxComboBox_GetSelection cdecl alias "wxComboBox_GetSelection" (byval self as wxComboBox ptr) as integer
declare function wxComboBox_GetString cdecl alias "wxComboBox_GetString" (byval self as wxComboBox ptr, byval n as integer) as wxString ptr
declare function wxComboBox_GetStringSelection cdecl alias "wxComboBox_GetStringSelection" (byval self as wxComboBox ptr) as wxString ptr
declare sub wxComboBox_SetStringSelection cdecl alias "wxComboBox_SetStringSelection" (byval self as wxComboBox ptr, byval str as zstring ptr)
declare function wxComboBox_GetClientData cdecl alias "wxComboBox_GetClientData" (byval self as wxComboBox ptr, byval n as integer) as any ptr
declare sub wxComboBox_SetClientData cdecl alias "wxComboBox_SetClientData" (byval self as wxComboBox ptr, byval n as integer, byval data as any ptr)
declare sub wxComboBox_SetSelectionSingle cdecl alias "wxComboBox_SetSelectionSingle" (byval self as wxComboBox ptr, byval n as integer)
declare sub wxComboBox_Copy cdecl alias "wxComboBox_Copy" (byval self as wxComboBox ptr)
declare sub wxComboBox_Cut cdecl alias "wxComboBox_Cut" (byval self as wxComboBox ptr)
declare sub wxComboBox_Paste cdecl alias "wxComboBox_Paste" (byval self as wxComboBox ptr)
declare sub wxComboBox_SetInsertionPoint cdecl alias "wxComboBox_SetInsertionPoint" (byval self as wxComboBox ptr, byval pos as integer)
declare function wxComboBox_GetInsertionPoint cdecl alias "wxComboBox_GetInsertionPoint" (byval self as wxComboBox ptr) as integer
declare function wxComboBox_GetLastPosition cdecl alias "wxComboBox_GetLastPosition" (byval self as wxComboBox ptr) as integer
declare sub wxComboBox_Replace cdecl alias "wxComboBox_Replace" (byval self as wxComboBox ptr, byval from as integer, byval to as integer, byval value as zstring ptr)
declare sub wxComboBox_SetSelectionMult cdecl alias "wxComboBox_SetSelectionMult" (byval self as wxComboBox ptr, byval from as integer, byval to as integer)
declare sub wxComboBox_SetEditable cdecl alias "wxComboBox_SetEditable" (byval self as wxComboBox ptr, byval editable as integer)
declare sub wxComboBox_SetInsertionPointEnd cdecl alias "wxComboBox_SetInsertionPointEnd" (byval self as wxComboBox ptr)
declare sub wxComboBox_Remove cdecl alias "wxComboBox_Remove" (byval self as wxComboBox ptr, byval from as integer, byval to as integer)
declare function wxComboBox_GetValue cdecl alias "wxComboBox_GetValue" (byval self as wxComboBox ptr) as wxString ptr
declare sub wxComboBox_SetValue cdecl alias "wxComboBox_SetValue" (byval self as wxComboBox ptr, byval text as zstring ptr)
declare sub wxComboBox_SetSelection cdecl alias "wxComboBox_SetSelection" (byval self as wxComboBox ptr, byval n as integer)
declare sub wxComboBox_Select cdecl alias "wxComboBox_Select" (byval self as wxComboBox ptr, byval n as integer)

#endif
