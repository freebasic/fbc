''
''
'' xmlresource -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __wxc_xmlresource_bi__
#define __wxc_xmlresource_bi__

#include once "wx.bi"

type XmlSubclassCreate as function WXCALL (byval as wxString ptr) as wxObject ptr

declare sub wxXmlSubclassFactory (byval create as XmlSubclassCreate)
declare function wxXmlResource_ctorByFilemask (byval filemask as zstring ptr, byval flags as integer) as wxXmlResource ptr
declare function wxXmlResource alias "wxXmlResource_ctor" (byval flags as integer) as wxXmlResource ptr
declare sub wxXmlResource_InitAllHandlers (byval self as wxXmlResource ptr)
declare function wxXmlResource_Load (byval self as wxXmlResource ptr, byval filemask as zstring ptr) as integer
declare function wxXmlResource_LoadDialog (byval self as wxXmlResource ptr, byval parent as wxWindow ptr, byval name as zstring ptr) as wxDialog ptr
declare function wxXmlResource_LoadDialogDlg (byval self as wxXmlResource ptr, byval dlg as wxDialog ptr, byval parent as wxWindow ptr, byval name as zstring ptr) as integer
declare function wxXmlResource_GetXRCID (byval str_id as zstring ptr) as integer
declare function wxXmlResource_GetVersion (byval self as wxXmlResource ptr) as integer
declare function wxXmlResource_LoadFrameWithFrame (byval self as wxXmlResource ptr, byval frame as wxFrame ptr, byval parent as wxWindow ptr, byval name as zstring ptr) as integer
declare function wxXmlResource_LoadFrame (byval self as wxXmlResource ptr, byval parent as wxWindow ptr, byval name as zstring ptr) as wxFrame ptr
declare function wxXmlResource_LoadBitmap (byval self as wxXmlResource ptr, byval name as zstring ptr) as wxBitmap ptr
declare function wxXmlResource_LoadIcon (byval self as wxXmlResource ptr, byval name as zstring ptr) as wxIcon ptr
declare function wxXmlResource_LoadMenu (byval self as wxXmlResource ptr, byval name as zstring ptr) as wxMenu ptr
declare function wxXmlResource_LoadMenuBarWithParent (byval self as wxXmlResource ptr, byval parent as wxWindow ptr, byval name as zstring ptr) as wxMenuBar ptr
declare function wxXmlResource_LoadMenuBar (byval self as wxXmlResource ptr, byval name as zstring ptr) as wxMenuBar ptr
declare function wxXmlResource_LoadPanelWithPanel (byval self as wxXmlResource ptr, byval panel as wxPanel ptr, byval parent as wxWindow ptr, byval name as zstring ptr) as integer
declare function wxXmlResource_LoadPanel (byval self as wxXmlResource ptr, byval parent as wxWindow ptr, byval name as zstring ptr) as wxPanel ptr
declare function wxXmlResource_LoadToolBar (byval self as wxXmlResource ptr, byval parent as wxWindow ptr, byval name as zstring ptr) as wxToolBar ptr
declare sub wxXmlResource_SetFlags (byval self as wxXmlResource ptr, byval flags as integer)
declare function wxXmlResource_GetFlags (byval self as wxXmlResource ptr) as integer
declare function wxXmlResource_CompareVersion (byval self as wxXmlResource ptr, byval major as integer, byval minor as integer, byval release as integer, byval revision as integer) as integer
declare function wxXmlResource_AttachUnknownControl (byval self as wxXmlResource ptr, byval name as zstring ptr, byval control as wxWindow ptr, byval parent as wxWindow ptr) as integer

#endif
