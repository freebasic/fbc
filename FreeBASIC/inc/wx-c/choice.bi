''
''
'' choice -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __wxc_choice_bi__
#define __wxc_choice_bi__

#include once "wx.bi"

declare function wxChoice alias "wxChoice_ctor" () as wxChoice ptr
declare function wxChoice_Create (byval self as wxChoice ptr, byval parent as wxWindow ptr, byval id as integer, byval pos as wxPoint ptr, byval size as wxSize ptr, byval n as integer, byval choices as byte ptr ptr, byval style as integer, byval validator as wxValidator ptr, byval name as zstring ptr) as integer
declare sub wxChoice_dtor (byval self as wxChoice ptr)
declare sub wxChoice_SetString (byval self as wxChoice ptr, byval n as integer, byval text as zstring ptr)
declare function wxChoice_GetStringSelection (byval self as wxChoice ptr) as wxString ptr
declare function wxChoice_GetString (byval self as wxChoice ptr, byval n as integer) as wxString ptr
declare function wxChoice_GetSelection (byval self as wxChoice ptr) as integer
declare function wxChoice_GetCount (byval self as wxChoice ptr) as integer
declare function wxChoice_GetClientData (byval self as wxChoice ptr, byval n as integer) as any ptr
declare sub wxChoice_SetClientData (byval self as wxChoice ptr, byval n as integer, byval data as any ptr)
declare function wxChoice_FindString (byval self as wxChoice ptr, byval string as zstring ptr) as integer
declare sub wxChoice_Delete (byval self as wxChoice ptr, byval n as integer)
declare sub wxChoice_Clear (byval self as wxChoice ptr)
declare function wxChoice_Append (byval self as wxChoice ptr, byval item as zstring ptr) as integer
declare function wxChoice_AppendData (byval self as wxChoice ptr, byval item as zstring ptr, byval clientData as wxClientData ptr) as integer
declare sub wxChoice_AppendString (byval self as wxChoice ptr, byval item as zstring ptr)
declare sub wxChoice_AppendArrayString (byval self as wxChoice ptr, byval n as integer, byval strings as byte ptr ptr)
declare function wxChoice_Insert (byval self as wxChoice ptr, byval item as zstring ptr, byval pos as integer) as integer
declare function wxChoice_InsertClientData (byval self as wxChoice ptr, byval item as zstring ptr, byval pos as integer, byval clientData as wxClientData ptr) as integer
declare function wxChoice_GetStrings (byval self as wxChoice ptr) as wxArrayString ptr
declare sub wxChoice_SetClientObject (byval self as wxChoice ptr, byval n as integer, byval clientData as wxClientData ptr)
declare function wxChoice_GetClientObject (byval self as wxChoice ptr, byval n as integer) as wxClientData ptr
declare function wxChoice_HasClientObjectData (byval self as wxChoice ptr) as integer
declare function wxChoice_HasClientUntypedData (byval self as wxChoice ptr) as integer
declare sub wxChoice_SetSelection (byval self as wxChoice ptr, byval n as integer)
declare function wxChoice_SetStringSelection (byval self as wxChoice ptr, byval s as zstring ptr) as integer
declare sub wxChoice_SetColumns (byval self as wxChoice ptr, byval n as integer)
declare function wxChoice_GetColumns (byval self as wxChoice ptr) as integer
declare sub wxChoice_Command (byval self as wxChoice ptr, byval event as wxCommandEvent ptr)
declare sub wxChoice_Select (byval self as wxChoice ptr, byval n as integer)
declare function wxChoice_ShouldInheritColours (byval self as wxChoice ptr) as integer
declare function wxChoice_IsEmpty (byval self as wxChoice ptr) as integer

#endif
