#Ifndef __combobox_bi__
#Define __combobox_bi__

#Include Once "common.bi"

Declare Function wxComboBox_ctor WXCALL Alias "wxComboBox_ctor" () As wxComboBox Ptr
Declare Function wxComboBox_Create WXCALL Alias "wxComboBox_Create" ( _
					   self      As wxComboBox    Ptr     , _
                       parent    As wxWindow      Ptr     , _
                       id        As  wxWindowID        = -1, _
                       value     As wxString      Ptr     , _
                       pos       As  wxPoint      Ptr     , _
                       size      As  wxSize       Ptr     , _
                       pChoices  As wxArrayString Ptr     , _
                       style     As  wxUInt            =  0, _
                       validator As wxValidator   Ptr = WX_NULL, _
                       nameArg   As wxString      Ptr = WX_NULL) As wxBool
Declare Sub wxComboBox_Copy WXCALL Alias "wxComboBox_Copy" (self As wxComboBox Ptr)
Declare Sub wxComboBox_Cut WXCALL Alias "wxComboBox_Cut" (self As wxComboBox Ptr)
Declare Sub wxComboBox_Paste WXCALL Alias "wxComboBox_Paste" (self As wxComboBox Ptr)
Declare Sub wxComboBox_SetInsertionPoint WXCALL Alias "wxComboBox_SetInsertionPoint" (self As wxComboBox Ptr, ip As wxInt)
Declare Function wxComboBox_GetInsertionPoint WXCALL Alias "wxComboBox_GetInsertionPoint" (self As wxComboBox Ptr) As wxInt
Declare Function wxComboBox_GetLastPosition WXCALL Alias "wxComboBox_GetLastPosition" (self As wxComboBox Ptr) As wxInt
Declare Sub wxComboBox_Replace WXCALL Alias "wxComboBox_Replace" (self As wxComboBox Ptr, from As wxInt, to_ As wxInt, value As wxString Ptr)
Declare Sub wxComboBox_SetSelection WXCALL Alias "wxComboBox_SetSelection" (self As wxComboBox Ptr, from As wxInt, to_ As wxInt)
Declare Sub wxComboBox_SetEditable WXCALL Alias "wxComboBox_SetEditable" (self As wxComboBox Ptr, editable As wxBool)
Declare Sub wxComboBox_SetInsertionPointEnd WXCALL Alias "wxComboBox_SetInsertionPointEnd" (self As wxComboBox Ptr)
Declare Sub wxComboBox_Remove WXCALL Alias "wxComboBox_Remove" (self As wxComboBox Ptr, from As wxInt, to_ As wxInt)
Declare Sub wxComboBox_SetValue WXCALL Alias "wxComboBox_SetValue" (self As wxComboBox Ptr, txt As wxString Ptr)
Declare Function wxComboBox_GetValue WXCALL Alias "wxComboBox_GetValue" (self As wxComboBox Ptr) As wxString Ptr
Declare Sub wxComboBox_Select WXCALL Alias "wxComboBox_Select" (self As wxComboBox Ptr, n As wxInt)

#EndIf

