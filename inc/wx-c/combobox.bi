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

#include once "wx.bi"


declare function wxComboBox alias "wxComboBox_ctor" () as wxComboBox ptr
declare function wxComboBox_Create (byval self as wxComboBox ptr, byval window as wxWindow ptr, byval id as integer, byval value as zstring ptr, byval pos as wxPoint ptr, byval size as wxSize ptr, byval n as integer, byval choices as byte ptr ptr, byval style as integer, byval validator as wxValidator ptr, byval name as zstring ptr) as integer
declare sub wxComboBox_Append (byval self as wxComboBox ptr, byval item as zstring ptr)
declare sub wxComboBox_AppendData (byval self as wxComboBox ptr, byval item as zstring ptr, byval data as any ptr)
declare sub wxComboBox_Clear (byval self as wxComboBox ptr)
declare sub wxComboBox_Delete (byval self as wxComboBox ptr, byval n as integer)
declare function wxComboBox_FindString (byval self as wxComboBox ptr, byval str as zstring ptr) as integer
declare function wxComboBox_GetCount (byval self as wxComboBox ptr) as integer
declare function wxComboBox_GetSelection (byval self as wxComboBox ptr) as integer
declare function wxComboBox_GetString (byval self as wxComboBox ptr, byval n as integer) as wxString ptr
declare function wxComboBox_GetStringSelection (byval self as wxComboBox ptr) as wxString ptr
declare sub wxComboBox_SetStringSelection (byval self as wxComboBox ptr, byval str as zstring ptr)
declare function wxComboBox_GetClientData (byval self as wxComboBox ptr, byval n as integer) as any ptr
declare sub wxComboBox_SetClientData (byval self as wxComboBox ptr, byval n as integer, byval data as any ptr)
declare sub wxComboBox_SetSelectionSingle (byval self as wxComboBox ptr, byval n as integer)
declare sub wxComboBox_Copy (byval self as wxComboBox ptr)
declare sub wxComboBox_Cut (byval self as wxComboBox ptr)
declare sub wxComboBox_Paste (byval self as wxComboBox ptr)
declare sub wxComboBox_SetInsertionPoint (byval self as wxComboBox ptr, byval pos as integer)
declare function wxComboBox_GetInsertionPoint (byval self as wxComboBox ptr) as integer
declare function wxComboBox_GetLastPosition (byval self as wxComboBox ptr) as integer
declare sub wxComboBox_Replace (byval self as wxComboBox ptr, byval from as integer, byval to as integer, byval value as zstring ptr)
declare sub wxComboBox_SetSelectionMult (byval self as wxComboBox ptr, byval from as integer, byval to as integer)
declare sub wxComboBox_SetEditable (byval self as wxComboBox ptr, byval editable as integer)
declare sub wxComboBox_SetInsertionPointEnd (byval self as wxComboBox ptr)
declare sub wxComboBox_Remove (byval self as wxComboBox ptr, byval from as integer, byval to as integer)
declare function wxComboBox_GetValue (byval self as wxComboBox ptr) as wxString ptr
declare sub wxComboBox_SetValue (byval self as wxComboBox ptr, byval text as zstring ptr)
declare sub wxComboBox_SetSelection (byval self as wxComboBox ptr, byval n as integer)
declare sub wxComboBox_Select (byval self as wxComboBox ptr, byval n as integer)

#endif
