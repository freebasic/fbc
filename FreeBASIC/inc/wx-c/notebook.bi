''
''
'' notebook -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __notebook_bi__
#define __notebook_bi__

#include once "wx-c/wx.bi"

declare function wxNotebook cdecl alias "wxNotebook_ctor" () as wxNotebook ptr
declare function wxNotebook_AddPage cdecl alias "wxNotebook_AddPage" (byval self as wxNotebook ptr, byval page as wxNotebookPage ptr, byval text as string, byval select as integer, byval imageId as integer) as integer
declare function wxNotebook_Create cdecl alias "wxNotebook_Create" (byval self as wxNotebook ptr, byval parent as wxWindow ptr, byval id as integer, byval pos as wxPoint ptr, byval size as wxSize ptr, byval style as integer, byval name as string) as integer
declare sub wxNotebook_SetImageList cdecl alias "wxNotebook_SetImageList" (byval self as wxNotebookBase ptr, byval imageList as wxImageList ptr)
declare function wxNotebook_GetPageCount cdecl alias "wxNotebook_GetPageCount" (byval self as wxNotebook ptr) as integer
declare function wxNotebook_GetPage cdecl alias "wxNotebook_GetPage" (byval self as wxNotebook ptr, byval nPage as integer) as wxNotebookPage ptr
declare function wxNotebook_GetSelection cdecl alias "wxNotebook_GetSelection" (byval self as wxNotebook ptr) as integer
declare function wxNotebook_SetPageText cdecl alias "wxNotebook_SetPageText" (byval self as wxNotebook ptr, byval nPage as integer, byval strText as string) as integer
declare function wxNotebook_GetPageText cdecl alias "wxNotebook_GetPageText" (byval self as wxNotebook ptr, byval nPage as integer) as wxString ptr
declare sub wxNotebook_AssignImageList cdecl alias "wxNotebook_AssignImageList" (byval self as wxNotebook ptr, byval imageList as wxImageList ptr)
declare function wxNotebook_GetImageList cdecl alias "wxNotebook_GetImageList" (byval self as wxNotebook ptr) as wxImageList ptr
declare function wxNotebook_GetPageImage cdecl alias "wxNotebook_GetPageImage" (byval self as wxNotebook ptr, byval nPage as integer) as integer
declare function wxNotebook_SetPageImage cdecl alias "wxNotebook_SetPageImage" (byval self as wxNotebook ptr, byval nPage as integer, byval nImage as integer) as integer
declare function wxNotebook_GetRowCount cdecl alias "wxNotebook_GetRowCount" (byval self as wxNotebook ptr) as integer
declare sub wxNotebook_SetPageSize cdecl alias "wxNotebook_SetPageSize" (byval self as wxNotebook ptr, byval size as wxSize ptr)
declare sub wxNotebook_SetPadding cdecl alias "wxNotebook_SetPadding" (byval self as wxNotebook ptr, byval padding as wxSize ptr)
declare sub wxNotebook_SetTabSize cdecl alias "wxNotebook_SetTabSize" (byval self as wxNotebook ptr, byval sz as wxSize ptr)
declare function wxNotebook_DeletePage cdecl alias "wxNotebook_DeletePage" (byval self as wxNotebook ptr, byval nPage as integer) as integer
declare function wxNotebook_RemovePage cdecl alias "wxNotebook_RemovePage" (byval self as wxNotebook ptr, byval nPage as integer) as integer
declare function wxNotebook_DeleteAllPages cdecl alias "wxNotebook_DeleteAllPages" (byval self as wxNotebook ptr) as integer
declare function wxNotebook_InsertPage cdecl alias "wxNotebook_InsertPage" (byval self as wxNotebook ptr, byval nPage as integer, byval pPage as wxNotebookPage ptr, byval strText as string, byval bSelect as integer, byval imageId as integer) as integer
declare function wxNotebook_SetSelection cdecl alias "wxNotebook_SetSelection" (byval self as wxNotebook ptr, byval nPage as integer) as integer
declare sub wxNotebook_AdvanceSelection cdecl alias "wxNotebook_AdvanceSelection" (byval self as wxNotebook ptr, byval forward as integer)
declare function wxNotebookEvent cdecl alias "wxNotebookEvent_ctor" (byval commandType as wxEventType, byval id as integer, byval nSel as integer, byval nOldSel as integer) as wxNotebookEvent ptr
declare function wxNotebookEvent_GetSelection cdecl alias "wxNotebookEvent_GetSelection" (byval self as wxNotebookEvent ptr) as integer
declare sub wxNotebookEvent_SetSelection cdecl alias "wxNotebookEvent_SetSelection" (byval self as wxNotebookEvent ptr, byval nSel as integer)
declare function wxNotebookEvent_GetOldSelection cdecl alias "wxNotebookEvent_GetOldSelection" (byval self as wxNotebookEvent ptr) as integer
declare sub wxNotebookEvent_SetOldSelection cdecl alias "wxNotebookEvent_SetOldSelection" (byval self as wxNotebookEvent ptr, byval nOldSel as integer)
declare sub wxNotebookEvent_Veto cdecl alias "wxNotebookEvent_Veto" (byval self as wxNotebookEvent ptr)
declare sub wxNotebookEvent_Allow cdecl alias "wxNotebookEvent_Allow" (byval self as wxNotebookEvent ptr)
declare function wxNotebookEvent_IsAllowed cdecl alias "wxNotebookEvent_IsAllowed" (byval self as wxNotebookEvent ptr) as integer

#endif
