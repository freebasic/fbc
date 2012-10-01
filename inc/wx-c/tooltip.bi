#Ifndef __tooltip_bi__
#Define __tooltip_bi__

#Include Once "common.bi"

Declare Sub wxToolTip_Enable WXCALL Alias "wxToolTip_Enable" (enable As wxBool)
Declare Sub wxToolTip_SetDelay WXCALL Alias "wxToolTip_SetDelay" (msecs As wxInt)
Declare Function wxToolTip_ctor WXCALL Alias "wxToolTip_ctor" (tip As wxString Ptr) As wxToolTip Ptr
Declare Sub wxToolTip_SetTip WXCALL Alias "wxToolTip_SetTip" (self As wxToolTip Ptr, tip As wxString Ptr)
Declare Function wxToolTip_GetTip WXCALL Alias "wxToolTip_GetTip" (self As wxToolTip Ptr) As wxString Ptr
Declare Function wxToolTip_GetWindow WXCALL Alias "wxToolTip_GetWindow" (self As wxToolTip Ptr) As wxString Ptr

#EndIf ' __tooltip_bi__

