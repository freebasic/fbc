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

#include once "wx-c/wx.bi"

declare function wxFindReplaceDialog cdecl alias "wxFindReplaceDialog_ctor" () as wxFindReplaceDialog ptr
declare function wxFindReplaceDialog_Create cdecl alias "wxFindReplaceDialog_Create" (byval self as wxFindReplaceDialog ptr, byval parent as wxWindow ptr, byval data as wxFindReplaceData ptr, byval title as zstring ptr, byval style as integer) as integer
declare function wxFindReplaceDialog_GetData cdecl alias "wxFindReplaceDialog_GetData" (byval self as wxFindReplaceDialog ptr) as wxFindReplaceData ptr
declare sub wxFindReplaceDialog_SetData cdecl alias "wxFindReplaceDialog_SetData" (byval self as wxFindReplaceDialog ptr, byval data as wxFindReplaceData ptr)
declare function wxFindDialogEvent cdecl alias "wxFindDialogEvent_ctor" (byval commandType as wxEventType, byval id as integer) as wxFindDialogEvent ptr
declare function wxFindDialogEvent_GetFlags cdecl alias "wxFindDialogEvent_GetFlags" (byval self as wxFindDialogEvent ptr) as integer
declare function wxFindDialogEvent_GetFindString cdecl alias "wxFindDialogEvent_GetFindString" (byval self as wxFindDialogEvent ptr) as wxString ptr
declare function wxFindDialogEvent_GetReplaceString cdecl alias "wxFindDialogEvent_GetReplaceString" (byval self as wxFindDialogEvent ptr) as wxString ptr
declare function wxFindDialogEvent_GetDialog cdecl alias "wxFindDialogEvent_GetDialog" (byval self as wxFindDialogEvent ptr) as wxFindReplaceDialog ptr
declare sub wxFindDialogEvent_SetFlags cdecl alias "wxFindDialogEvent_SetFlags" (byval self as wxFindDialogEvent ptr, byval flags as integer)
declare sub wxFindDialogEvent_SetFindString cdecl alias "wxFindDialogEvent_SetFindString" (byval self as wxFindDialogEvent ptr, byval str as zstring ptr)
declare sub wxFindDialogEvent_SetReplaceString cdecl alias "wxFindDialogEvent_SetReplaceString" (byval self as wxFindDialogEvent ptr, byval str as zstring ptr)
declare function wxFindReplaceData cdecl alias "wxFindReplaceData_ctor" () as wxFindReplaceData ptr
declare function wxFindReplaceData_GetFindString cdecl alias "wxFindReplaceData_GetFindString" (byval self as wxFindReplaceData ptr) as wxString ptr
declare function wxFindReplaceData_GetReplaceString cdecl alias "wxFindReplaceData_GetReplaceString" (byval self as wxFindReplaceData ptr) as wxString ptr
declare function wxFindReplaceData_GetFlags cdecl alias "wxFindReplaceData_GetFlags" (byval self as wxFindReplaceData ptr) as integer
declare sub wxFindReplaceData_SetFlags cdecl alias "wxFindReplaceData_SetFlags" (byval self as wxFindReplaceData ptr, byval flags as uinteger)
declare sub wxFindReplaceData_SetFindString cdecl alias "wxFindReplaceData_SetFindString" (byval self as wxFindReplaceData ptr, byval str as zstring ptr)
declare sub wxFindReplaceData_SetReplaceString cdecl alias "wxFindReplaceData_SetReplaceString" (byval self as wxFindReplaceData ptr, byval str as zstring ptr)

#endif
