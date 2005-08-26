''
''
'' document -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __document_bi__
#define __document_bi__

#include once "wx-c/wx.bi"

declare function wxDocument cdecl alias "wxDocument_ctor" (byval parent as wxDocument ptr) as wxDocument ptr
declare sub wxDocument_SetFilename cdecl alias "wxDocument_SetFilename" (byval self as wxDocument ptr, byval filename as zstring ptr, byval notifyViews as integer)
declare function wxDocument_GetFilename cdecl alias "wxDocument_GetFilename" (byval self as wxDocument ptr) as wxString ptr
declare sub wxDocument_SetTitle cdecl alias "wxDocument_SetTitle" (byval self as wxDocument ptr, byval title as zstring ptr)
declare function wxDocument_GetTitle cdecl alias "wxDocument_GetTitle" (byval self as wxDocument ptr) as wxString ptr
declare sub wxDocument_SetDocumentName cdecl alias "wxDocument_SetDocumentName" (byval self as wxDocument ptr, byval name as zstring ptr)
declare function wxDocument_GetDocumentName cdecl alias "wxDocument_GetDocumentName" (byval self as wxDocument ptr) as wxString ptr
declare function wxDocument_GetDocumentSaved cdecl alias "wxDocument_GetDocumentSaved" (byval self as wxDocument ptr) as integer
declare sub wxDocument_SetDocumentSaved cdecl alias "wxDocument_SetDocumentSaved" (byval self as wxDocument ptr, byval saved as integer)
declare function wxDocument_Close cdecl alias "wxDocument_Close" (byval self as wxDocument ptr) as integer
declare function wxDocument_Save cdecl alias "wxDocument_Save" (byval self as wxDocument ptr) as integer
declare function wxDocument_SaveAs cdecl alias "wxDocument_SaveAs" (byval self as wxDocument ptr) as integer
declare function wxDocument_Revert cdecl alias "wxDocument_Revert" (byval self as wxDocument ptr) as integer
declare function wxDocument_SaveObject cdecl alias "wxDocument_SaveObject" (byval self as wxDocument ptr, byval stream as wxOutputStream ptr) as wxOutputStream ptr
declare function wxDocument_LoadObject cdecl alias "wxDocument_LoadObject" (byval self as wxDocument ptr, byval stream as wxInputStream ptr) as wxInputStream ptr
declare function wxDocument_GetCommandProcessor cdecl alias "wxDocument_GetCommandProcessor" (byval self as wxDocument ptr) as wxCommandProcessor ptr
declare sub wxDocument_SetCommandProcessor cdecl alias "wxDocument_SetCommandProcessor" (byval self as wxDocument ptr, byval proc as wxCommandProcessor ptr)
declare function wxDocument_DeleteContents cdecl alias "wxDocument_DeleteContents" (byval self as wxDocument ptr) as integer
declare function wxDocument_Draw cdecl alias "wxDocument_Draw" (byval self as wxDocument ptr, byval dc as wxDC ptr) as integer
declare function wxDocument_IsModified cdecl alias "wxDocument_IsModified" (byval self as wxDocument ptr) as integer
declare sub wxDocument_Modify cdecl alias "wxDocument_Modify" (byval self as wxDocument ptr, byval _mod as integer)
declare function wxDocument_AddView cdecl alias "wxDocument_AddView" (byval self as wxDocument ptr, byval view as wxView ptr) as integer
declare function wxDocument_RemoveView cdecl alias "wxDocument_RemoveView" (byval self as wxDocument ptr, byval view as wxView ptr) as integer
declare function wxDocument_GetViews cdecl alias "wxDocument_GetViews" (byval self as wxDocument ptr) as wxList ptr
declare function wxDocument_GetFirstView cdecl alias "wxDocument_GetFirstView" (byval self as wxDocument ptr) as wxView ptr
declare sub wxDocument_UpdateAllViews cdecl alias "wxDocument_UpdateAllViews" (byval self as wxDocument ptr, byval sender as wxView ptr, byval hint as wxObject ptr)
declare sub wxDocument_NotifyClosing cdecl alias "wxDocument_NotifyClosing" (byval self as wxDocument ptr)
declare function wxDocument_DeleteAllViews cdecl alias "wxDocument_DeleteAllViews" (byval self as wxDocument ptr) as integer
declare function wxDocument_GetDocumentManager cdecl alias "wxDocument_GetDocumentManager" (byval self as wxDocument ptr) as wxDocManager ptr
declare function wxDocument_GetDocumentTemplate cdecl alias "wxDocument_GetDocumentTemplate" (byval self as wxDocument ptr) as wxDocTemplate ptr
declare sub wxDocument_SetDocumentTemplate cdecl alias "wxDocument_SetDocumentTemplate" (byval self as wxDocument ptr, byval temp as wxDocTemplate ptr)
declare function wxDocument_GetPrintableName cdecl alias "wxDocument_GetPrintableName" (byval self as wxDocument ptr, byval name as wxString ptr) as integer
declare function wxDocument_GetDocumentWindow cdecl alias "wxDocument_GetDocumentWindow" (byval self as wxDocument ptr) as wxWindow ptr

#endif
