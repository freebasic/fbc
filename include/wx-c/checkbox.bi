#Ifndef __checkbox_bi__
#Define __checkbox_bi__

#Include Once "common.bi"

' class wxCheckbox
Declare Function wxCheckBox_ctor WXCALL Alias "wxCheckBox_ctor" () As wxCheckBox Ptr
Declare Function wxCheckBox_Create WXCALL Alias "wxCheckBox_Create" ( _
										 self      As wxCheckBox  Ptr          , _
                                         parent    As wxWindow    Ptr          , _
                                         id        As  wxWindowID      = -1     , _
                                         labelArg  As wxString    Ptr = WX_NULL, _
                                         x         As  wxInt           = -1     , _
                                         y         As  wxInt           = -1     , _
                                         w         As  wxInt           = -1     , _
                                         h         As  wxInt           = -1     , _
                                         style     As  wxUInt          =  0     , _
                                         validator As wxValidator Ptr = WX_NULL, _
                                         nameArg   As wxString    Ptr = WX_NULL) As wxBool
Declare Sub wxCheckBox_SetValue WXCALL Alias "wxCheckBox_SetValue" (self As wxCheckBox Ptr, state As wxBool)
Declare Function wxCheckBox_GetValue WXCALL Alias "wxCheckBox_GetValue" (self As wxCheckBox Ptr) As wxBool
Declare Function wxCheckBox_IsChecked WXCALL Alias "wxCheckBox_IsChecked" (self As wxCheckBox Ptr) As wxBool
Declare Sub wxCheckBox_Set3StateValue WXCALL Alias "wxCheckBox_Set3StateValue" (self As wxCheckBox Ptr, state As wxCheckBoxState)
Declare Function wxCheckBox_Get3StateValue WXCALL Alias "wxCheckBox_Get3StateValue" (self As wxCheckBox Ptr) As wxCheckBoxState
Declare Function wxCheckBox_Is3State WXCALL Alias "wxCheckBox_Is3State" (self As wxCheckBox Ptr) As wxBool
Declare Function wxCheckBox_Is3rdStateAllowedForUser WXCALL Alias "wxCheckBox_Is3rdStateAllowedForUser" (self As wxCheckBox Ptr) As wxBool

#EndIf ' __checkbox_bi__


