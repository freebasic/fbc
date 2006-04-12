''
''
'' listbox -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __wxc_listbox_bi__
#define __wxc_listbox_bi__

#include once "wx-c/wx.bi"


declare function wxListBox cdecl alias "wxListBox_ctor" () as wxListBox ptr
declare sub wxListBox_dtor cdecl alias "wxListBox_dtor" (byval self as wxListBox ptr)
declare function wxListBox_Create cdecl alias "wxListBox_Create" (byval self as wxListBox ptr, byval parent as wxWindow ptr, byval id as wxWindowID, byval pos as wxPoint ptr, byval size as wxSize ptr, byval n as integer, byval items as byte ptr ptr, byval style as integer, byval validator as wxValidator ptr, byval name as zstring ptr) as integer
declare sub wxListBox_Clear cdecl alias "wxListBox_Clear" (byval self as wxListBox ptr)
declare sub wxListBox_Delete cdecl alias "wxListBox_Delete" (byval self as wxListBox ptr, byval n as integer)
declare function wxListBox_GetCount cdecl alias "wxListBox_GetCount" (byval self as wxListBox ptr) as integer
declare function wxListBox_GetSingleString cdecl alias "wxListBox_GetSingleString" (byval self as wxListBox ptr, byval n as integer) as wxString ptr
declare sub wxListBox_SetSingleString cdecl alias "wxListBox_SetSingleString" (byval self as wxListBox ptr, byval n as integer, byval s as zstring ptr)
declare function wxListBox_FindString cdecl alias "wxListBox_FindString" (byval self as wxListBox ptr, byval s as zstring ptr) as integer
declare sub wxListBox_SetSelection cdecl alias "wxListBox_SetSelection" (byval self as wxListBox ptr, byval n as integer, byval select as integer)
declare function wxListBox_GetSelection cdecl alias "wxListBox_GetSelection" (byval self as wxListBox ptr) as integer
declare function wxListBox_GetSelections cdecl alias "wxListBox_GetSelections" (byval self as wxListBox ptr) as wxArrayInt ptr
declare sub wxListBox_InsertText cdecl alias "wxListBox_InsertText" (byval self as wxListBox ptr, byval item as zstring ptr, byval pos as integer)
declare sub wxListBox_InsertTextData cdecl alias "wxListBox_InsertTextData" (byval self as wxListBox ptr, byval item as zstring ptr, byval pos as integer, byval clientData as any ptr)
declare sub wxListBox_InsertTextClientData cdecl alias "wxListBox_InsertTextClientData" (byval self as wxListBox ptr, byval item as zstring ptr, byval pos as integer, byval clientData as wxClientData ptr)
declare sub wxListBox_InsertItems cdecl alias "wxListBox_InsertItems" (byval self as wxListBox ptr, byval nItems as integer, byval items as byte ptr ptr, byval pos as integer)
declare sub wxListBox_Set cdecl alias "wxListBox_Set" (byval self as wxListBox ptr, byval n as integer, byval items as byte ptr ptr, byval clientData as any ptr)
declare sub wxListBox_Select cdecl alias "wxListBox_Select" (byval self as wxListBox ptr, byval n as integer)
declare sub wxListBox_Deselect cdecl alias "wxListBox_Deselect" (byval self as wxListBox ptr, byval n as integer)
declare sub wxListBox_DeselectAll cdecl alias "wxListBox_DeselectAll" (byval self as wxListBox ptr, byval itemToLeaveSelected as integer)
declare function wxListBox_SetStringSelection cdecl alias "wxListBox_SetStringSelection" (byval self as wxListBox ptr, byval s as zstring ptr, byval select as integer) as integer
declare sub wxListBox_SetFirstItem cdecl alias "wxListBox_SetFirstItem" (byval self as wxListBox ptr, byval n as integer)
declare sub wxListBox_SetFirstItemText cdecl alias "wxListBox_SetFirstItemText" (byval self as wxListBox ptr, byval s as zstring ptr)
declare function wxListBox_HasMultipleSelection cdecl alias "wxListBox_HasMultipleSelection" (byval self as wxListBox ptr) as integer
declare function wxListBox_IsSorted cdecl alias "wxListBox_IsSorted" (byval self as wxListBox ptr) as integer
declare sub wxListBox_Command cdecl alias "wxListBox_Command" (byval self as wxListBox ptr, byval event as wxCommandEvent ptr)
declare function wxListBox_Selected cdecl alias "wxListBox_Selected" (byval self as wxListBox ptr, byval n as integer) as integer
declare function wxListBox_GetStringSelection cdecl alias "wxListBox_GetStringSelection" (byval self as wxListBox ptr) as wxString ptr
declare sub wxListBox_Append cdecl alias "wxListBox_Append" (byval self as wxListBox ptr, byval item as zstring ptr)
declare sub wxListBox_AppendClientData cdecl alias "wxListBox_AppendClientData" (byval self as wxListBox ptr, byval item as zstring ptr, byval clientData as any ptr)

declare function wxCheckListBox_ctor1 cdecl alias "wxCheckListBox_ctor1" () as wxCheckListBox ptr
declare function wxCheckListBox_ctor2 cdecl alias "wxCheckListBox_ctor2" (byval parent as wxWindow ptr, byval id as wxWindowID, byval pos as wxPoint ptr, byval size as wxSize ptr, byval nStrings as integer, byval choices as byte ptr ptr, byval style as integer, byval validator as wxValidator ptr, byval name as zstring ptr) as wxCheckListBox ptr
declare function wxCheckListBox_IsChecked cdecl alias "wxCheckListBox_IsChecked" (byval self as wxCheckListBox ptr, byval index as integer) as integer
declare sub wxCheckListBox_Check cdecl alias "wxCheckListBox_Check" (byval self as wxCheckListBox ptr, byval index as integer, byval check as integer)
declare function wxCheckListBox_GetItemHeight cdecl alias "wxCheckListBox_GetItemHeight" (byval self as wxCheckListBox ptr) as integer

#endif
