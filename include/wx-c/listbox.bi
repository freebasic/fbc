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

#include once "wx.bi"


declare function wxListBox alias "wxListBox_ctor" () as wxListBox ptr
declare sub wxListBox_dtor (byval self as wxListBox ptr)
declare function wxListBox_Create (byval self as wxListBox ptr, byval parent as wxWindow ptr, byval id as wxWindowID, byval pos as wxPoint ptr, byval size as wxSize ptr, byval n as integer, byval items as byte ptr ptr, byval style as integer, byval validator as wxValidator ptr, byval name as zstring ptr) as integer
declare sub wxListBox_Clear (byval self as wxListBox ptr)
declare sub wxListBox_Delete (byval self as wxListBox ptr, byval n as integer)
declare function wxListBox_GetCount (byval self as wxListBox ptr) as integer
declare function wxListBox_GetSingleString (byval self as wxListBox ptr, byval n as integer) as wxString ptr
declare sub wxListBox_SetSingleString (byval self as wxListBox ptr, byval n as integer, byval s as zstring ptr)
declare function wxListBox_FindString (byval self as wxListBox ptr, byval s as zstring ptr) as integer
declare sub wxListBox_SetSelection (byval self as wxListBox ptr, byval n as integer, byval select as integer)
declare function wxListBox_GetSelection (byval self as wxListBox ptr) as integer
declare function wxListBox_GetSelections (byval self as wxListBox ptr) as wxArrayInt ptr
declare sub wxListBox_InsertText (byval self as wxListBox ptr, byval item as zstring ptr, byval pos as integer)
declare sub wxListBox_InsertTextData (byval self as wxListBox ptr, byval item as zstring ptr, byval pos as integer, byval clientData as any ptr)
declare sub wxListBox_InsertTextClientData (byval self as wxListBox ptr, byval item as zstring ptr, byval pos as integer, byval clientData as wxClientData ptr)
declare sub wxListBox_InsertItems (byval self as wxListBox ptr, byval nItems as integer, byval items as byte ptr ptr, byval pos as integer)
declare sub wxListBox_Set (byval self as wxListBox ptr, byval n as integer, byval items as byte ptr ptr, byval clientData as any ptr)
declare sub wxListBox_Select (byval self as wxListBox ptr, byval n as integer)
declare sub wxListBox_Deselect (byval self as wxListBox ptr, byval n as integer)
declare sub wxListBox_DeselectAll (byval self as wxListBox ptr, byval itemToLeaveSelected as integer)
declare function wxListBox_SetStringSelection (byval self as wxListBox ptr, byval s as zstring ptr, byval select as integer) as integer
declare sub wxListBox_SetFirstItem (byval self as wxListBox ptr, byval n as integer)
declare sub wxListBox_SetFirstItemText (byval self as wxListBox ptr, byval s as zstring ptr)
declare function wxListBox_HasMultipleSelection (byval self as wxListBox ptr) as integer
declare function wxListBox_IsSorted (byval self as wxListBox ptr) as integer
declare sub wxListBox_Command (byval self as wxListBox ptr, byval event as wxCommandEvent ptr)
declare function wxListBox_Selected (byval self as wxListBox ptr, byval n as integer) as integer
declare function wxListBox_GetStringSelection (byval self as wxListBox ptr) as wxString ptr
declare sub wxListBox_Append (byval self as wxListBox ptr, byval item as zstring ptr)
declare sub wxListBox_AppendClientData (byval self as wxListBox ptr, byval item as zstring ptr, byval clientData as any ptr)

declare function wxCheckListBox_ctor1 () as wxCheckListBox ptr
declare function wxCheckListBox_ctor2 (byval parent as wxWindow ptr, byval id as wxWindowID, byval pos as wxPoint ptr, byval size as wxSize ptr, byval nStrings as integer, byval choices as byte ptr ptr, byval style as integer, byval validator as wxValidator ptr, byval name as zstring ptr) as wxCheckListBox ptr
declare function wxCheckListBox_IsChecked (byval self as wxCheckListBox ptr, byval index as integer) as integer
declare sub wxCheckListBox_Check (byval self as wxCheckListBox ptr, byval index as integer, byval check as integer)
declare function wxCheckListBox_GetItemHeight (byval self as wxCheckListBox ptr) as integer

#endif
