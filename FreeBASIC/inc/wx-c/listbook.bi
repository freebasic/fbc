''
''
'' listbook -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __listbook_bi__
#define __listbook_bi__

#include once "wx-c/wx.bi"


declare function wxListbook cdecl alias "wxListbook_ctor" () as wxListbook ptr
declare function wxListbook_Create cdecl alias "wxListbook_Create" (byval self as wxListbook ptr, byval parent as wxWindow ptr, byval id as wxWindowID, byval pos as wxPoint ptr, byval size as wxSize ptr, byval style as integer, byval name as string) as integer
declare function wxListbook_GetSelection cdecl alias "wxListbook_GetSelection" (byval self as wxListbook ptr) as integer
declare function wxListbook_SetPageText cdecl alias "wxListbook_SetPageText" (byval self as wxListbook ptr, byval n as integer, byval strText as string) as integer
declare function wxListbook_GetPageText cdecl alias "wxListbook_GetPageText" (byval self as wxListbook ptr, byval n as integer) as wxString ptr
declare function wxListbook_GetPageImage cdecl alias "wxListbook_GetPageImage" (byval self as wxListbook ptr, byval n as integer) as integer
declare function wxListbook_SetPageImage cdecl alias "wxListbook_SetPageImage" (byval self as wxListbook ptr, byval n as integer, byval imageId as integer) as integer
declare sub wxListbook_CalcSizeFromPage cdecl alias "wxListbook_CalcSizeFromPage" (byval self as wxListbook ptr, byval sizePage as wxSize ptr, byval outSize as wxSize ptr)
declare function wxListbook_InsertPage cdecl alias "wxListbook_InsertPage" (byval self as wxListbook ptr, byval n as integer, byval page as wxWindow ptr, byval text as string, byval bSelect as integer, byval imageId as integer) as integer
declare function wxListbook_SetSelection cdecl alias "wxListbook_SetSelection" (byval self as wxListbook ptr, byval n as integer) as integer
declare sub wxListbook_SetImageList cdecl alias "wxListbook_SetImageList" (byval self as wxListbook ptr, byval imageList as wxImageList ptr)
declare function wxListbook_IsVertical cdecl alias "wxListbook_IsVertical" (byval self as wxListbook ptr) as integer
declare function wxListbook_GetPageCount cdecl alias "wxListbook_GetPageCount" (byval self as wxListbook ptr) as integer
declare function wxListbook_GetPage cdecl alias "wxListbook_GetPage" (byval self as wxListbook ptr, byval n as integer) as wxWindow ptr
declare sub wxListbook_AssignImageList cdecl alias "wxListbook_AssignImageList" (byval self as wxListbook ptr, byval imageList as wxImageList ptr)
declare function wxListbook_GetImageList cdecl alias "wxListbook_GetImageList" (byval self as wxListbook ptr) as wxImageList ptr
declare sub wxListbook_SetPageSize cdecl alias "wxListbook_SetPageSize" (byval self as wxListbook ptr, byval size as wxSize ptr)
declare function wxListbook_DeletePage cdecl alias "wxListbook_DeletePage" (byval self as wxListbook ptr, byval nPage as integer) as integer
declare function wxListbook_RemovePage cdecl alias "wxListbook_RemovePage" (byval self as wxListbook ptr, byval nPage as integer) as integer
declare function wxListbook_DeleteAllPages cdecl alias "wxListbook_DeleteAllPages" (byval self as wxListbook ptr) as integer
declare function wxListbook_AddPage cdecl alias "wxListbook_AddPage" (byval self as wxListbook ptr, byval page as wxWindow ptr, byval text as string, byval bselect as integer, byval imageId as integer) as integer
declare sub wxListbook_AdvanceSelection cdecl alias "wxListbook_AdvanceSelection" (byval self as wxListbook ptr, byval forward as integer)
declare function wxListbookEvent cdecl alias "wxListbookEvent_ctor" (byval commandType as wxEventType, byval id as integer, byval nSel as integer, byval nOldSel as integer) as wxListbookEvent ptr
declare function wxListbookEvent_GetSelection cdecl alias "wxListbookEvent_GetSelection" (byval self as wxListbookEvent ptr) as integer
declare sub wxListbookEvent_SetSelection cdecl alias "wxListbookEvent_SetSelection" (byval self as wxListbookEvent ptr, byval nSel as integer)
declare function wxListbookEvent_GetOldSelection cdecl alias "wxListbookEvent_GetOldSelection" (byval self as wxListbookEvent ptr) as integer
declare sub wxListbookEvent_SetOldSelection cdecl alias "wxListbookEvent_SetOldSelection" (byval self as wxListbookEvent ptr, byval nOldSel as integer)
declare sub wxListbookEvent_Veto cdecl alias "wxListbookEvent_Veto" (byval self as wxListbookEvent ptr)
declare sub wxListbookEvent_Allow cdecl alias "wxListbookEvent_Allow" (byval self as wxListbookEvent ptr)
declare function wxListbookEvent_IsAllowed cdecl alias "wxListbookEvent_IsAllowed" (byval self as wxListbookEvent ptr) as integer

#endif
