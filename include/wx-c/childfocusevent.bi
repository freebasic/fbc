#Ifndef __childfocusevent_bi__
#Define __childfocusevent_bi__

#Include Once "common.bi"

' class wxChildFocusEvent
Declare Function wxChildFocusEvent_ctor WXCALL Alias "wxChildFocusEvent_ctor" (win As wxWindow Ptr) As wxChildFocusEvent Ptr
Declare Function wxChildFocusEvent_GetWindow WXCALL Alias "wxChildFocusEvent_GetWindow" (self As wxChildFocusEvent Ptr) As wxWindow Ptr

#EndIf ' __childfocusevent_bi__

