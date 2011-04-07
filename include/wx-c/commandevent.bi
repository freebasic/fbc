''
''
'' commandevent -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __wxc_commandevent_bi__
#define __wxc_commandevent_bi__

#include once "wx.bi"

declare function wxCommandEvent_GetSelection (byval self as wxCommandEvent ptr) as integer
declare function wxCommandEvent_GetString (byval self as wxCommandEvent ptr) as wxString ptr
declare sub wxCommandEvent_SetString (byval self as wxCommandEvent ptr, byval s as zstring ptr)
declare function wxCommandEvent_IsChecked (byval self as wxCommandEvent ptr) as integer
declare function wxCommandEvent_IsSelection (byval self as wxCommandEvent ptr) as integer
declare function wxCommandEvent_GetInt (byval self as wxCommandEvent ptr) as integer
declare sub wxCommandEvent_SetInt (byval self as wxCommandEvent ptr, byval i as integer)
declare function wxCommandEvent_GetClientObject (byval self as wxCommandEvent ptr) as wxClientData ptr
declare sub wxCommandEvent_SetClientObject (byval self as wxCommandEvent ptr, byval data as wxClientData ptr)
declare sub wxCommandEvent_SetExtraLong (byval self as wxCommandEvent ptr, byval extralong as integer)
declare function wxCommandEvent_GetExtraLong (byval self as wxCommandEvent ptr) as integer

#endif
