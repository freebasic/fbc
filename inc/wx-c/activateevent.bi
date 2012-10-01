#Ifndef __activeevent_bi__
#Define __activeevent_bi__

#Include Once "common.bi"

Declare Function wxActivateEvent_ctor WXCALL Alias "wxActivateEvent_ctor" (typ As wxEventType) As wxActivateEvent Ptr
Declare Function wxActivateEvent_GetActive WXCALL Alias "wxActivateEvent_GetActive" (self As wxActivateEvent Ptr) As wxBool Ptr

#EndIf ' __activeevent_bi__
