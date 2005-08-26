''
''
'' printpreview -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __printpreview_bi__
#define __printpreview_bi__

#include once "wx-c/wx.bi"

declare function wxPrintPreview cdecl alias "wxPrintPreview_ctor" (byval printout as wxPrintout ptr, byval printoutForPrinting as wxPrintout ptr, byval data as wxPrintDialogData ptr) as wxPrintPreview ptr
declare function wxPrintPreview_ctorPrintData cdecl alias "wxPrintPreview_ctorPrintData" (byval printout as wxPrintout ptr, byval printoutForPrinting as wxPrintout ptr, byval data as wxPrintData ptr) as wxPrintPreview ptr
declare function wxPrintPreview_SetCurrentPage cdecl alias "wxPrintPreview_SetCurrentPage" (byval self as wxPrintPreview ptr, byval pageNum as integer) as integer
declare function wxPrintPreview_GetCurrentPage cdecl alias "wxPrintPreview_GetCurrentPage" (byval self as wxPrintPreview ptr) as integer
declare sub wxPrintPreview_SetPrintout cdecl alias "wxPrintPreview_SetPrintout" (byval self as wxPrintPreview ptr, byval printout as wxPrintout ptr)
declare function wxPrintPreview_GetPrintout cdecl alias "wxPrintPreview_GetPrintout" (byval self as wxPrintPreview ptr) as wxPrintout ptr
declare function wxPrintPreview_GetPrintoutForPrinting cdecl alias "wxPrintPreview_GetPrintoutForPrinting" (byval self as wxPrintPreview ptr) as wxPrintout ptr
declare sub wxPrintPreview_SetFrame cdecl alias "wxPrintPreview_SetFrame" (byval self as wxPrintPreview ptr, byval frame as wxFrame ptr)
declare sub wxPrintPreview_SetCanvas cdecl alias "wxPrintPreview_SetCanvas" (byval self as wxPrintPreview ptr, byval canvas as wxPreviewCanvas ptr)
declare function wxPrintPreview_GetFrame cdecl alias "wxPrintPreview_GetFrame" (byval self as wxPrintPreview ptr) as wxFrame ptr
declare function wxPrintPreview_GetCanvas cdecl alias "wxPrintPreview_GetCanvas" (byval self as wxPrintPreview ptr) as wxWindow ptr
declare function wxPrintPreview_PaintPage cdecl alias "wxPrintPreview_PaintPage" (byval self as wxPrintPreview ptr, byval canvas as wxPreviewCanvas ptr, byval dc as wxDC ptr) as integer
declare function wxPrintPreview_DrawBlankPage cdecl alias "wxPrintPreview_DrawBlankPage" (byval self as wxPrintPreview ptr, byval canvas as wxPreviewCanvas ptr, byval dc as wxDC ptr) as integer
declare function wxPrintPreview_RenderPage cdecl alias "wxPrintPreview_RenderPage" (byval self as wxPrintPreview ptr, byval pageNum as integer) as integer
declare function wxPrintPreview_GetPrintDialogData cdecl alias "wxPrintPreview_GetPrintDialogData" (byval self as wxPrintPreview ptr) as wxPrintDialogData ptr
declare sub wxPrintPreview_SetZoom cdecl alias "wxPrintPreview_SetZoom" (byval self as wxPrintPreview ptr, byval percent as integer)
declare function wxPrintPreview_GetZoom cdecl alias "wxPrintPreview_GetZoom" (byval self as wxPrintPreview ptr) as integer
declare function wxPrintPreview_GetMaxPage cdecl alias "wxPrintPreview_GetMaxPage" (byval self as wxPrintPreview ptr) as integer
declare function wxPrintPreview_GetMinPage cdecl alias "wxPrintPreview_GetMinPage" (byval self as wxPrintPreview ptr) as integer
declare function wxPrintPreview_Ok cdecl alias "wxPrintPreview_Ok" (byval self as wxPrintPreview ptr) as integer
declare sub wxPrintPreview_SetOk cdecl alias "wxPrintPreview_SetOk" (byval self as wxPrintPreview ptr, byval ok as integer)
declare function wxPrintPreview_Print cdecl alias "wxPrintPreview_Print" (byval self as wxPrintPreview ptr, byval interactive as integer) as integer
declare sub wxPrintPreview_DetermineScaling cdecl alias "wxPrintPreview_DetermineScaling" (byval self as wxPrintPreview ptr)
declare function wxPreviewFrame cdecl alias "wxPreviewFrame_ctor" (byval preview as wxPrintPreviewBase ptr, byval parent as wxFrame ptr, byval title as zstring ptr, byval pos as wxPoint ptr, byval size as wxSize ptr, byval style as integer, byval name as zstring ptr) as wxPreviewFrame ptr
declare sub wxPreviewFrame_Initialize cdecl alias "wxPreviewFrame_Initialize" (byval self as wxPreviewFrame ptr)
declare sub wxPreviewFrame_CreateCanvas cdecl alias "wxPreviewFrame_CreateCanvas" (byval self as wxPreviewFrame ptr)
declare sub wxPreviewFrame_CreateControlBar cdecl alias "wxPreviewFrame_CreateControlBar" (byval self as wxPreviewFrame ptr)
declare function wxPreviewCanvas cdecl alias "wxPreviewCanvas_ctor" (byval preview as wxPrintPreviewBase ptr, byval parent as wxWindow ptr, byval pos as wxPoint ptr, byval size as wxSize ptr, byval style as integer, byval name as zstring ptr) as wxPreviewCanvas ptr

#endif
