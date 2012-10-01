#Ifndef __radiobox_bi__
#Define __radiobox_bi__

#Include Once "common.bi"

Declare Function wxRadioBox_ctor WXCALL Alias "wxRadioBox_ctor" () As wxRadioBox Ptr
Declare Function wxRadioBox_Create WXCALL Alias "wxRadioBox_Create" (self As wxRadioBox Ptr, _
                       parent         As wxWindow      Ptr          , _
                       id             As  wxWindowID        = -1     , _
                       labelArg       As wxString      Ptr = WX_NULL, _
                       pos            As  wxPoint      Ptr     , _
                       size           As  wxSize       Ptr     , _
                       choices        As wxArrayString Ptr = WX_NULL, _
                       majorDimension As  wxInt             =  0     , _
                       style          As  wxUInt            =  0     , _
                       validator      As wxValidator   Ptr = WX_NULL, _
                       nameArg        As wxString      Ptr = WX_NULL) As wxBool
Declare Sub wxRadioBox_Enable WXCALL Alias "wxRadioBox_Enable" (self As wxRadioBox Ptr, n As wxInt, enable As wxBool)
Declare Function wxRadioBox_FindString WXCALL Alias "wxRadioBox_FindString" (self As wxRadioBox Ptr, findString As wxString Ptr) As wxInt
Declare Function wxRadioBox_GetLabel WXCALL Alias "wxRadioBox_GetLabel" (self As wxRadioBox Ptr) As wxString Ptr
Declare Function wxRadioBox_GetSelection WXCALL Alias "wxRadioBox_GetSelection" (self As wxRadioBox Ptr) As wxInt
Declare Function wxRadioBox_GetStringSelection WXCALL Alias "wxRadioBox_GetStringSelection" (self As wxRadioBox Ptr) As wxString Ptr
Declare Function wxRadioBox_GetString WXCALL Alias "wxRadioBox_GetString" (self As wxRadioBox Ptr, n As wxInt) As wxString Ptr
Declare Sub wxRadioBox_SetLabel WXCALL Alias "wxRadioBox_SetLabel" (self As wxRadioBox Ptr, label As wxString Ptr)
Declare Sub wxRadioBox_SetSelection WXCALL Alias "wxRadioBox_SetSelection" (self As wxRadioBox Ptr, item As wxInt)
Declare Sub wxRadioBox_SetStringSelection WXCALL Alias "wxRadioBox_SetStringSelection" (self As wxRadioBox Ptr, findString As wxString Ptr)
Declare Sub wxRadioBox_Show WXCALL Alias "wxRadioBox_Show" (self As wxRadioBox Ptr, n As wxInt, show As wxBool)
Declare Function wxRadioBox_GetCount WXCALL Alias "wxRadioBox_GetCount" (self As wxRadioBox Ptr) As wxInt

#EndIf

