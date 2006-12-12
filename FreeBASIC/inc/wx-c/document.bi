''
''
'' document -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __wxc_document_bi__
#define __wxc_document_bi__

#include once "wx.bi"

declare function wxDocument alias "wxDocument_ctor" (byval parent as wxDocument ptr) as wxDocument ptr
declare sub wxDocument_SetFilename (byval self as wxDocument ptr, byval filename as zstring ptr, byval notifyViews as integer)
declare function wxDocument_GetFilename (byval self as wxDocument ptr) as wxString ptr
declare sub wxDocument_SetTitle (byval self as wxDocument ptr, byval title as zstring ptr)
declare function wxDocument_GetTitle (byval self as wxDocument ptr) as wxString ptr
declare sub wxDocument_SetDocumentName (byval self as wxDocument ptr, byval name as zstring ptr)
declare function wxDocument_GetDocumentName (byval self as wxDocument ptr) as wxString ptr
declare function wxDocument_GetDocumentSaved (byval self as wxDocument ptr) as integer
declare sub wxDocument_SetDocumentSaved (byval self as wxDocument ptr, byval saved as integer)
declare function wxDocument_Close (byval self as wxDocument ptr) as integer
declare function wxDocument_Save (byval self as wxDocument ptr) as integer
declare function wxDocument_SaveAs (byval self as wxDocument ptr) as integer
declare function wxDocument_Revert (byval self as wxDocument ptr) as integer
declare function wxDocument_SaveObject (byval self as wxDocument ptr, byval stream as wxOutputStream ptr) as wxOutputStream ptr
declare function wxDocument_LoadObject (byval self as wxDocument ptr, byval stream as wxInputStream ptr) as wxInputStream ptr
declare function wxDocument_GetCommandProcessor (byval self as wxDocument ptr) as wxCommandProcessor ptr
declare sub wxDocument_SetCommandProcessor (byval self as wxDocument ptr, byval proc as wxCommandProcessor ptr)
declare function wxDocument_DeleteContents (byval self as wxDocument ptr) as integer
declare function wxDocument_Draw (byval self as wxDocument ptr, byval dc as wxDC ptr) as integer
declare function wxDocument_IsModified (byval self as wxDocument ptr) as integer
declare sub wxDocument_Modify (byval self as wxDocument ptr, byval _mod as integer)
declare function wxDocument_AddView (byval self as wxDocument ptr, byval view as wxView ptr) as integer
declare function wxDocument_RemoveView (byval self as wxDocument ptr, byval view as wxView ptr) as integer
declare function wxDocument_GetViews (byval self as wxDocument ptr) as wxList ptr
declare function wxDocument_GetFirstView (byval self as wxDocument ptr) as wxView ptr
declare sub wxDocument_UpdateAllViews (byval self as wxDocument ptr, byval sender as wxView ptr, byval hint as wxObject ptr)
declare sub wxDocument_NotifyClosing (byval self as wxDocument ptr)
declare function wxDocument_DeleteAllViews (byval self as wxDocument ptr) as integer
declare function wxDocument_GetDocumentManager (byval self as wxDocument ptr) as wxDocManager ptr
declare function wxDocument_GetDocumentTemplate (byval self as wxDocument ptr) as wxDocTemplate ptr
declare sub wxDocument_SetDocumentTemplate (byval self as wxDocument ptr, byval temp as wxDocTemplate ptr)
declare function wxDocument_GetPrintableName (byval self as wxDocument ptr, byval name as wxString ptr) as integer
declare function wxDocument_GetDocumentWindow (byval self as wxDocument ptr) as wxWindow ptr

#endif
