''
''
'' systemsettings -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __wxc_systemsettings_bi__
#define __wxc_systemsettings_bi__

#include once "wx.bi"

declare function wxSystemSettings_GetColour (byval index as wxSystemColour) as wxColour ptr
declare function wxSystemSettings_GetFont (byval index as wxSystemFont) as wxFont ptr
declare function wxSystemSettings_GetMetric (byval index as wxSystemMetric) as integer
declare function wxSystemSettings_HasFeature (byval index as wxSystemFeature) as integer
declare function wxSystemSettings_GetScreenType () as wxSystemScreenType
declare sub wxSystemSettings_SetScreenType (byval screen as wxSystemScreenType)

#endif
