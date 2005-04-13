''
''
'' frame -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __frame_bi__
#define __frame_bi__

#include once "wx-c/wx.bi"


declare function wxFrame cdecl alias "wxFrame_ctor" () as wxFrame ptr
declare function wxFrame_Create cdecl alias "wxFrame_Create" (byval self as wxFrame ptr, byval parent as wxWindow ptr, byval id as integer, byval title as string, byval pos as wxPoint ptr, byval size as wxSize ptr, byval style as uinteger, byval name as string) as integer
declare function wxFrame_ShowFullScreen cdecl alias "wxFrame_ShowFullScreen" (byval self as wxFrame ptr, byval show as integer, byval style as uinteger) as integer
declare function wxFrame_IsFullScreen cdecl alias "wxFrame_IsFullScreen" (byval self as wxFrame ptr) as integer
declare function wxFrame_CreateStatusBar cdecl alias "wxFrame_CreateStatusBar" (byval self as wxFrame ptr, byval number as integer, byval style as uinteger, byval id as wxWindowID, byval name as string) as wxStatusBar ptr
declare function wxFrame_GetStatusBar cdecl alias "wxFrame_GetStatusBar" (byval self as wxFrame ptr) as wxStatusBar ptr
declare sub wxFrame_SetStatusBar cdecl alias "wxFrame_SetStatusBar" (byval self as wxFrame ptr, byval statusbar as wxStatusBar ptr)
declare sub wxFrame_SetStatusBarPane cdecl alias "wxFrame_SetStatusBarPane" (byval self as wxFrame ptr, byval n as integer)
declare function wxFrame_GetStatusBarPane cdecl alias "wxFrame_GetStatusBarPane" (byval self as wxFrame ptr) as integer
declare sub wxFrame_SendSizeEvent cdecl alias "wxFrame_SendSizeEvent" (byval self as wxFrame ptr)
declare sub wxFrame_SetIcon cdecl alias "wxFrame_SetIcon" (byval self as wxFrame ptr, byval icon as wxIcon ptr)
declare sub wxFrame_SetMenuBar cdecl alias "wxFrame_SetMenuBar" (byval self as wxFrame ptr, byval menuBar as wxMenuBar ptr)
declare function wxFrame_GetMenuBar cdecl alias "wxFrame_GetMenuBar" (byval self as wxFrame ptr) as wxMenuBar ptr
declare sub wxFrame_SetStatusText cdecl alias "wxFrame_SetStatusText" (byval self as wxFrame ptr, byval text as string, byval number as integer)
declare function wxFrame_CreateToolBar cdecl alias "wxFrame_CreateToolBar" (byval self as wxFrame ptr, byval style as uinteger, byval id as wxWindowID, byval name as string) as wxToolBar ptr
declare function wxFrame_GetToolBar cdecl alias "wxFrame_GetToolBar" (byval self as wxFrame ptr) as wxToolBar ptr
declare sub wxFrame_SetToolBar cdecl alias "wxFrame_SetToolBar" (byval self as wxFrame ptr, byval toolbar as wxToolBar ptr)
declare sub wxFrame_Maximize cdecl alias "wxFrame_Maximize" (byval self as wxFrame ptr, byval iconize as integer)
declare function wxFrame_IsMaximized cdecl alias "wxFrame_IsMaximized" (byval self as wxFrame ptr) as integer
declare sub wxFrame_Iconize cdecl alias "wxFrame_Iconize" (byval self as wxFrame ptr, byval iconize as integer)
declare function wxFrame_IsIconized cdecl alias "wxFrame_IsIconized" (byval self as wxFrame ptr) as integer
declare sub wxFrame_SetStatusWidths cdecl alias "wxFrame_SetStatusWidths" (byval self as wxFrame ptr, byval n as integer, byval widths as integer ptr)
declare sub wxFrame_GetClientAreaOrigin cdecl alias "wxFrame_GetClientAreaOrigin" (byval self as wxFrame ptr, byval pt as wxPoint ptr)

#endif
