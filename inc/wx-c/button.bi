#Ifndef __button_bi__
#Define __button_bi__

#Include Once "common.bi"

' class wxButton
Declare Sub wxButton_GetDefaultSize WXCALL Alias "wxButton_GetDefaultSize" (size As wxSize Ptr)
Declare Function wxButton_ctor WXCALL Alias "wxButton_ctor" () As wxButton Ptr
Declare Function wxButton_Create WXCALL Alias "wxButton_Create" ( _
							  self      As wxButton    Ptr          , _
                              parent    As wxWindow    Ptr          , _
                              id        As  wxInt           = -1     , _
                              labelArg  As wxString    Ptr = WX_NULL, _
                              x         As  wxInt           = -1     , _
                              y         As  wxInt           = -1     , _
                              w         As  wxInt           = -1     , _
                              h         As  wxInt           = -1     , _
                              style     As  wxInt           =  0     , _
                              validator As wxValidator Ptr = WX_NULL, _
                              nameArg   As wxString    Ptr = WX_NULL) As wxBool
Declare Sub wxButton_SetDefault WXCALL Alias "wxButton_SetDefault" (self As wxButton Ptr)
Declare Sub wxButton_SetImageLabel WXCALL Alias "wxButton_SetImageLabel" (self As wxButton Ptr, bitmap As wxBitmap Ptr)
Declare Sub wxButton_SetImageMargins WXCALL Alias "wxButton_SetImageMargins" (self As wxButton Ptr, x As wxCoord, y As wxCoord)
Declare Sub wxButton_SetLabel WXCALL Alias "wxButton_SetLabel" (self As wxButton Ptr, label As wxString Ptr)
Declare Function wxButton_GetLabel WXCALL Alias "wxButton_GetLabel" (self As wxButton Ptr) As wxString Ptr

#EndIf ' __button_bi__

