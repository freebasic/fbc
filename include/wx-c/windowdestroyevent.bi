#Ifndef __windowdestroyevent_bi__
#Define __windowdestroyevent_bi__

#Include Once "common.bi"

' class wxWindowDestroyEvent
Declare Function wxWindowDestroyEvent_ctor WXCALL Alias "wxWindowDestroyEvent_ctor" (win As wxWindow Ptr) As wxWindowDestroyEvent Ptr
Declare Function wxWindowDestroyEvent_GetWindow WXCALL Alias "wxWindowDestroyEvent_GetWindow" (self As wxWindowDestroyEvent Ptr) As wxWindow Ptr

#EndIf ' __windowdestroyevent_bi__

