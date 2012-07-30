#Ifndef __focusevent_bi__
#Define __focusevent_bi__

#Include Once "common.bi"

Declare Function wxFocusEvent_ctor WXCALL Alias "wxFocusEvent_ctor" (typ As wxEventType) As wxFocusEvent Ptr
Declare Sub wxFocusEvent_SetWindow WXCALL Alias "wxFocusEvent_SetWindow" (self As wxFocusEvent Ptr, win As wxWindow Ptr)
Declare Function wxFocusEvent_GetWindow WXCALL Alias "wxFocusEvent_GetWindow" (self As wxFocusEvent Ptr) As wxWindow Ptr

#EndIf ' __focusevent_bi__

