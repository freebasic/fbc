#Ifndef __setcursorevent_bi__
#Define __setcursorevent_bi__

#Include Once "common.bi"

Declare Function wxSetCursorEvent_ctor WXCALL Alias "wxSetCursorEvent_ctor" (typ As wxEventType) As wxSetCursorEvent Ptr
Declare Function wxSetCursorEvent_GetX WXCALL Alias "wxSetCursorEvent_GetX" (self As wxSetCursorEvent Ptr) As wxInt
Declare Function wxSetCursorEvent_GetY WXCALL Alias "wxSetCursorEvent_GetY" (self As wxSetCursorEvent Ptr) As wxInt
Declare Sub wxSetCursorEvent_SetCursor WXCALL Alias "wxSetCursorEvent_SetCursor" (self As wxSetCursorEvent Ptr, cursor As wxCursor Ptr)
Declare Function wxSetCursorEvent_GetCursor WXCALL Alias "wxSetCursorEvent_GetCursor" (self As wxSetCursorEvent Ptr) As wxCursor Ptr
Declare Function wxSetCursorEvent_HasCursor WXCALL Alias "wxSetCursorEvent_HasCursor" (self As wxSetCursorEvent Ptr) As wxBool

#EndIf ' __setcursorevent_bi__

