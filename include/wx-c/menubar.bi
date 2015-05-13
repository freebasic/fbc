#Ifndef __menubar_bi__
#Define __menubar_bi__

#Include Once "common.bi"

Declare Function wxMenuBar_ctor WXCALL Alias "wxMenuBar_ctor" () As wxMenuBar Ptr
Declare Function wxMenuBar_ctor2 WXCALL Alias "wxMenuBar_ctor2" (style As wxUInt) As wxMenuBar Ptr
Declare Function wxMenuBar_Append WXCALL Alias "wxMenuBar_Append" (self As wxMenuBar Ptr, menu As wxMenu Ptr, title As wxString Ptr) As wxBool
Declare Sub wxMenuBar_Check WXCALL Alias "wxMenuBar_Check" (self As wxMenuBar Ptr, iID As wxInt, check As wxBool)
Declare Function wxMenuBar_IsChecked WXCALL Alias "wxMenuBar_IsChecked" (self As wxMenuBar Ptr, iID As wxInt) As wxBool
Declare Function wxMenuBar_Insert WXCALL Alias "wxMenuBar_Insert" (self As wxMenuBar Ptr, iPos As wxInt, menu As wxMenu Ptr, title As wxString Ptr) As wxBool
Declare Function wxMenuBar_FindItem WXCALL Alias "wxMenuBar_FindItem" (self As wxMenuBar Ptr, iID As wxInt, menu As wxMenu Ptr Ptr) As wxMenuItem Ptr
Declare Function wxMenuBar_GetMenuCount WXCALL Alias "wxMenuBar_GetMenuCount" (self As wxMenuBar Ptr) As size_t
Declare Function wxMenuBar_GetMenu WXCALL Alias "wxMenuBar_GetMenu" (self As wxMenuBar Ptr, p As size_t) As wxMenu Ptr
Declare Function wxMenuBar_Replace WXCALL Alias "wxMenuBar_Replace" (self As wxMenuBar Ptr, iPos As wxInt, menu As wxMenu Ptr, title As wxString Ptr) As wxMenu Ptr
Declare Function wxMenuBar_Remove WXCALL Alias "wxMenuBar_Remove" (self As wxMenuBar Ptr, iPos As wxInt) As wxMenu Ptr
Declare Sub wxMenuBar_EnableTop WXCALL Alias "wxMenuBar_EnableTop" (self As wxMenuBar Ptr, iPos As wxInt, enable As wxBool)
Declare Sub wxMenuBar_Enable WXCALL Alias "wxMenuBar_Enable" (self As wxMenuBar Ptr, iID As wxInt, enable As wxBool)
Declare Function wxMenuBar_FindMenu WXCALL Alias "wxMenuBar_FindMenu" (self As wxMenuBar Ptr, title As wxString Ptr) As wxInt
Declare Function wxMenuBar_FindMenuItem WXCALL Alias "wxMenuBar_FindMenuItem" (self As wxMenuBar Ptr, menuString As wxString Ptr, itemString As wxString Ptr) As wxInt
Declare Function wxMenuBar_GetHelpString WXCALL Alias "wxMenuBar_GetHelpString" (self As wxMenuBar Ptr, iID As wxInt) As wxString Ptr
Declare Function wxMenuBar_GetLabel WXCALL Alias "wxMenuBar_GetLabel" (self As wxMenuBar Ptr, iID As wxInt) As wxString Ptr
Declare Function wxMenuBar_GetLabelTop WXCALL Alias "wxMenuBar_GetLabelTop" (self As wxMenuBar Ptr, iPos As wxInt) As wxString Ptr
Declare Function wxMenuBar_IsEnabled WXCALL Alias "wxMenuBar_IsEnabled" (self As wxMenuBar Ptr, iID As wxInt) As wxBool
Declare Sub wxMenuBar_Refresh WXCALL Alias "wxMenuBar_Refresh" (self As wxMenuBar Ptr)
Declare Sub wxMenuBar_SetHelpString WXCALL Alias "wxMenuBar_SetHelpString" (self As wxMenuBar Ptr, iID As wxInt, helpstring As wxString Ptr)
Declare Sub wxMenuBar_SetLabel WXCALL Alias "wxMenuBar_SetLabel" (self As wxMenuBar Ptr, iID As wxInt, label As wxString Ptr)
Declare Sub wxMenuBar_SetLabelTop WXCALL Alias "wxMenuBar_SetLabelTop" (self As wxMenuBar Ptr, iPos As wxInt, label As wxString Ptr)

#EndIf ' __menubar_bi__

