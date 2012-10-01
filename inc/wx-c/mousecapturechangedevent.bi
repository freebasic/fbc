#Ifndef __mousecapturechangedevent_bi__
#Define __mousecapturechangedevent_bi__

#Include Once "common.bi"

Declare Function wxMouseCaptureChangedEvent_ctor WXCALL Alias "wxMouseCaptureChangedEvent_ctor" (typ As wxEventType) As wxMouseCaptureChangedEvent Ptr
Declare Function wxMouseCaptureChangedEvent_GetCapturedWindow WXCALL Alias "wxMouseCaptureChangedEvent_GetCapturedWindow" (self As wxMouseCaptureChangedEvent Ptr) As wxWindow Ptr

#EndIf ' __mousecapturechangedevent_bi__

