#Ifndef __eraseevent_bi__
#Define __eraseevent_bi__

#Include Once "common.bi"

Declare Function wxEraseEvent_ctor WXCALL Alias "wxEraseEvent_ctor" (typ As wxEventType) As wxEraseEvent Ptr
Declare Function wxEraseEvent_GetDC WXCALL Alias "wxEraseEvent_GetDC" (self As wxEraseEvent Ptr) As wxDC Ptr

#EndIf ' __eraseevent_bi__

