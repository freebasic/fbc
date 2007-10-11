''
''
'' app -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __wxc_app_bi__
#define __wxc_app_bi__

#include once "wx.bi"

type Virtual_OnInit as function WXCALL () as integer
type Virtual_OnExit as function WXCALL () as integer

declare function wxCreateApp () as wxApp ptr
declare function wxApp alias "wxApp_ctor" () as _App ptr
declare sub wxApp_RegisterVirtual (byval self as _App ptr, byval onInit as Virtual_OnInit, byval onExit as Virtual_OnExit)
declare function wxApp_OnInit (byval self as _App ptr) as integer
declare function wxApp_OnExit (byval self as _App ptr) as integer
declare sub wxApp_Run (byval argc as integer, byval argv as byte ptr ptr)
declare function wxApp_GetVendorName (byval self as wxApp ptr) as wxString ptr
declare sub wxApp_SetVendorName (byval self as wxApp ptr, byval name as zstring ptr)
declare function wxApp_GetAppName (byval self as wxApp ptr) as wxString ptr
declare sub wxApp_SetAppName (byval self as wxApp ptr, byval name as zstring ptr)
declare function wxApp_SafeYield (byval win as wxWindow ptr, byval onlyIfNeeded as integer) as integer
declare function wxApp_Yield (byval self as wxApp ptr, byval onlyIfNeeded as integer) as integer
declare sub wxApp_WakeUpIdle ()

#endif
