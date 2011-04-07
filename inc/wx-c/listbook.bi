''
''
'' listbook -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __wxc_listbook_bi__
#define __wxc_listbook_bi__

#include once "wx.bi"


declare function wxListbook alias "wxListbook_ctor" () as wxListbook ptr
declare function wxListbook_Create (byval self as wxListbook ptr, byval parent as wxWindow ptr, byval id as wxWindowID, byval pos as wxPoint ptr, byval size as wxSize ptr, byval style as integer, byval name as zstring ptr) as integer
declare function wxListbook_GetSelection (byval self as wxListbook ptr) as integer
declare function wxListbook_SetPageText (byval self as wxListbook ptr, byval n as integer, byval strText as zstring ptr) as integer
declare function wxListbook_GetPageText (byval self as wxListbook ptr, byval n as integer) as wxString ptr
declare function wxListbook_GetPageImage (byval self as wxListbook ptr, byval n as integer) as integer
declare function wxListbook_SetPageImage (byval self as wxListbook ptr, byval n as integer, byval imageId as integer) as integer
declare sub wxListbook_CalcSizeFromPage (byval self as wxListbook ptr, byval sizePage as wxSize ptr, byval outSize as wxSize ptr)
declare function wxListbook_InsertPage (byval self as wxListbook ptr, byval n as integer, byval page as wxWindow ptr, byval text as zstring ptr, byval bSelect as integer, byval imageId as integer) as integer
declare function wxListbook_SetSelection (byval self as wxListbook ptr, byval n as integer) as integer
declare sub wxListbook_SetImageList (byval self as wxListbook ptr, byval imageList as wxImageList ptr)
declare function wxListbook_IsVertical (byval self as wxListbook ptr) as integer
declare function wxListbook_GetPageCount (byval self as wxListbook ptr) as integer
declare function wxListbook_GetPage (byval self as wxListbook ptr, byval n as integer) as wxWindow ptr
declare sub wxListbook_AssignImageList (byval self as wxListbook ptr, byval imageList as wxImageList ptr)
declare function wxListbook_GetImageList (byval self as wxListbook ptr) as wxImageList ptr
declare sub wxListbook_SetPageSize (byval self as wxListbook ptr, byval size as wxSize ptr)
declare function wxListbook_DeletePage (byval self as wxListbook ptr, byval nPage as integer) as integer
declare function wxListbook_RemovePage (byval self as wxListbook ptr, byval nPage as integer) as integer
declare function wxListbook_DeleteAllPages (byval self as wxListbook ptr) as integer
declare function wxListbook_AddPage (byval self as wxListbook ptr, byval page as wxWindow ptr, byval text as zstring ptr, byval bselect as integer, byval imageId as integer) as integer
declare sub wxListbook_AdvanceSelection (byval self as wxListbook ptr, byval forward as integer)
declare function wxListbookEvent alias "wxListbookEvent_ctor" (byval commandType as wxEventType, byval id as integer, byval nSel as integer, byval nOldSel as integer) as wxListbookEvent ptr
declare function wxListbookEvent_GetSelection (byval self as wxListbookEvent ptr) as integer
declare sub wxListbookEvent_SetSelection (byval self as wxListbookEvent ptr, byval nSel as integer)
declare function wxListbookEvent_GetOldSelection (byval self as wxListbookEvent ptr) as integer
declare sub wxListbookEvent_SetOldSelection (byval self as wxListbookEvent ptr, byval nOldSel as integer)
declare sub wxListbookEvent_Veto (byval self as wxListbookEvent ptr)
declare sub wxListbookEvent_Allow (byval self as wxListbookEvent ptr)
declare function wxListbookEvent_IsAllowed (byval self as wxListbookEvent ptr) as integer

#endif
