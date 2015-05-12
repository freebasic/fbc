#Ifndef __windowcreateevent_bi__
#Define __windowcreateevent_bi__

#Include Once "common.bi"

' class wxWindowCreateEvent
Declare Function wxWindowCreateEvent_ctor WXCALL Alias "wxWindowCreateEvent_ctor" (win As wxWindow Ptr) As wxWindowCreateEvent Ptr
Declare Function wxWindowCreateEvent_GetWindow WXCALL Alias "wxWindowCreateEvent_GetWindow" (self As wxWindowCreateEvent Ptr) As wxWindow Ptr

#EndIf ' __windowcreateevent_bi__
