#Ifndef __idleevent_bi__
#Define __idleevent_bi__

#Include Once "common.bi"

Declare Function wxIdleEvent_ctor WXCALL Alias "wxIdleEvent_ctor" () As wxIdleEvent Ptr
Declare Sub wxIdleEvent_RequestMore WXCALL Alias "wxIdleEvent_RequestMore" (self As wxIdleEvent Ptr, needMore As wxBool)
Declare Function wxIdleEvent_MoreRequested WXCALL Alias "wxIdleEvent_MoreRequested" (self As wxIdleEvent Ptr) As wxBool
Declare Sub wxIdleEvent_SetMode WXCALL Alias "wxIdleEvent_SetMode" (mode As wxIdleMode)
Declare Function wxIdleEvent_GetMode WXCALL Alias "wxIdleEvent_GetMode" () As wxIdleMode
Declare Function wxIdleEvent_CanSend WXCALL Alias "wxIdleEvent_CanSend" (win As wxWindow Ptr) As wxBool

#EndIf ' __idleevent_bi__

