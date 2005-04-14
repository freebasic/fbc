''
''
'' xmlresource -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __xmlresource_bi__
#define __xmlresource_bi__

#include once "wx-c/wx.bi"

type XmlSubclassCreate as function (byval as wxString ptr) as wxObject

declare sub wxXmlSubclassFactory cdecl alias "wxXmlSubclassFactory_ctor" (byval create as XmlSubclassCreate)
declare function wxXmlResource_ctorByFilemask cdecl alias "wxXmlResource_ctorByFilemask" (byval filemask as string, byval flags as integer) as wxXmlResource ptr
declare function wxXmlResource cdecl alias "wxXmlResource_ctor" (byval flags as integer) as wxXmlResource ptr
declare sub wxXmlResource_InitAllHandlers cdecl alias "wxXmlResource_InitAllHandlers" (byval self as wxXmlResource ptr)
declare function wxXmlResource_Load cdecl alias "wxXmlResource_Load" (byval self as wxXmlResource ptr, byval filemask as string) as integer
declare function wxXmlResource_LoadDialog cdecl alias "wxXmlResource_LoadDialog" (byval self as wxXmlResource ptr, byval parent as wxWindow ptr, byval name as string) as wxDialog ptr
declare function wxXmlResource_LoadDialogDlg cdecl alias "wxXmlResource_LoadDialogDlg" (byval self as wxXmlResource ptr, byval dlg as wxDialog ptr, byval parent as wxWindow ptr, byval name as string) as integer
declare function wxXmlResource_GetXRCID cdecl alias "wxXmlResource_GetXRCID" (byval str_id as string) as integer
declare function wxXmlResource_GetVersion cdecl alias "wxXmlResource_GetVersion" (byval self as wxXmlResource ptr) as integer
declare function wxXmlResource_LoadFrameWithFrame cdecl alias "wxXmlResource_LoadFrameWithFrame" (byval self as wxXmlResource ptr, byval frame as wxFrame ptr, byval parent as wxWindow ptr, byval name as string) as integer
declare function wxXmlResource_LoadFrame cdecl alias "wxXmlResource_LoadFrame" (byval self as wxXmlResource ptr, byval parent as wxWindow ptr, byval name as string) as wxFrame ptr
declare function wxXmlResource_LoadBitmap cdecl alias "wxXmlResource_LoadBitmap" (byval self as wxXmlResource ptr, byval name as string) as wxBitmap ptr
declare function wxXmlResource_LoadIcon cdecl alias "wxXmlResource_LoadIcon" (byval self as wxXmlResource ptr, byval name as string) as wxIcon ptr
declare function wxXmlResource_LoadMenu cdecl alias "wxXmlResource_LoadMenu" (byval self as wxXmlResource ptr, byval name as string) as wxMenu ptr
declare function wxXmlResource_LoadMenuBarWithParent cdecl alias "wxXmlResource_LoadMenuBarWithParent" (byval self as wxXmlResource ptr, byval parent as wxWindow ptr, byval name as string) as wxMenuBar ptr
declare function wxXmlResource_LoadMenuBar cdecl alias "wxXmlResource_LoadMenuBar" (byval self as wxXmlResource ptr, byval name as string) as wxMenuBar ptr
declare function wxXmlResource_LoadPanelWithPanel cdecl alias "wxXmlResource_LoadPanelWithPanel" (byval self as wxXmlResource ptr, byval panel as wxPanel ptr, byval parent as wxWindow ptr, byval name as string) as integer
declare function wxXmlResource_LoadPanel cdecl alias "wxXmlResource_LoadPanel" (byval self as wxXmlResource ptr, byval parent as wxWindow ptr, byval name as string) as wxPanel ptr
declare function wxXmlResource_LoadToolBar cdecl alias "wxXmlResource_LoadToolBar" (byval self as wxXmlResource ptr, byval parent as wxWindow ptr, byval name as string) as wxToolBar ptr
declare sub wxXmlResource_SetFlags cdecl alias "wxXmlResource_SetFlags" (byval self as wxXmlResource ptr, byval flags as integer)
declare function wxXmlResource_GetFlags cdecl alias "wxXmlResource_GetFlags" (byval self as wxXmlResource ptr) as integer
declare function wxXmlResource_CompareVersion cdecl alias "wxXmlResource_CompareVersion" (byval self as wxXmlResource ptr, byval major as integer, byval minor as integer, byval release as integer, byval revision as integer) as integer
declare function wxXmlResource_AttachUnknownControl cdecl alias "wxXmlResource_AttachUnknownControl" (byval self as wxXmlResource ptr, byval name as string, byval control as wxWindow ptr, byval parent as wxWindow ptr) as integer

#endif
