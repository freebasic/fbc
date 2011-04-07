''
''
'' findreplacedialog -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __wxc_findreplacedialog_bi__
#define __wxc_findreplacedialog_bi__

#include once "wx.bi"

declare function wxFindReplaceDialog alias "wxFindReplaceDialog_ctor" () as wxFindReplaceDialog ptr
declare function wxFindReplaceDialog_Create (byval self as wxFindReplaceDialog ptr, byval parent as wxWindow ptr, byval data as wxFindReplaceData ptr, byval title as zstring ptr, byval style as integer) as integer
declare function wxFindReplaceDialog_GetData (byval self as wxFindReplaceDialog ptr) as wxFindReplaceData ptr
declare sub wxFindReplaceDialog_SetData (byval self as wxFindReplaceDialog ptr, byval data as wxFindReplaceData ptr)
declare function wxFindDialogEvent alias "wxFindDialogEvent_ctor" (byval commandType as wxEventType, byval id as integer) as wxFindDialogEvent ptr
declare function wxFindDialogEvent_GetFlags (byval self as wxFindDialogEvent ptr) as integer
declare function wxFindDialogEvent_GetFindString (byval self as wxFindDialogEvent ptr) as wxString ptr
declare function wxFindDialogEvent_GetReplaceString (byval self as wxFindDialogEvent ptr) as wxString ptr
declare function wxFindDialogEvent_GetDialog (byval self as wxFindDialogEvent ptr) as wxFindReplaceDialog ptr
declare sub wxFindDialogEvent_SetFlags (byval self as wxFindDialogEvent ptr, byval flags as integer)
declare sub wxFindDialogEvent_SetFindString (byval self as wxFindDialogEvent ptr, byval str as zstring ptr)
declare sub wxFindDialogEvent_SetReplaceString (byval self as wxFindDialogEvent ptr, byval str as zstring ptr)
declare function wxFindReplaceData alias "wxFindReplaceData_ctor" () as wxFindReplaceData ptr
declare function wxFindReplaceData_GetFindString (byval self as wxFindReplaceData ptr) as wxString ptr
declare function wxFindReplaceData_GetReplaceString (byval self as wxFindReplaceData ptr) as wxString ptr
declare function wxFindReplaceData_GetFlags (byval self as wxFindReplaceData ptr) as integer
declare sub wxFindReplaceData_SetFlags (byval self as wxFindReplaceData ptr, byval flags as uinteger)
declare sub wxFindReplaceData_SetFindString (byval self as wxFindReplaceData ptr, byval str as zstring ptr)
declare sub wxFindReplaceData_SetReplaceString (byval self as wxFindReplaceData ptr, byval str as zstring ptr)

#endif
