#Ifndef __moveevent_bi__
#Define __moveevent_bi__

#Include Once "common.bi"

Declare Function wxMoveEvent_ctor WXCALL Alias "wxMoveEvent_ctor" () As wxMoveEvent Ptr
Declare Sub wxMoveEvent_GetPosition WXCALL Alias "wxMoveEvent_GetPosition" ( self As wxMoveEvent Ptr, pt As wxPoint Ptr)

#EndIf ' __moveevent_bi__

