#Ifndef __showevent_bi__
#Define __showevent_bi__

#Include Once "common.bi"

Declare Function wxShowEvent_ctor WXCALL Alias "wxShowEvent_ctor" (typ As wxEventType) As wxShowEvent Ptr
Declare Function wxShowEvent_GetShow WXCALL Alias "wxShowEvent_GetShow" (self As wxShowEvent Ptr) As wxBool
Declare Sub wxShowEvent_SetShow WXCALL Alias "wxShowEvent_SetShow" (self As wxShowEvent Ptr, show As wxBool)

#EndIf ' __showevent_bi__

