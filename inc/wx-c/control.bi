#Ifndef __control_bi__
#Define __control_bi__

#Include Once "common.bi"

Declare Sub wxControl_Command WXCALL Alias "wxControl_Command" (self As wxControl Ptr, event As wxCommandEvent Ptr)
Declare Sub wxControl_SetLabel WXCALL Alias "wxControl_SetLabel" (self As wxControl Ptr, label As wxString Ptr)
Declare Function wxControl_GetLabel WXCALL Alias "wxControl_GetLabel" (self As wxControl Ptr) As wxString Ptr
Declare Function wxControl_GetAlignment WXCALL Alias "wxControl_GetAlignment" (self As wxControl Ptr) As wxInt
Declare Function wxControl_SetFont WXCALL Alias "wxControl_SetFont" (self As wxControl Ptr, font As wxFont Ptr) As wxBool

#EndIf ' __control_bi__

