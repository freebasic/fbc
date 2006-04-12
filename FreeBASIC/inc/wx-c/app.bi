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

#include once "wx-c/wx.bi"

type Virtual_OnInit as function  () as integer
type Virtual_OnExit as function  () as integer

declare function wxCreateApp cdecl alias "wxCreateApp" () as wxApp ptr
declare function wxApp cdecl alias "wxApp_ctor" () as _App ptr
declare sub wxApp_RegisterVirtual cdecl alias "wxApp_RegisterVirtual" (byval self as _App ptr, byval onInit as Virtual_OnInit, byval onExit as Virtual_OnExit)
declare function wxApp_OnInit cdecl alias "wxApp_OnInit" (byval self as _App ptr) as integer
declare function wxApp_OnExit cdecl alias "wxApp_OnExit" (byval self as _App ptr) as integer
declare sub wxApp_Run cdecl alias "wxApp_Run" (byval argc as integer, byval argv as byte ptr ptr)
declare function wxApp_GetVendorName cdecl alias "wxApp_GetVendorName" (byval self as wxApp ptr) as wxString ptr
declare sub wxApp_SetVendorName cdecl alias "wxApp_SetVendorName" (byval self as wxApp ptr, byval name as zstring ptr)
declare function wxApp_GetAppName cdecl alias "wxApp_GetAppName" (byval self as wxApp ptr) as wxString ptr
declare sub wxApp_SetAppName cdecl alias "wxApp_SetAppName" (byval self as wxApp ptr, byval name as zstring ptr)
declare function wxApp_SafeYield cdecl alias "wxApp_SafeYield" (byval win as wxWindow ptr, byval onlyIfNeeded as integer) as integer
declare function wxApp_Yield cdecl alias "wxApp_Yield" (byval self as wxApp ptr, byval onlyIfNeeded as integer) as integer
declare sub wxApp_WakeUpIdle cdecl alias "wxApp_WakeUpIdle" ()

#endif
