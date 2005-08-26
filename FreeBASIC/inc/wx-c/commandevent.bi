''
''
'' commandevent -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __commandevent_bi__
#define __commandevent_bi__

#include once "wx-c/wx.bi"

declare function wxCommandEvent_GetSelection cdecl alias "wxCommandEvent_GetSelection" (byval self as wxCommandEvent ptr) as integer
declare function wxCommandEvent_GetString cdecl alias "wxCommandEvent_GetString" (byval self as wxCommandEvent ptr) as wxString ptr
declare sub wxCommandEvent_SetString cdecl alias "wxCommandEvent_SetString" (byval self as wxCommandEvent ptr, byval s as zstring ptr)
declare function wxCommandEvent_IsChecked cdecl alias "wxCommandEvent_IsChecked" (byval self as wxCommandEvent ptr) as integer
declare function wxCommandEvent_IsSelection cdecl alias "wxCommandEvent_IsSelection" (byval self as wxCommandEvent ptr) as integer
declare function wxCommandEvent_GetInt cdecl alias "wxCommandEvent_GetInt" (byval self as wxCommandEvent ptr) as integer
declare sub wxCommandEvent_SetInt cdecl alias "wxCommandEvent_SetInt" (byval self as wxCommandEvent ptr, byval i as integer)
declare function wxCommandEvent_GetClientObject cdecl alias "wxCommandEvent_GetClientObject" (byval self as wxCommandEvent ptr) as wxClientData ptr
declare sub wxCommandEvent_SetClientObject cdecl alias "wxCommandEvent_SetClientObject" (byval self as wxCommandEvent ptr, byval data as wxClientData ptr)
declare sub wxCommandEvent_SetExtraLong cdecl alias "wxCommandEvent_SetExtraLong" (byval self as wxCommandEvent ptr, byval extralong as integer)
declare function wxCommandEvent_GetExtraLong cdecl alias "wxCommandEvent_GetExtraLong" (byval self as wxCommandEvent ptr) as integer

#endif
