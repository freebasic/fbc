''
''
'' mdi -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __mdi_bi__
#define __mdi_bi__

#include once "wx-c/wx.bi"


type Virtual_OnCreateClient as function ( ) as wxMDIClientWindow ptr

declare function wxMDIParentFrame cdecl alias "wxMDIParentFrame_ctor" () as wxMDIParentFrame ptr
declare sub wxMDIParentFrame_RegisterVirtual cdecl alias "wxMDIParentFrame_RegisterVirtual" (byval self as _MDIParentFrame ptr, byval onCreateClient as Virtual_OnCreateClient)
declare function wxMDIParentFrame_OnCreateClient cdecl alias "wxMDIParentFrame_OnCreateClient" (byval self as _MDIParentFrame ptr) as wxMDIClientWindow ptr
declare function wxMDIParentFrame_Create cdecl alias "wxMDIParentFrame_Create" (byval self as _MDIParentFrame ptr, byval parent as wxWindow ptr, byval id as wxWindowID, byval title as string, byval pos as wxPoint ptr, byval size as wxSize ptr, byval style as integer, byval name as string) as integer
declare function wxMDIParentFrame_GetActiveChild cdecl alias "wxMDIParentFrame_GetActiveChild" (byval self as _MDIParentFrame ptr) as wxMDIChildFrame ptr
declare function wxMDIParentFrame_GetClientWindow cdecl alias "wxMDIParentFrame_GetClientWindow" (byval self as _MDIParentFrame ptr) as wxMDIClientWindow ptr
declare sub wxMDIParentFrame_Cascade cdecl alias "wxMDIParentFrame_Cascade" (byval self as _MDIParentFrame ptr)
declare sub wxMDIParentFrame_Tile cdecl alias "wxMDIParentFrame_Tile" (byval self as _MDIParentFrame ptr)
declare sub wxMDIParentFrame_ArrangeIcons cdecl alias "wxMDIParentFrame_ArrangeIcons" (byval self as _MDIParentFrame ptr)
declare sub wxMDIParentFrame_ActivateNext cdecl alias "wxMDIParentFrame_ActivateNext" (byval self as _MDIParentFrame ptr)
declare sub wxMDIParentFrame_ActivatePrevious cdecl alias "wxMDIParentFrame_ActivatePrevious" (byval self as _MDIParentFrame ptr)
declare sub wxMDIParentFrame_GetClientSize cdecl alias "wxMDIParentFrame_GetClientSize" (byval self as _MDIParentFrame ptr, byval width as integer ptr, byval height as integer ptr)

declare function wxMDIChildFrame cdecl alias "wxMDIChildFrame_ctor" () as wxMDIChildFrame ptr
declare sub wxMDIChildFrame_Activate cdecl alias "wxMDIChildFrame_Activate" (byval self as wxMDIChildFrame ptr)
declare function wxMDIChildFrame_Create cdecl alias "wxMDIChildFrame_Create" (byval self as wxMDIChildFrame ptr, byval parent as wxMDIParentFrame ptr, byval id as wxWindowID, byval title as string, byval pos as wxPoint ptr, byval size as wxSize ptr, byval style as integer, byval name as string) as integer
declare sub wxMDIChildFrame_Restore cdecl alias "wxMDIChildFrame_Restore" (byval self as wxMDIChildFrame ptr)
declare sub wxMDIChildFrame_Maximize cdecl alias "wxMDIChildFrame_Maximize" (byval self as wxMDIChildFrame ptr, byval maximize as integer)

declare function wxMDIClientWindow cdecl alias "wxMDIClientWindow_ctor" () as wxMDIClientWindow ptr
declare function wxMDIClientWindow_CreateClient cdecl alias "wxMDIClientWindow_CreateClient" (byval self as wxMDIClientWindow ptr, byval parent as wxMDIParentFrame ptr, byval style as integer) as integer

#endif
