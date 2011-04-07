''
''
'' notebook -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __wxc_notebook_bi__
#define __wxc_notebook_bi__

#include once "wx.bi"

declare function wxNotebook alias "wxNotebook_ctor" () as wxNotebook ptr
declare function wxNotebook_AddPage (byval self as wxNotebook ptr, byval page as wxNotebookPage ptr, byval text as zstring ptr, byval select as integer, byval imageId as integer) as integer
declare function wxNotebook_Create (byval self as wxNotebook ptr, byval parent as wxWindow ptr, byval id as integer, byval pos as wxPoint ptr, byval size as wxSize ptr, byval style as integer, byval name as zstring ptr) as integer
declare sub wxNotebook_SetImageList (byval self as wxNotebookBase ptr, byval imageList as wxImageList ptr)
declare function wxNotebook_GetPageCount (byval self as wxNotebook ptr) as integer
declare function wxNotebook_GetPage (byval self as wxNotebook ptr, byval nPage as integer) as wxNotebookPage ptr
declare function wxNotebook_GetSelection (byval self as wxNotebook ptr) as integer
declare function wxNotebook_SetPageText (byval self as wxNotebook ptr, byval nPage as integer, byval strText as zstring ptr) as integer
declare function wxNotebook_GetPageText (byval self as wxNotebook ptr, byval nPage as integer) as wxString ptr
declare sub wxNotebook_AssignImageList (byval self as wxNotebook ptr, byval imageList as wxImageList ptr)
declare function wxNotebook_GetImageList (byval self as wxNotebook ptr) as wxImageList ptr
declare function wxNotebook_GetPageImage (byval self as wxNotebook ptr, byval nPage as integer) as integer
declare function wxNotebook_SetPageImage (byval self as wxNotebook ptr, byval nPage as integer, byval nImage as integer) as integer
declare function wxNotebook_GetRowCount (byval self as wxNotebook ptr) as integer
declare sub wxNotebook_SetPageSize (byval self as wxNotebook ptr, byval size as wxSize ptr)
declare sub wxNotebook_SetPadding (byval self as wxNotebook ptr, byval padding as wxSize ptr)
declare sub wxNotebook_SetTabSize (byval self as wxNotebook ptr, byval sz as wxSize ptr)
declare function wxNotebook_DeletePage (byval self as wxNotebook ptr, byval nPage as integer) as integer
declare function wxNotebook_RemovePage (byval self as wxNotebook ptr, byval nPage as integer) as integer
declare function wxNotebook_DeleteAllPages (byval self as wxNotebook ptr) as integer
declare function wxNotebook_InsertPage (byval self as wxNotebook ptr, byval nPage as integer, byval pPage as wxNotebookPage ptr, byval strText as zstring ptr, byval bSelect as integer, byval imageId as integer) as integer
declare function wxNotebook_SetSelection (byval self as wxNotebook ptr, byval nPage as integer) as integer
declare sub wxNotebook_AdvanceSelection (byval self as wxNotebook ptr, byval forward as integer)
declare function wxNotebookEvent alias "wxNotebookEvent_ctor" (byval commandType as wxEventType, byval id as integer, byval nSel as integer, byval nOldSel as integer) as wxNotebookEvent ptr
declare function wxNotebookEvent_GetSelection (byval self as wxNotebookEvent ptr) as integer
declare sub wxNotebookEvent_SetSelection (byval self as wxNotebookEvent ptr, byval nSel as integer)
declare function wxNotebookEvent_GetOldSelection (byval self as wxNotebookEvent ptr) as integer
declare sub wxNotebookEvent_SetOldSelection (byval self as wxNotebookEvent ptr, byval nOldSel as integer)
declare sub wxNotebookEvent_Veto (byval self as wxNotebookEvent ptr)
declare sub wxNotebookEvent_Allow (byval self as wxNotebookEvent ptr)
declare function wxNotebookEvent_IsAllowed (byval self as wxNotebookEvent ptr) as integer

#endif
