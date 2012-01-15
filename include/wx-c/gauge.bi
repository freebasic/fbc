#Ifndef __gauge_bi__
#Define __gauge_bi__

#Include Once "common.bi"

' class wxGauge
Declare Function wxGauge_ctor WXCALL Alias "wxGauge_ctor" () As wxGauge Ptr
Declare Sub wxGauge_dtor WXCALL Alias "wxGauge_dtor" (self As wxGauge Ptr)
Declare Function wxGauge_Create WXCALL Alias "wxGauge_Create" (self      As wxGauge Ptr, _
                    parent    As wxWindow Ptr, _
                    id        As wxWindowID=-1, _
                    range     As wxInt=0, _
                    x         As wxInt=-1, _
                    y         As wxInt=-1, _
                    w         As wxInt=-1, _
                    h         As wxInt=-1, _
                    style     As wxUint=0, _
                    validator As wxValidator Ptr=WX_NULL, _
                    nameArg   As wxString Ptr=WX_NULL) As wxBool
Declare Sub wxGauge_SetRange WXCALL Alias "wxGauge_SetRange" (self As wxGauge Ptr, range As wxInt)
Declare Function wxGauge_GetRange WXCALL Alias "wxGauge_GetRange" (self As wxGauge Ptr) As wxInt
Declare Sub wxGauge_SetValue WXCALL Alias "wxGauge_SetValue" (self As wxGauge Ptr, p As wxInt)
Declare Function wxGauge_GetValue WXCALL Alias "wxGauge_GetValue" (self As wxGauge Ptr) As wxInt
Declare Sub wxGauge_SetShadowWidth WXCALL Alias "wxGauge_SetShadowWidth" (self As wxGauge Ptr, w As wxInt)
Declare Function wxGauge_GetShadowWidth WXCALL Alias "wxGauge_GetShadowWidth" (self As wxGauge Ptr) As wxInt
Declare Sub wxGauge_SetBezelFace WXCALL Alias "wxGauge_SetBezelFace" (self As wxGauge Ptr, w As wxInt)
Declare Function wxGauge_GetBezelFace WXCALL Alias "wxGauge_GetBezelFace" (self As wxGauge Ptr) As wxInt
Declare Function wxGauge_AcceptsFocus WXCALL Alias "wxGauge_AcceptsFocus" (self As wxGauge Ptr) As wxBool
Declare Function wxGauge_IsVertical WXCALL Alias "wxGauge_IsVertical" (self As wxGauge Ptr) As wxBool

#EndIf ' __gauge_bi__

