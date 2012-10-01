#Ifndef __radiobutton_bi__
#Define __radiobutton_bi__

#Include Once "common.bi"

Declare Function wxRadioButton_ctor WXCALL Alias "wxRadioButton_ctor" () As wxRadioButton Ptr
Declare Function wxRadioButton_Create WXCALL Alias "wxRadioButton_Create" (self As wxRadioButton Ptr , _
                          parent    As wxWindow      Ptr     , _
                          id        As  wxWindowID            , _
                          labelArg  As wxString      Ptr     , _
                          x         As  wxInt             = -1, _
                          y         As  wxInt             = -1, _
                          w         As  wxInt             = -1, _
                          h         As  wxInt             = -1, _
                          style     As  wxUInt            =  0, _
                          validator As wxValidator   Ptr = WX_NULL, _
                          nameArg   As wxString      Ptr = WX_NULL) As wxBool
Declare Function wxRadioButton_GetValue WXCALL Alias "wxRadioButton_GetValue" (self As wxRadioButton Ptr) As wxBool
Declare Sub wxRadioButton_SetValue WXCALL Alias "wxRadioButton_SetValue" (self As wxRadioButton Ptr, state As wxBool)

#EndIf ' __radiobutton_bi__


