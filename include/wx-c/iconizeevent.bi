#Ifndef __iconizeevent_bi__
#Define __iconizeevent_bi__

#Include Once "common.bi"

Declare Function wxIconizeEvent_ctor WXCALL Alias "wxIconizeEvent_ctor" (typ As wxEventType) As wxIconizeEvent Ptr
Declare Function wxIconizeEvent_Iconized WXCALL Alias "wxIconizeEvent_Iconized" (self As wxIconizeEvent Ptr) As wxBool

#EndIf __iconizeevent_bi__

