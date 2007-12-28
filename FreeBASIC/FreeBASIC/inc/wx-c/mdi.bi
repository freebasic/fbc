''
''
'' mdi -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __wxc_mdi_bi__
#define __wxc_mdi_bi__

#include once "wx.bi"


type Virtual_OnCreateClient as function WXCALL ( ) as wxMDIClientWindow ptr

declare function wxMDIParentFrame alias "wxMDIParentFrame_ctor" () as wxMDIParentFrame ptr
declare sub wxMDIParentFrame_RegisterVirtual (byval self as _MDIParentFrame ptr, byval onCreateClient as Virtual_OnCreateClient)
declare function wxMDIParentFrame_OnCreateClient (byval self as _MDIParentFrame ptr) as wxMDIClientWindow ptr
declare function wxMDIParentFrame_Create (byval self as _MDIParentFrame ptr, byval parent as wxWindow ptr, byval id as wxWindowID, byval title as zstring ptr, byval pos as wxPoint ptr, byval size as wxSize ptr, byval style as integer, byval name as zstring ptr) as integer
declare function wxMDIParentFrame_GetActiveChild (byval self as _MDIParentFrame ptr) as wxMDIChildFrame ptr
declare function wxMDIParentFrame_GetClientWindow (byval self as _MDIParentFrame ptr) as wxMDIClientWindow ptr
declare sub wxMDIParentFrame_Cascade (byval self as _MDIParentFrame ptr)
declare sub wxMDIParentFrame_Tile (byval self as _MDIParentFrame ptr)
declare sub wxMDIParentFrame_ArrangeIcons (byval self as _MDIParentFrame ptr)
declare sub wxMDIParentFrame_ActivateNext (byval self as _MDIParentFrame ptr)
declare sub wxMDIParentFrame_ActivatePrevious (byval self as _MDIParentFrame ptr)
declare sub wxMDIParentFrame_GetClientSize (byval self as _MDIParentFrame ptr, byval width as integer ptr, byval height as integer ptr)

declare function wxMDIChildFrame alias "wxMDIChildFrame_ctor" () as wxMDIChildFrame ptr
declare sub wxMDIChildFrame_Activate (byval self as wxMDIChildFrame ptr)
declare function wxMDIChildFrame_Create (byval self as wxMDIChildFrame ptr, byval parent as wxMDIParentFrame ptr, byval id as wxWindowID, byval title as zstring ptr, byval pos as wxPoint ptr, byval size as wxSize ptr, byval style as integer, byval name as zstring ptr) as integer
declare sub wxMDIChildFrame_Restore (byval self as wxMDIChildFrame ptr)
declare sub wxMDIChildFrame_Maximize (byval self as wxMDIChildFrame ptr, byval maximize as integer)

declare function wxMDIClientWindow alias "wxMDIClientWindow_ctor" () as wxMDIClientWindow ptr
declare function wxMDIClientWindow_CreateClient (byval self as wxMDIClientWindow ptr, byval parent as wxMDIParentFrame ptr, byval style as integer) as integer

#endif
