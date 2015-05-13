#Ifndef __togglebutton_bi__
#Define __togglebutton_bi__

#Include Once "common.bi"

Declare Function wxToggleButton_ctor WXCALL Alias "wxToggleButton_ctor" () As wxToggleButton Ptr
Declare Function wxToggleButton_Create WXCALL Alias "wxToggleButton_Create" ( _
						   self      As wxToggleButton Ptr          , _
                           parent    As wxWindow       Ptr          ,_
                           id        As  wxWindowID         = - 1    , _
                           labelArg  As wxString       Ptr = WX_NULL, _
                           x         As  wxInt              = -1     , _
                           y         As  wxInt              = -1     , _
                           w         As  wxInt              = -1     , _
                           h         As  wxInt              = -1     , _
                           style     As  wxUInt             =  0     , _
                           validator As wxValidator    Ptr = WX_NULL, _
                           nameArg   As wxString       Ptr = WX_NULL) As wxBool
Declare Function wxToggleButton_GetValue WXCALL Alias "wxToggleButton_GetValue" (self As wxToggleButton Ptr) As wxBool
Declare Sub wxToggleButton_SetValue WXCALL Alias "wxToggleButton_SetValue" (self As wxToggleButton Ptr, state As wxBool)

#EndIf ' __togglebutton_bi__

