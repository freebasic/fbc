#Ifndef __spinctrl_bi__
#Define __spinctrl_bi__

#Include Once "common.bi"

Declare Function wxSpinCtrl_ctor WXCALL Alias "wxSpinCtrl_ctor" () As wxSpinCtrl Ptr
Declare Function wxSpinCtrl_Create WXCALL Alias "wxSpinCtrl_Create" (self As wxSpinCtrl Ptr, _
                       parent   As wxWindow   Ptr, _
                       id       As  wxWindowID=-1, _
                       valueArg As wxString   Ptr, _
                       x        As  wxInt=-1, _
                       y        As  wxInt=-1, _
                       w        As  wxInt=-1, _
                       h        As  wxInt=-1, _
                       style    As  wxUint=0, _
                       min      As  wxInt=  0, _
                       max      As  wxInt=100, _
                       initial  As  wxInt=  0, _
                       nameArg  As wxString Ptr = WX_NULL) As wxBOOL
Declare Sub wxSpinCtrl_dtor WXCALL Alias "wxSpinCtrl_dtor" (self As wxSpinCtrl Ptr)
Declare Sub wxSpinCtrl_SetValue WXCALL Alias "wxSpinCtrl_SetValue" (self As wxSpinCtrl Ptr, Value As wxInt)
Declare Sub wxSpinCtrl_SetValueStr WXCALL Alias "wxSpinCtrl_SetValueStr" (self As wxSpinCtrl Ptr, Value As wxString Ptr)
Declare Sub wxSpinCtrl_SetRange WXCALL Alias "wxSpinCtrl_SetRange" (self As wxSpinCtrl Ptr, min As wxInt, max As wxInt)
Declare Function wxSpinCtrl_GetValue WXCALL Alias "wxSpinCtrl_GetValue" (self As wxSpinCtrl Ptr) As wxInt
Declare Function wxSpinCtrl_GetMin WXCALL Alias "wxSpinCtrl_GetMin" (self As wxSpinCtrl Ptr) As wxInt
Declare Function wxSpinCtrl_GetMax WXCALL Alias "wxSpinCtrl_GetMax" (self As wxSpinCtrl Ptr) As wxInt

#EndIf ' __spinctrl_bi__

