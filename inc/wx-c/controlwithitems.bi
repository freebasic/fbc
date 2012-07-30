#Ifndef __controlwithitems_bi__
#Define __controlwithitems_bi__

#Include Once "common.bi"

Declare Sub wxControlWithItems_SetString WXCALL Alias "wxControlWithItems_SetString" (self As wxControlWithItems Ptr, n As wxInt, txt As wxString Ptr)
Declare Function wxControlWithItems_GetString WXCALL Alias "wxControlWithItems_GetString" (self As wxControlWithItems Ptr, n As wxInt) As wxString Ptr
Declare Function wxComboBox_SetStringSelection WXCALL Alias "wxComboBox_SetStringSelection" (self As wxComboBox Ptr, stringSelection As wxString Ptr) As wxBool
Declare Function wxControlWithItems_GetStringSelection WXCALL Alias "wxControlWithItems_GetStringSelection" (self As wxControlWithItems Ptr) As wxString Ptr
Declare Sub wxControlWithItems_SetClientData WXCALL Alias "wxControlWithItems_SetClientData" (self As wxControlWithItems Ptr, n As wxInt, pData As Any Ptr)
Declare Function wxControlWithItems_GetClientData WXCALL Alias "wxControlWithItems_GetClientData" (self As wxControlWithItems Ptr, n As wxInt) As Any Ptr
Declare Sub wxControlWithItems_SetSelection WXCALL Alias "wxControlWithItems_SetSelection" (self As wxControlWithItems Ptr, n As wxInt)
Declare Function wxControlWithItems_GetSelection WXCALL Alias "wxControlWithItems_GetSelection" (self As wxControlWithItems Ptr) As wxInt
Declare Sub wxControlWithItems_SetClientObject WXCALL Alias "wxControlWithItems_SetClientObject" (self As wxControlWithItems Ptr, n As wxInt, pClientData As wxClientData Ptr)
Declare Function wxControlWithItems_GetClientObject WXCALL Alias "wxControlWithItems_GetClientObject" (self As wxControlWithItems Ptr, n As wxInt) As wxClientData Ptr
Declare Function wxControlWithItems_Append WXCALL Alias "wxControlWithItems_Append" (self As wxControlWithItems Ptr, Item As wxString Ptr) As wxInt
Declare Function wxControlWithItems_Insert WXCALL Alias "wxControlWithItems_Insert" (self As wxControlWithItems Ptr, Item As wxString Ptr, position As wxInt) As wxInt
Declare Function wxControlWithItems_AppendWithData WXCALL Alias "wxControlWithItems_AppendWithData" (self As wxControlWithItems Ptr, Item As wxString Ptr,                    pClientData As wxClientData Ptr) As wxInt
Declare Function wxControlWithItems_InsertWithData WXCALL Alias "wxControlWithItems_InsertWithData" (self As wxControlWithItems Ptr, Item As wxString Ptr, position As wxInt, pClientData As wxClientData Ptr) As wxInt
Declare Function wxControlWithItems_GetCount WXCALL Alias "wxControlWithItems_GetCount" (self As wxControlWithItems Ptr) As wxInt
Declare Function wxControlWithItems_FindString WXCALL Alias "wxControlWithItems_FindString" (self As wxControlWithItems Ptr, findString As wxString Ptr) As wxInt
Declare Sub wxControlWithItems_Delete WXCALL Alias "wxControlWithItems_Delete" (self As wxControlWithItems Ptr, n As wxInt)
Declare Sub wxControlWithItems_Clear WXCALL Alias "wxControlWithItems_Clear" (self As wxControlWithItems Ptr)
Declare Function wxControlWithItems_GetStrings WXCALL Alias "wxControlWithItems_GetStrings" (self As wxControlWithItems Ptr) As wxArrayString Ptr
Declare Function wxControlWithItems_HasClientObjectData WXCALL Alias "wxControlWithItems_HasClientObjectData" (self As wxControlWithItems Ptr) As wxBool
Declare Function wxControlWithItems_HasClientUntypedData WXCALL Alias "wxControlWithItems_HasClientUntypedData" (self As wxControlWithItems Ptr) As wxBool
Declare Function wxControlWithItems_SetStringSelection WXCALL Alias "wxControlWithItems_SetStringSelection" (self As wxControlWithItems Ptr, StringSel As wxString Ptr) As wxBool
Declare Sub wxControlWithItems_Command WXCALL Alias "wxControlWithItems_Command" (self As wxControlWithItems Ptr, cmdEvent As wxCommandEvent Ptr)
Declare Sub wxControlWithItems_Select WXCALL Alias "wxControlWithItems_Select" (self As wxControlWithItems Ptr, n As wxInt)
Declare Function wxControlWithItems_ShouldInheritColours WXCALL Alias "wxControlWithItems_ShouldInheritColours" (self As wxControlWithItems Ptr) As wxBool
Declare Function wxControlWithItems_IsEmpty WXCALL Alias "wxControlWithItems_IsEmpty" (self As wxControlWithItems Ptr) As wxBool

#EndIf ' __controlwithitems_bi__

