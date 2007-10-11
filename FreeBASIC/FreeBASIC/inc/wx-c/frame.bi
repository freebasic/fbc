''
''
'' frame -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __wxc_frame_bi__
#define __wxc_frame_bi__

#include once "wx.bi"


declare function wxFrame alias "wxFrame_ctor" () as wxFrame ptr
declare function wxFrame_Create (byval self as wxFrame ptr, byval parent as wxWindow ptr, byval id as integer, byval title as zstring ptr, byval pos as wxPoint ptr, byval size as wxSize ptr, byval style as uinteger, byval name as zstring ptr) as integer
declare function wxFrame_ShowFullScreen (byval self as wxFrame ptr, byval show as integer, byval style as uinteger) as integer
declare function wxFrame_IsFullScreen (byval self as wxFrame ptr) as integer
declare function wxFrame_CreateStatusBar (byval self as wxFrame ptr, byval number as integer, byval style as uinteger, byval id as wxWindowID, byval name as zstring ptr) as wxStatusBar ptr
declare function wxFrame_GetStatusBar (byval self as wxFrame ptr) as wxStatusBar ptr
declare sub wxFrame_SetStatusBar (byval self as wxFrame ptr, byval statusbar as wxStatusBar ptr)
declare sub wxFrame_SetStatusBarPane (byval self as wxFrame ptr, byval n as integer)
declare function wxFrame_GetStatusBarPane (byval self as wxFrame ptr) as integer
declare sub wxFrame_SendSizeEvent (byval self as wxFrame ptr)
declare sub wxFrame_SetIcon (byval self as wxFrame ptr, byval icon as wxIcon ptr)
declare sub wxFrame_SetMenuBar (byval self as wxFrame ptr, byval menuBar as wxMenuBar ptr)
declare function wxFrame_GetMenuBar (byval self as wxFrame ptr) as wxMenuBar ptr
declare sub wxFrame_SetStatusText (byval self as wxFrame ptr, byval text as zstring ptr, byval number as integer)
declare function wxFrame_CreateToolBar (byval self as wxFrame ptr, byval style as uinteger, byval id as wxWindowID, byval name as zstring ptr) as wxToolBar ptr
declare function wxFrame_GetToolBar (byval self as wxFrame ptr) as wxToolBar ptr
declare sub wxFrame_SetToolBar (byval self as wxFrame ptr, byval toolbar as wxToolBar ptr)
declare sub wxFrame_Maximize (byval self as wxFrame ptr, byval iconize as integer)
declare function wxFrame_IsMaximized (byval self as wxFrame ptr) as integer
declare sub wxFrame_Iconize (byval self as wxFrame ptr, byval iconize as integer)
declare function wxFrame_IsIconized (byval self as wxFrame ptr) as integer
declare sub wxFrame_SetStatusWidths (byval self as wxFrame ptr, byval n as integer, byval widths as integer ptr)
declare sub wxFrame_GetClientAreaOrigin (byval self as wxFrame ptr, byval pt as wxPoint ptr)

#endif
