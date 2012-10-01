#Ifndef __keyevent_bi__
#Define __keyevent_bi__

#Include Once "common.bi"

Declare Function wxKeyEvent_ctor WXCALL Alias "wxKeyEvent_ctor" (typ As wxEventType) As wxKeyEvent Ptr
Declare Function wxKeyEvent_ControlDown WXCALL Alias "wxKeyEvent_ControlDown" (self As wxKeyEvent Ptr) As wxBool
Declare Function wxKeyEvent_ShiftDown WXCALL Alias "wxKeyEvent_ShiftDown" (self As wxKeyEvent Ptr) As wxBool
Declare Function wxKeyEvent_AltDown WXCALL Alias "wxKeyEvent_AltDown" (self As wxKeyEvent Ptr) As wxBool
Declare Function wxKeyEvent_MetaDown WXCALL Alias "wxKeyEvent_MetaDown" (self As wxKeyEvent Ptr) As wxBool
Declare Function wxKeyEvent_GetRawKeyCode WXCALL Alias "wxKeyEvent_GetRawKeyCode" (self As wxKeyEvent Ptr) As wxInt
Declare Function wxKeyEvent_GetKeyCode WXCALL Alias "wxKeyEvent_GetKeyCode" (self As wxKeyEvent Ptr) As wxInt
Declare Function wxKeyEvent_GetRawKeyFlags WXCALL Alias "wxKeyEvent_GetRawKeyFlags" (self As wxKeyEvent Ptr) As wxInt
Declare Function wxKeyEvent_HasModifiers WXCALL Alias "wxKeyEvent_HasModifiers" (self As wxKeyEvent Ptr) As wxBool
Declare Sub wxKeyEvent_GetPosition WXCALL Alias "wxKeyEvent_GetPosition" (self As wxKeyEvent Ptr, pt As wxPoint Ptr)
Declare Function wxKeyEvent_GetX WXCALL Alias "wxKeyEvent_GetX" (self As wxKeyEvent Ptr) As wxInt
Declare Function wxKeyEvent_GetY WXCALL Alias "wxKeyEvent_GetY" (self As wxKeyEvent Ptr) As wxInt
Declare Function wxKeyEvent_CmdDown WXCALL Alias "wxKeyEvent_CmdDown" (self As wxKeyEvent Ptr) As wxBool
Declare Function wxKeyEvent_GetUnicodeChar WXCALL Alias "wxKeyEvent_GetUnicodeChar" (self As wxKeyEvent Ptr) As wxInt

#EndIf ' __keyevent_bi__

