#Ifndef __menuitem_bi__
#Define __menuitem_bi__

#Include Once "common.bi"

Declare Function wxMenuItem_ctor WXCALL Alias "wxMenuItem_ctor" (parentMenu As wxMenu Ptr, _ 
                     id         As  wxInt, _
                     txt        As wxString Ptr, _
                     helpString As wxString Ptr, _
                     kind       As  wxItemKind, _
                     subMenu    As wxMenu Ptr) As wxMenuItem Ptr
Declare Function wxMenuItem_GetMenu WXCALL Alias "wxMenuItem_GetMenu" (self As wxMenuItem Ptr) As wxMenu Ptr
Declare Sub wxMenuItem_SetMenu WXCALL Alias "wxMenuItem_SetMenu" (self As wxMenuItem Ptr, menu As wxMenu Ptr)
Declare Sub wxMenuItem_SetId WXCALL Alias "wxMenuItem_SetId" (self As wxMenuItem Ptr, iID As wxInt)
Declare Function wxMenuItem_GetId WXCALL Alias "wxMenuItem_GetId" (self As wxMenuItem Ptr) As wxInt
Declare Function wxMenuItem_IsSeparator WXCALL Alias "wxMenuItem_IsSeparator" (self As wxMenuItem Ptr) As wxBool
Declare Sub wxMenuItem_SetText WXCALL Alias "wxMenuItem_SetText" (self As wxMenuItem Ptr, txt As wxString Ptr)
Declare Function wxMenuItem_GetLabel WXCALL Alias "wxMenuItem_GetLabel" (self As wxMenuItem Ptr) As wxString Ptr
Declare Function wxMenuItem_GetText WXCALL Alias "wxMenuItem_GetText" (self As wxMenuItem Ptr) As wxString Ptr
Declare Function wxMenuItem_GetLabelFromText WXCALL Alias "wxMenuItem_GetLabelFromText" (self As wxMenuItem Ptr, txt As wxString Ptr) As wxString Ptr
Declare Function wxMenuItem_GetKind WXCALL Alias "wxMenuItem_GetKind" (self As wxMenuItem Ptr) As wxItemKind
Declare Sub wxMenuItem_SetCheckable WXCALL Alias "wxMenuItem_SetCheckable" (self As wxMenuItem Ptr, checkable As wxBool)
Declare Function wxMenuItem_IsCheckable WXCALL Alias "wxMenuItem_IsCheckable" (self As wxMenuItem Ptr) As wxBool
Declare Function wxMenuItem_IsSubMenu WXCALL Alias "wxMenuItem_IsSubMenu" (self As wxMenuItem Ptr) As wxBool
Declare Sub wxMenuItem_SetSubMenu WXCALL Alias "wxMenuItem_SetSubMenu" (self As wxMenuItem Ptr, menu As wxMenu Ptr)
Declare Function wxMenuItem_GetSubMenu WXCALL Alias "wxMenuItem_GetSubMenu" (self As wxMenuItem Ptr) As wxMenu Ptr
Declare Sub wxMenuItem_Enable WXCALL Alias "wxMenuItem_Enable" (self As wxMenuItem Ptr, enable As wxBool)
Declare Function wxMenuItem_IsEnabled WXCALL Alias "wxMenuItem_IsEnabled" (self As wxMenuItem Ptr) As wxBool
Declare Sub wxMenuItem_Check WXCALL Alias "wxMenuItem_Check" (self As wxMenuItem Ptr, check As wxBool)
Declare Function wxMenuItem_IsChecked WXCALL Alias "wxMenuItem_IsChecked" (self As wxMenuItem Ptr) As wxBool
Declare Sub wxMenuItem_Toggle WXCALL Alias "wxMenuItem_Toggle" (self As wxMenuItem Ptr)
Declare Sub wxMenuItem_SetHelp WXCALL Alias "wxMenuItem_SetHelp" (self As wxMenuItem Ptr, help As wxString Ptr)
Declare Function wxMenuItem_GetHelp WXCALL Alias "wxMenuItem_GetHelp" (self As wxMenuItem Ptr) As wxString Ptr
Declare Function wxMenuItem_GetAccel WXCALL Alias "wxMenuItem_GetAccel" (self As wxMenuItem Ptr) As wxAcceleratorEntry Ptr
Declare Sub wxMenuItem_SetAccel WXCALL Alias "wxMenuItem_SetAccel" (self As wxMenuItem Ptr, accel As wxAcceleratorEntry Ptr)
Declare Sub wxMenuItem_SetName WXCALL Alias "wxMenuItem_SetName" (self As wxMenuItem Ptr, nam As wxString Ptr)
Declare Function wxMenuItem_GetName WXCALL Alias "wxMenuItem_GetName" (self As wxMenuItem Ptr) As wxString Ptr
Declare Function wxMenuItem_NewCheck WXCALL Alias "wxMenuItem_NewCheck" (parentMenu As wxMenu Ptr, _
                         id         As  wxInt, _
                         txt        As wxString Ptr, _
                         helpString As wxString Ptr, _
                         checkable  As  wxBool, _
                         subMenu    As wxMenu Ptr) As wxMenuItem Ptr
Declare Function wxMenuItem_New WXCALL Alias "wxMenuItem_New" (parentMenu As wxMenu Ptr, _)(parentMenu As wxMenu Ptr, _
                    id         As  wxInt, _
                    txt        As wxString Ptr, _
                    helpString As wxString Ptr, _
                    kind       As  wxItemKind, _
                    subMenu    As wxMenu Ptr) As wxMenuItem Ptr
Declare Sub wxMenuItem_SetBitmap WXCALL Alias "wxMenuItem_SetBitmap" (self As wxMenuItem Ptr, bitmap As wxBitmap Ptr)

#EndIf ' __menuitem_bi__


