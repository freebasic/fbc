#Ifndef __updateuievent_bi__
#Define __updateuievent_bi__

#Include Once "common.bi"

Declare Function wxUpdateUIEvent_ctor WXCALL Alias "wxUpdateUIEvent_ctor" (commandID As wxWindowID) As wxUpdateUIEvent Ptr
Declare Function wxUpdateUIEvent_CanUpdate WXCALL Alias "wxUpdateUIEvent_CanUpdate" (win As wxWindow Ptr) As wxBool
Declare Sub wxUpdUIEvt_Enable WXCALL Alias "wxUpdUIEvt_Enable" (self As wxUpdateUIEvent Ptr, enable As wxBool)
Declare Sub wxUpdUIEvt_Check WXCALL Alias "wxUpdUIEvt_Check" (self As wxUpdateUIEvent Ptr, check As wxBool)
Declare Function wxUpdateUIEvent_GetChecked WXCALL Alias "wxUpdateUIEvent_GetChecked" (self As wxUpdateUIEvent Ptr) As wxBool
Declare Function wxUpdateUIEvent_GetEnabled WXCALL Alias "wxUpdateUIEvent_GetEnabled" (self As wxUpdateUIEvent Ptr) As wxBool
Declare Function wxUpdateUIEvent_GetSetChecked WXCALL Alias "wxUpdateUIEvent_GetSetChecked" (self As wxUpdateUIEvent Ptr) As wxBool
Declare Function wxUpdateUIEvent_GetSetEnabled WXCALL Alias "wxUpdateUIEvent_GetSetEnabled" (self As wxUpdateUIEvent Ptr) As wxBool
Declare Function wxUpdateUIEvent_GetSetText WXCALL Alias "wxUpdateUIEvent_GetSetText" (self As wxUpdateUIEvent Ptr) As wxBool
Declare Function wxUpdateUIEvent_GetText WXCALL Alias "wxUpdateUIEvent_GetText" (self As wxUpdateUIEvent Ptr) As wxString Ptr
Declare Function wxUpdateUIEvent_GetMode WXCALL Alias "wxUpdateUIEvent_GetMode" () As wxUpdateUIMode
Declare Function wxUpdateUIEvent_GetUpdateInterval WXCALL Alias "wxUpdateUIEvent_GetUpdateInterval" () As wxInt
Declare Sub wxUpdateUIEvent_ResetUpdateTime WXCALL Alias "wxUpdateUIEvent_ResetUpdateTime" ()
Declare Sub wxUpdateUIEvent_SetMode WXCALL Alias "wxUpdateUIEvent_SetMode" (mode As wxUpdateUIMode)
Declare Sub wxUpdateUIEvent_SetText WXCALL Alias "wxUpdateUIEvent_SetText" (self As wxUpdateUIEvent Ptr, txt As wxString Ptr)
Declare Sub wxUpdateUIEvent_SetUpdateInterval WXCALL Alias "wxUpdateUIEvent_SetUpdateInterval" (updateInterval As wxInt)

#EndIf ' __updateuievent_bi__

