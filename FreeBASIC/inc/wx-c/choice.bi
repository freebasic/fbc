''
''
'' choice -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __choice_bi__
#define __choice_bi__

#include once "wx-c/wx.bi"

declare function wxChoice cdecl alias "wxChoice_ctor" () as wxChoice ptr
declare function wxChoice_Create cdecl alias "wxChoice_Create" (byval self as wxChoice ptr, byval parent as wxWindow ptr, byval id as integer, byval pos as wxPoint ptr, byval size as wxSize ptr, byval n as integer, byval choices as byte ptr ptr, byval style as integer, byval validator as wxValidator ptr, byval name as string) as integer
declare sub wxChoice_dtor cdecl alias "wxChoice_dtor" (byval self as wxChoice ptr)
declare sub wxChoice_SetString cdecl alias "wxChoice_SetString" (byval self as wxChoice ptr, byval n as integer, byval text as string)
declare function wxChoice_GetStringSelection cdecl alias "wxChoice_GetStringSelection" (byval self as wxChoice ptr) as wxString ptr
declare function wxChoice_GetString cdecl alias "wxChoice_GetString" (byval self as wxChoice ptr, byval n as integer) as wxString ptr
declare function wxChoice_GetSelection cdecl alias "wxChoice_GetSelection" (byval self as wxChoice ptr) as integer
declare function wxChoice_GetCount cdecl alias "wxChoice_GetCount" (byval self as wxChoice ptr) as integer
declare function wxChoice_GetClientData cdecl alias "wxChoice_GetClientData" (byval self as wxChoice ptr, byval n as integer) as any ptr
declare sub wxChoice_SetClientData cdecl alias "wxChoice_SetClientData" (byval self as wxChoice ptr, byval n as integer, byval data as any ptr)
declare function wxChoice_FindString cdecl alias "wxChoice_FindString" (byval self as wxChoice ptr, byval string as string) as integer
declare sub wxChoice_Delete cdecl alias "wxChoice_Delete" (byval self as wxChoice ptr, byval n as integer)
declare sub wxChoice_Clear cdecl alias "wxChoice_Clear" (byval self as wxChoice ptr)
declare function wxChoice_Append cdecl alias "wxChoice_Append" (byval self as wxChoice ptr, byval item as string) as integer
declare function wxChoice_AppendData cdecl alias "wxChoice_AppendData" (byval self as wxChoice ptr, byval item as string, byval clientData as wxClientData ptr) as integer
declare sub wxChoice_AppendString cdecl alias "wxChoice_AppendString" (byval self as wxChoice ptr, byval item as string)
declare sub wxChoice_AppendArrayString cdecl alias "wxChoice_AppendArrayString" (byval self as wxChoice ptr, byval n as integer, byval strings as byte ptr ptr)
declare function wxChoice_Insert cdecl alias "wxChoice_Insert" (byval self as wxChoice ptr, byval item as string, byval pos as integer) as integer
declare function wxChoice_InsertClientData cdecl alias "wxChoice_InsertClientData" (byval self as wxChoice ptr, byval item as string, byval pos as integer, byval clientData as wxClientData ptr) as integer
declare function wxChoice_GetStrings cdecl alias "wxChoice_GetStrings" (byval self as wxChoice ptr) as wxArrayString ptr
declare sub wxChoice_SetClientObject cdecl alias "wxChoice_SetClientObject" (byval self as wxChoice ptr, byval n as integer, byval clientData as wxClientData ptr)
declare function wxChoice_GetClientObject cdecl alias "wxChoice_GetClientObject" (byval self as wxChoice ptr, byval n as integer) as wxClientData ptr
declare function wxChoice_HasClientObjectData cdecl alias "wxChoice_HasClientObjectData" (byval self as wxChoice ptr) as integer
declare function wxChoice_HasClientUntypedData cdecl alias "wxChoice_HasClientUntypedData" (byval self as wxChoice ptr) as integer
declare sub wxChoice_SetSelection cdecl alias "wxChoice_SetSelection" (byval self as wxChoice ptr, byval n as integer)
declare function wxChoice_SetStringSelection cdecl alias "wxChoice_SetStringSelection" (byval self as wxChoice ptr, byval s as string) as integer
declare sub wxChoice_SetColumns cdecl alias "wxChoice_SetColumns" (byval self as wxChoice ptr, byval n as integer)
declare function wxChoice_GetColumns cdecl alias "wxChoice_GetColumns" (byval self as wxChoice ptr) as integer
declare sub wxChoice_Command cdecl alias "wxChoice_Command" (byval self as wxChoice ptr, byval event as wxCommandEvent ptr)
declare sub wxChoice_Select cdecl alias "wxChoice_Select" (byval self as wxChoice ptr, byval n as integer)
declare function wxChoice_ShouldInheritColours cdecl alias "wxChoice_ShouldInheritColours" (byval self as wxChoice ptr) as integer
declare function wxChoice_IsEmpty cdecl alias "wxChoice_IsEmpty" (byval self as wxChoice ptr) as integer

#endif
