''
''
'' fontdialog -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __wxc_fontdialog_bi__
#define __wxc_fontdialog_bi__

#include once "wx.bi"

declare function wxFontDialog alias "wxFontDialog_ctor" () as wxFontDialog ptr
declare function wxFontDialog_Create (byval self as wxFontDialog ptr, byval parent as wxWindow ptr, byval data as wxFontData ptr) as integer
declare sub wxFontDialog_dtor (byval self as wxFontDialog ptr)
declare function wxFontDialog_ShowModal (byval self as wxFontDialog ptr) as integer
declare function wxFontDialog_GetFontData (byval self as wxFontDialog ptr) as wxFontData ptr
declare function wxFontData alias "wxFontData_ctor" () as wxFontData ptr
declare sub wxFontData_dtor (byval self as wxFontData ptr)
declare sub wxFontData_SetAllowSymbols (byval self as wxFontData ptr, byval flag as integer)
declare function wxFontData_GetAllowSymbols (byval self as wxFontData ptr) as integer
declare sub wxFontData_SetColour (byval self as wxFontData ptr, byval colour as wxColour ptr)
declare function wxFontData_GetColour (byval self as wxFontData ptr) as wxColour ptr
declare sub wxFontData_SetShowHelp (byval self as wxFontData ptr, byval flag as integer)
declare function wxFontData_GetShowHelp (byval self as wxFontData ptr) as integer
declare sub wxFontData_EnableEffects (byval self as wxFontData ptr, byval flag as integer)
declare function wxFontData_GetEnableEffects (byval self as wxFontData ptr) as integer
declare sub wxFontData_SetInitialFont (byval self as wxFontData ptr, byval font as wxFont ptr)
declare function wxFontData_GetInitialFont (byval self as wxFontData ptr) as wxFont ptr
declare sub wxFontData_SetChosenFont (byval self as wxFontData ptr, byval font as wxFont ptr)
declare function wxFontData_GetChosenFont (byval self as wxFontData ptr) as wxFont ptr
declare sub wxFontData_SetRange (byval self as wxFontData ptr, byval minRange as integer, byval maxRange as integer)

#endif
