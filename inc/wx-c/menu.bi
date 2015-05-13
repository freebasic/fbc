#Ifndef __menu_bi__
#Define __menu_bi__

#Include Once "common.bi"

' class wxMenuBase
Declare Function wxMenuBase_ctor1 WXCALL Alias "wxMenuBase_ctor1" (title As wxString Ptr, style As wxUInt) As wxMenuBase Ptr
Declare Function wxMenuBase_ctor2 WXCALL Alias "wxMenuBase_ctor2" (style As wxUInt) As wxMenuBase Ptr
Declare Function wxMenuBase_Append WXCALL Alias "wxMenuBase_Append" (self As wxMenuBase Ptr, id As wxInt, item As wxString Ptr, helpString As wxString Ptr, kind As wxItemKind) As wxMenuItem Ptr
Declare Function wxMenuBase_AppendSeparator WXCALL Alias "wxMenuBase_AppendSeparator" (self As wxMenuBase Ptr) As wxMenuItem Ptr
Declare Function wxMenuBase_AppendCheckItem WXCALL Alias "wxMenuBase_AppendCheckItem" (self As wxMenuBase Ptr, itemid As wxInt, txt As wxString Ptr, help As wxString Ptr) As wxMenuItem Ptr
Declare Function wxMenuBase_AppendRadioItem WXCALL Alias "wxMenuBase_AppendRadioItem" (self As wxMenuBase Ptr, itemid As wxInt, txt As wxString Ptr, help As wxString Ptr) As wxMenuItem Ptr
Declare Function wxMenuBase_AppendSubMenu WXCALL Alias "wxMenuBase_AppendSubMenu" (self As wxMenuBase Ptr, id As wxInt, item As wxString Ptr, subMenu As wxMenu Ptr, helpString As wxString Ptr) As wxMenuItem Ptr
Declare Function wxMenuBase_AppendItem WXCALL Alias "wxMenuBase_AppendItem" (self As wxMenuBase Ptr, item As wxMenuItem Ptr) As wxMenuItem Ptr
Declare Sub wxMenuBase_Break WXCALL Alias "wxMenuBase_Break" (self As wxMenuBase Ptr)
Declare Function wxMenuBase_Insert WXCALL Alias "wxMenuBase_Insert" (self As wxMenuBase Ptr, p As size_t, item As wxMenuItem Ptr) As wxMenuItem Ptr
Declare Function wxMenuBase_Insert2 WXCALL Alias "wxMenuBase_Insert2" (self As wxMenuBase Ptr, p As size_t, itemid As wxInt, txt As wxString Ptr, help As wxString Ptr, kind As wxItemKind) As wxMenuItem Ptr
Declare Function wxMenuBase_InsertSeparator WXCALL Alias "wxMenuBase_InsertSeparator" (self As wxMenuBase Ptr, p As size_t) As wxMenuItem Ptr
Declare Function wxMenuBase_InsertCheckItem WXCALL Alias "wxMenuBase_InsertCheckItem" (self As wxMenuBase Ptr, p As size_t, itemid As wxInt, txt As wxString Ptr, help As wxString Ptr) As wxMenuItem Ptr
Declare Function wxMenuBase_InsertRadioItem WXCALL Alias "wxMenuBase_InsertRadioItem" (self As wxMenuBase Ptr, p As size_t, itemid As wxInt, txt As wxString Ptr, help As wxString Ptr) As wxMenuItem Ptr
Declare Function wxMenuBase_InsertSubMenu WXCALL Alias "wxMenuBase_InsertSubMenu" (self As wxMenuBase Ptr, p As size_t, itemid As wxInt, txt As wxString Ptr, subMenu As wxMenu Ptr, help As wxString Ptr) As wxMenuItem Ptr
Declare Function wxMenuBase_Prepend WXCALL Alias "wxMenuBase_Prepend" (self As wxMenuBase Ptr, item As wxMenuItem Ptr) As wxMenuItem Ptr
Declare Function wxMenuBase_Prepend2 WXCALL Alias "wxMenuBase_Prepend2" (self As wxMenuBase Ptr, itemid As wxInt, txt As wxString Ptr, help As wxString Ptr, kind As wxItemKind) As wxMenuItem Ptr
Declare Function wxMenuBase_PrependSeparator WXCALL Alias "wxMenuBase_PrependSeparator" (self As wxMenuBase Ptr) As wxMenuItem Ptr
Declare Function wxMenuBase_PrependCheckItem WXCALL Alias "wxMenuBase_PrependCheckItem" (self As wxMenuBase Ptr, itemid As wxInt, txt As wxString Ptr, help As wxString Ptr) As wxMenuItem Ptr
Declare Function wxMenuBase_PrependRadioItem WXCALL Alias "wxMenuBase_PrependRadioItem" (self As wxMenuBase Ptr, itemid As wxInt, txt As wxString Ptr, help As wxString Ptr) As wxMenuItem Ptr
Declare Function wxMenuBase_PrependSubMenu WXCALL Alias "wxMenuBase_PrependSubMenu" (self As wxMenuBase Ptr, itemid As wxInt, txt As wxString Ptr, subMenu As wxMenu Ptr, help As wxString Ptr) As wxMenuItem Ptr
Declare Function wxMenuBase_Remove WXCALL Alias "wxMenuBase_Remove" (self As wxMenuBase Ptr, itemid As wxInt) As wxMenuItem Ptr
Declare Function wxMenuBase_Remove2 WXCALL Alias "wxMenuBase_Remove2" (self As wxMenuBase Ptr, item As wxMenuItem Ptr) As wxMenuItem Ptr
Declare Function wxMenuBase_Delete WXCALL Alias "wxMenuBase_Delete" (self As wxMenuBase Ptr, itemid As wxInt) As wxBool
Declare Function wxMenuBase_Delete2 WXCALL Alias "wxMenuBase_Delete2" (self As wxMenuBase Ptr, item As wxMenuItem Ptr) As wxBool
Declare Function wxMenuBase_Destroy WXCALL Alias "wxMenuBase_Destroy" (self As wxMenuBase Ptr, itemid As wxInt) As wxBool
Declare Function wxMenuBase_Destroy2 WXCALL Alias "wxMenuBase_Destroy2" (self As wxMenuBase Ptr, item As wxMenuItem Ptr) As wxBool
Declare Function wxMenuBase_GetMenuItemCount WXCALL Alias "wxMenuBase_GetMenuItemCount" (self As wxMenuBase Ptr) As wxInt
Declare Function wxMenuBase_FindItem WXCALL Alias "wxMenuBase_FindItem" (self As wxMenuBase Ptr, item As wxString Ptr) As wxInt
Declare Function wxMenuBase_FindItem2 WXCALL Alias "wxMenuBase_FindItem2" (self As wxMenuBase Ptr, itemid As wxInt, menu As wxMenu Ptr Ptr) As wxMenuItem Ptr
Declare Function wxMenuBase_FindItemByPosition WXCALL Alias "wxMenuBase_FindItemByPosition" (self As wxMenuBase Ptr, p As size_t) As wxMenuItem Ptr
Declare Sub wxMenuBase_Enable WXCALL Alias "wxMenuBase_Enable" (self As wxMenuBase Ptr, itemid As wxInt, enable As wxBool)
Declare Function wxMenuBase_IsEnabled WXCALL Alias "wxMenuBase_IsEnabled" (self As wxMenuBase Ptr, itemid As wxInt) As wxBool
Declare Sub wxMenuBase_Check WXCALL Alias "wxMenuBase_Check" (self As wxMenuBase Ptr, itemid As wxInt, check As wxBool)
Declare Function wxMenuBase_IsChecked WXCALL Alias "wxMenuBase_IsChecked" (self As wxMenuBase Ptr, itemid As wxInt) As wxBool
Declare Sub wxMenuBase_SetLabel WXCALL Alias "wxMenuBase_SetLabel" (self As wxMenuBase Ptr, itemid As wxInt, label As wxString Ptr)
Declare Function wxMenuBase_GetLabel WXCALL Alias "wxMenuBase_GetLabel" (self As wxMenuBase Ptr, itemid As wxInt) As wxString Ptr
Declare Sub wxMenuBase_SetHelpString WXCALL Alias "wxMenuBase_SetHelpString" (self As wxMenuBase Ptr, itemid As wxInt, helpString As wxString Ptr)
Declare Function wxMenuBase_GetHelpString WXCALL Alias "wxMenuBase_GetHelpString" (self As wxMenuBase Ptr, itemid As wxInt) As wxString Ptr
Declare Sub wxMenuBase_SetTitle WXCALL Alias "wxMenuBase_SetTitle" (self As wxMenuBase Ptr, title As wxString Ptr)
Declare Function wxMenuBase_GetTitle WXCALL Alias "wxMenuBase_GetTitle" (self As wxMenuBase Ptr) As wxString Ptr
Declare Sub wxMenuBase_SetEventHandler WXCALL Alias "wxMenuBase_SetEventHandler" (self As wxMenuBase Ptr, handler As wxEventHandler Ptr)
Declare Function wxMenuBase_GetEventHandler WXCALL Alias "wxMenuBase_GetEventHandler" (self As wxMenuBase Ptr) As wxEventHandler Ptr
Declare Sub wxMenuBase_SetInvokingWindow WXCALL Alias "wxMenuBase_SetInvokingWindow" (self As wxMenuBase Ptr, win As wxWindow Ptr)
Declare Function wxMenuBase_GetInvokingWindow WXCALL Alias "wxMenuBase_GetInvokingWindow" (self As wxMenuBase Ptr) As wxWindow Ptr
Declare Function wxMenuBase_GetStyle WXCALL Alias "wxMenuBase_GetStyle" (self As wxMenuBase Ptr) As wxInt
Declare Sub wxMenuBase_UpdateUI WXCALL Alias "wxMenuBase_UpdateUI" (self As wxMenuBase Ptr, src As wxEventHandler Ptr)
Declare Function wxMenuBase_GetMenuBar WXCALL Alias "wxMenuBase_GetMenuBar" (self As wxMenuBase Ptr) As wxMenuBar Ptr
Declare Function wxMenuBase_IsAttached WXCALL Alias "wxMenuBase_IsAttached" (self As wxMenuBase Ptr) As wxBool
Declare Sub wxMenuBase_SetParent WXCALL Alias "wxMenuBase_SetParent" (self As wxMenuBase Ptr, parent As wxWindow Ptr)
Declare Function wxMenuBase_GetParent WXCALL Alias "wxMenuBase_GetParent" (self As wxMenuBase Ptr) As wxMenu Ptr
Declare Function wxMenuBase_FindChildItem WXCALL Alias "wxMenuBase_FindChildItem" (self As wxMenuBase Ptr, itemid As wxInt, p As size_t Ptr) As wxMenuItem Ptr
Declare Function wxMenuBase_FindChildItem2 WXCALL Alias "wxMenuBase_FindChildItem2" (self As wxMenuBase Ptr, itemid As wxInt) As wxMenuItem Ptr
Declare Function wxMenuBase_SendEvent WXCALL Alias "wxMenuBase_SendEvent" (self As wxMenuBase Ptr, itemid As wxInt, checked As wxInt) As wxBool

' class wxMenu
Declare Function wxMenu_ctor WXCALL Alias "wxMenu_ctor" (title As wxString Ptr, style As wxUInt) As wxMenu Ptr
Declare Function wxMenu_ctor2 WXCALL Alias "wxMenu_ctor2" (style As wxUInt) As wxMenu Ptr

#EndIf ' __menu_bi__


