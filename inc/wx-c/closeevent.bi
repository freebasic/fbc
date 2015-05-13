#Ifndef __closeevent_bi__
#Define __closeevent_bi__

#Include Once "common.bi"

Declare Function wxCloseEvent_ctor WXCALL Alias "wxCloseEvent_ctor" (typ As wxEventType) As wxCloseEvent Ptr
Declare Sub wxCloseEvent_SetLoggingOff WXCALL Alias "wxCloseEvent_SetLoggingOff" (self As wxCloseEvent Ptr, logOff As wxBool)
Declare Function wxCloseEvent_GetLoggingOff WXCALL Alias "wxCloseEvent_GetLoggingOff" (self As wxCloseEvent Ptr) As wxBool
Declare Sub wxCloseEvent_Veto WXCALL Alias "wxCloseEvent_Veto" (self As wxCloseEvent Ptr, veto As wxBool)
Declare Sub wxCloseEvent_SetCanVeto WXCALL Alias "wxCloseEvent_SetCanVeto" (self As wxCloseEvent Ptr, canVeto As wxBool)
Declare Function wxCloseEvent_CanVeto WXCALL Alias "wxCloseEvent_CanVeto" (self As wxCloseEvent Ptr) As wxBool
Declare Function wxCloseEvent_GetVeto WXCALL Alias "wxCloseEvent_GetVeto" (self As wxCloseEvent Ptr) As wxBool

#EndIf ' __closeevent_bi__

