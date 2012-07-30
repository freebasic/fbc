#Ifndef __systemsettings_bi__
#Define __systemsettings_bi__

#Include Once "common.bi"

Declare Function wxSystemSettings_GetColour WXCALL Alias "wxSystemSettings_GetColour" (index As wxSystemColour) As wxColour Ptr
Declare Function wxSystemSettings_GetFont WXCALL Alias "wxSystemSettings_GetFont" (index As wxSystemFont) As wxFont Ptr
Declare Function wxSystemSettings_GetMetric WXCALL Alias "wxSystemSettings_GetMetric" (index As wxSystemMetric) As wxInt
Declare Function wxSystemSettings_HasFeature WXCALL Alias "wxSystemSettings_HasFeature" (index As wxSystemFeature) As wxBool
Declare Function wxSystemSettings_GetScreenType WXCALL Alias "wxSystemSettings_GetScreenType" () As wxSystemScreenType
Declare Sub wxSystemSettings_SetScreenType WXCALL Alias "wxSystemSettings_SetScreenType" (ScreenType As wxSystemScreenType)

#EndIf ' __systemsettings_bi__

