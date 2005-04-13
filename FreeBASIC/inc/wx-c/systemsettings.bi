''
''
'' systemsettings -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __systemsettings_bi__
#define __systemsettings_bi__

#include once "wx-c/wx.bi"

declare function wxSystemSettings_GetColour cdecl alias "wxSystemSettings_GetColour" (byval index as wxSystemColour) as wxColour ptr
declare function wxSystemSettings_GetFont cdecl alias "wxSystemSettings_GetFont" (byval index as wxSystemFont) as wxFont ptr
declare function wxSystemSettings_GetMetric cdecl alias "wxSystemSettings_GetMetric" (byval index as wxSystemMetric) as integer
declare function wxSystemSettings_HasFeature cdecl alias "wxSystemSettings_HasFeature" (byval index as wxSystemFeature) as integer
declare function wxSystemSettings_GetScreenType cdecl alias "wxSystemSettings_GetScreenType" () as wxSystemScreenType
declare sub wxSystemSettings_SetScreenType cdecl alias "wxSystemSettings_SetScreenType" (byval screen as wxSystemScreenType)

#endif
