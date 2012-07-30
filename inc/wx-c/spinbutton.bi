#Ifndef __spinbutton_bi__
#Define __spinbutton_bi__

#Include Once "common.bi"

' class wxSpinButton
Declare Function wxSpinButton_ctor WXCALL Alias "wxSpinButton_ctor" () As wxSpinButton Ptr
Declare Function wxSpinButton_Create WXCALL Alias "wxSpinButton_Create" (self As wxSpinButton Ptr, _
                         parent  As wxWindow     Ptr, _
                         id      As  wxWindowID       = -1, _
                         x       As  wxInt            = -1, _
                         y       As  wxInt            = -1, _
                         w       As  wxInt            = -1, _
                         h       As  wxInt            = -1, _
                         style   As  wxUInt           =  0, _
                         nameArg As wxString     Ptr = WX_NULL) As wxBool
Declare Function wxSpinButton_GetValue WXCALL Alias "wxSpinButton_GetValue" (self As wxSpinButton Ptr) As wxInt
Declare Function wxSpinButton_GetMin WXCALL Alias "wxSpinButton_GetMin" (self As wxSpinButton Ptr) As wxInt
Declare Function wxSpinButton_GetMax WXCALL Alias "wxSpinButton_GetMax" (self As wxSpinButton Ptr) As wxInt
Declare Sub wxSpinButton_SetValue WXCALL Alias "wxSpinButton_SetValue" (self As wxSpinButton Ptr, value As wxInt)
Declare Sub wxSpinButton_SetRange WXCALL Alias "wxSpinButton_SetRange" (self As wxSpinButton Ptr, minVal As wxInt, maxVal As wxInt)

' class wxSpinEvent
Declare Function wxSpinEvent_ctor WXCALL Alias "wxSpinEvent_ctor" (typ As wxEventType, id As wxInt) As wxSpinEvent Ptr
Declare Function wxSpinEvent_GetPosition WXCALL Alias "wxSpinEvent_GetPosition" (self As wxSpinEvent Ptr) As wxInt
Declare Sub wxSpinEvent_SetPosition WXCALL Alias "wxSpinEvent_SetPosition" (self As wxSpinEvent Ptr, ipos As wxInt)
Declare Sub wxSpinEvent_Veto WXCALL Alias "wxSpinEvent_Veto" (self As wxSpinEvent Ptr)
Declare Sub wxSpinEvent_Allow WXCALL Alias "wxSpinEvent_Allow" (self As wxSpinEvent Ptr)
Declare Function wxSpinEvent_IsAllowed WXCALL Alias "wxSpinEvent_IsAllowed" (self As wxSpinEvent Ptr) As wxBool

#EndIf ' __spinbutton_bi__

