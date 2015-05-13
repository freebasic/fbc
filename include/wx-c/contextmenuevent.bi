#Ifndef __contextmenuevent_bi__
#Define __contextmenuevent_bi__

#Include Once "common.bi"

Declare Function wxContextMenuEvent_ctor WXCALL Alias "wxContextMenuEvent_ctor" (typ As wxEventType) As wxContextMenuEvent Ptr
Declare Sub wxContextMenuEvent_GetPosition WXCALL Alias "wxContextMenuEvent_GetPosition" (self As wxContextMenuEvent Ptr, pt As wxPoint Ptr)
Declare Sub wxContextMenuEvent_SetPosition WXCALL Alias "wxContextMenuEvent_SetPosition" (self As wxContextMenuEvent Ptr, pt As wxPoint Ptr)

#EndIf ' __contextmenuevent_bi__

