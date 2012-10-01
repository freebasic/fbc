#Ifndef __mouseevent_bi__
#Define __mouseevent_bi__

#Include Once "common.bi"

Declare Function wxMouseEvent_ctor WXCALL Alias "wxMouseEvent_ctor" (typ As wxEventType) As wxMouseEvent Ptr
Declare Function wxMouseEvent_IsButton WXCALL Alias "wxMouseEvent_IsButton" (self As wxMouseEvent Ptr) As wxBool
Declare Function wxMouseEvent_ButtonDown WXCALL Alias "wxMouseEvent_ButtonDown" (self As wxMouseEvent Ptr) As wxBool
Declare Function wxMouseEvent_ButtonDown2 WXCALL Alias "wxMouseEvent_ButtonDown2" (self As wxMouseEvent Ptr, button As wxInt) As wxBool
Declare Function wxMouseEvent_ButtonDClick WXCALL Alias "wxMouseEvent_ButtonDClick" (self As wxMouseEvent Ptr, button As wxInt) As wxBool
Declare Function wxMouseEvent_ButtonUp WXCALL Alias "wxMouseEvent_ButtonUp" (self As wxMouseEvent Ptr, button As wxInt) As wxBool
Declare Function wxMouseEvent_Button WXCALL Alias "wxMouseEvent_Button" (self As wxMouseEvent Ptr, button As wxInt) As wxBool
Declare Function wxMouseEvent_ButtonIsDown WXCALL Alias "wxMouseEvent_ButtonIsDown" (self As wxMouseEvent Ptr, button As wxInt) As wxBool
Declare Function wxMouseEvent_GetButton WXCALL Alias "wxMouseEvent_GetButton" (self As wxMouseEvent Ptr) As wxInt
Declare Function wxMouseEvent_ControlDown WXCALL Alias "wxMouseEvent_ControlDown" (self As wxMouseEvent Ptr) As wxBool
Declare Function wxMouseEvent_MetaDown WXCALL Alias "wxMouseEvent_MetaDown" (self As wxMouseEvent Ptr) As wxBool
Declare Function wxMouseEvent_AltDown WXCALL Alias "wxMouseEvent_AltDown" (self As wxMouseEvent Ptr) As wxBool
Declare Function wxMouseEvent_ShiftDown WXCALL Alias "wxMouseEvent_ShiftDown" (self As wxMouseEvent Ptr) As wxBool
Declare Function wxMouseEvent_LeftDown WXCALL Alias "wxMouseEvent_LeftDown" (self As wxMouseEvent Ptr) As wxBool
Declare Function wxMouseEvent_MiddleDown WXCALL Alias "wxMouseEvent_MiddleDown" (self As wxMouseEvent Ptr) As wxBool
Declare Function wxMouseEvent_RightDown WXCALL Alias "wxMouseEvent_RightDown" (self As wxMouseEvent Ptr) As wxBool
Declare Function wxMouseEvent_LeftUp WXCALL Alias "wxMouseEvent_LeftUp" (self As wxMouseEvent Ptr) As wxBool
Declare Function wxMouseEvent_MiddleUp WXCALL Alias "wxMouseEvent_MiddleUp" (self As wxMouseEvent Ptr) As wxBool
Declare Function wxMouseEvent_RightUp WXCALL Alias "wxMouseEvent_RightUp" (self As wxMouseEvent Ptr) As wxBool
Declare Function wxMouseEvent_LeftDClick WXCALL Alias "wxMouseEvent_LeftDClick" (self As wxMouseEvent Ptr) As wxBool
Declare Function wxMouseEvent_MiddleDClick WXCALL Alias "wxMouseEvent_MiddleDClick" (self As wxMouseEvent Ptr) As wxBool
Declare Function wxMouseEvent_RightDClick WXCALL Alias "wxMouseEvent_RightDClick" (self As wxMouseEvent Ptr) As wxBool
Declare Function wxMouseEvent_LeftIsDown WXCALL Alias "wxMouseEvent_LeftIsDown" (self As wxMouseEvent Ptr) As wxBool
Declare Function wxMouseEvent_MiddleIsDown WXCALL Alias "wxMouseEvent_MiddleIsDown" (self As wxMouseEvent Ptr) As wxBool
Declare Function wxMouseEvent_RightIsDown WXCALL Alias "wxMouseEvent_RightIsDown" (self As wxMouseEvent Ptr) As wxBool
Declare Function wxMouseEvent_Dragging WXCALL Alias "wxMouseEvent_Dragging" (self As wxMouseEvent Ptr) As wxBool
Declare Function wxMouseEvent_Moving WXCALL Alias "wxMouseEvent_Moving" (self As wxMouseEvent Ptr) As wxBool
Declare Function wxMouseEvent_Entering WXCALL Alias "wxMouseEvent_Entering" (self As wxMouseEvent Ptr) As wxBool
Declare Function wxMouseEvent_Leaving WXCALL Alias "wxMouseEvent_Leaving" (self As wxMouseEvent Ptr) As wxBool
Declare Sub wxMouseEvent_GetPosition WXCALL Alias "wxMouseEvent_GetPosition" (self As wxMouseEvent Ptr, pt As wxPoint Ptr)
Declare Sub wxMouseEvent_LogicalPosition WXCALL Alias "wxMouseEvent_LogicalPosition" (self As wxMouseEvent Ptr, dc As wxDC Ptr, pt As wxPoint Ptr)
Declare Function wxMouseEvent_GetWheelRotation WXCALL Alias "wxMouseEvent_GetWheelRotation" (self As wxMouseEvent Ptr) As wxInt
Declare Function wxMouseEvent_GetWheelDelta WXCALL Alias "wxMouseEvent_GetWheelDelta" (self As wxMouseEvent Ptr) As wxInt
Declare Function wxMouseEvent_GetLinesPerAction WXCALL Alias "wxMouseEvent_GetLinesPerAction" (self As wxMouseEvent Ptr) As wxInt
Declare Function wxMouseEvent_IsPageScroll WXCALL Alias "wxMouseEvent_IsPageScroll" (self As wxMouseEvent Ptr) As wxBool
Declare Function wxMouseEvent_GetX WXCALL Alias "wxMouseEvent_GetX" (self As wxMouseEvent Ptr) As wxInt
Declare Function wxMouseEvent_GetY WXCALL Alias "wxMouseEvent_GetY" (self As wxMouseEvent Ptr) As wxInt

#EndIf ' __mouseevent_bi__

