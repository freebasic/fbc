#Ifndef __picker_bi__
#Define __picker_bi__

#Include Once "common.bi"

' class wxDatePickerCtrl
Declare Function wxDatePickerCtrl_DefaultCTor WXCALL Alias "wxDatePickerCtrl_DefaultCTor" () As wxDatePickerCtrl Ptr
Declare Function wxDatePickerCtrl_CTor WXCALL Alias "wxDatePickerCtrl_CTor" (parent As wxWindow Ptr, _
                           id      As  wxWindowID     = -1     , _
                           dtArg   As wxDateTime Ptr = WX_NULL, _
                           x       As  wxInt          = -1     , _
                           y       As  wxInt          = -1     , _
                           w       As  wxInt          = -1     , _
                           h       As  wxInt          = -1     , _
                           style   As  wxUInt         =  0     , _
                           nameArg As wxString   Ptr = WX_NULL) As wxDatePickerCtrl Ptr
Declare Sub wxDatePickerCtrl_DTor WXCALL Alias "wxDatePickerCtrl_DTor" (self As wxDatePickerCtrl Ptr)
Declare Sub wxDatePickerCtrl_Create WXCALL Alias "wxDatePickerCtrl_Create" (self As wxDatePickerCtrl Ptr, _
                             parent  As wxWindow   Ptr          , _
                             id      As  wxWindowID     = -1     , _
                             dtArg   As wxDateTime Ptr = WX_NULL, _
                             x       As  wxInt          = -1     , _
                             y       As  wxInt          = -1     , _
                             w       As  wxInt          = -1     , _
                             h       As  wxInt          = -1     , _
                             style   As  wxUInt         =  0     , _
                             nameArg As wxString   Ptr = WX_NULL)
Declare Sub wxDatePickerCtrl_SetValue WXCALL Alias "wxDatePickerCtrl_SetValue" (self As wxDatePickerCtrl Ptr, dt As wxDateTime Ptr)
Declare Function wxDatePickerCtrl_GetValue WXCALL Alias "wxDatePickerCtrl_GetValue" (self As wxDatePickerCtrl Ptr) As wxDatetime Ptr
Declare Sub wxDatePickerCtrl_SetRange WXCALL Alias "wxDatePickerCtrl_SetRange" (self As wxDatePickerCtrl Ptr, dt1 As wxDateTime Ptr, dt2 As wxDateTime Ptr)
Declare Function wxDatePickerCtrl_GetRange WXCALL Alias "wxDatePickerCtrl_GetRange" (self As wxDatePickerCtrl Ptr, dt1 As wxDateTime Ptr, dt2 As wxDateTime Ptr) As wxBool

' class wxColourPickerCtrl
Declare Function wxColourPickerCtrl_DefaultCTor WXCALL Alias "wxColourPickerCtrl_DefaultCTor" () As wxColourPickerCtrl Ptr
Declare Function wxColourPickerCtrl_CTor WXCALL Alias "wxColourPickerCtrl_CTor" (parent As wxWindow Ptr, _
                             id      As  wxWindowID   = -1     , _
                             colArg  As wxColour Ptr = WX_NULL, _
                             x       As  wxInt        = -1     , _
                             y       As  wxInt        = -1     , _
                             w       As  wxInt        = -1     , _
                             h       As  wxInt        = -1     , _
                             style   As  wxUInt       =  0     , _
                             nameArg As wxString Ptr = WX_NULL) As wxColourPickerCtrl Ptr
Declare Sub wxColourPickerCtrl_Create WXCALL Alias "wxColourPickerCtrl_Create" (self As wxColourPickerCtrl Ptr, _
                               parent  As wxWindow Ptr          , _
                               id      As  wxWindowID   = -1     , _
                               colArg  As wxColour Ptr = WX_NULL, _
                               x       As  wxInt        = -1     , _
                               y       As  wxInt        = -1     , _
                               w       As  wxInt        = -1     , _
                               h       As  wxInt        = -1     , _
                               style   As  wxUInt       =  0     , _
                               nameArg As wxString Ptr = WX_NULL)
Declare Function wxColourPickerCtrl_GetColour WXCALL Alias "wxColourPickerCtrl_GetColour" (self As wxColourPickerCtrl Ptr) As wxColour Ptr
Declare Sub wxColourPickerCtrl_SetColour WXCALL Alias "wxColourPickerCtrl_SetColour" (self As wxColourPickerCtrl Ptr, col As wxColour Ptr)
Declare Sub wxColourPickerCtrl_SetColourFromString WXCALL Alias "wxColourPickerCtrl_SetColourFromString" (self As wxColourPickerCtrl Ptr, col As wxColour Ptr)
Declare Function wxColourPickerEvent_GetColour WXCALL Alias "wxColourPickerEvent_GetColour" (self As wxColourPickerEvent Ptr) As wxColour Ptr
Declare Sub wxColourPickerEvent_SetColour WXCALL Alias "wxColourPickerEvent_SetColour" (self As wxColourPickerEvent Ptr, col As wxColour Ptr)

' class wxFontPickerCtrl
Declare Function wxFontPickerCtrl_DefaultCTor WXCALL Alias "wxFontPickerCtrl_DefaultCTor" () As wxFontPickerCtrl Ptr
Declare Function wxFontPickerCtrl_CTor WXCALL Alias "wxFontPickerCtrl_CTor" (parent As wxWindow Ptr, _
                           id      As  wxWindowID   = -1     , _
                           fontArg As wxFont   Ptr = WX_NULL, _
                           x       As  wxInt        = -1     , _
                           y       As  wxInt        = -1     , _
                           w       As  wxInt        = -1     , _
                           h       As  wxInt        = -1     , _
                           style   As  wxUInt       =  0     , _
                           nameArg As wxString Ptr = WX_NULL) As wxFontPickerCtrl Ptr
Declare Sub wxFontPickerCtrl_Create WXCALL Alias "wxFontPickerCtrl_Create" (self As wxFontPickerCtrl Ptr, _
                             parent  As wxWindow Ptr          , _
                             id      As  wxWindowID   = -1     , _
                             fontArg As wxFont   Ptr = WX_NULL, _
                             x       As  wxInt        = -1     , _
                             y       As  wxInt        = -1     , _
                             w       As  wxInt        = -1     , _
                             h       As  wxInt        = -1     , _
                             style   As  wxUInt       =  0     , _
                             nameArg As wxString Ptr = WX_NULL)
Declare Function wxFontPickerCtrl_GetSelectedFont WXCALL Alias "wxFontPickerCtrl_GetSelectedFont" (self As wxFontPickerCtrl Ptr) As wxFont Ptr
Declare Sub wxFontPickerCtrl_SetSelectedFont WXCALL Alias "wxFontPickerCtrl_SetSelectedFont" (self As wxFontPickerCtrl Ptr, font As wxFont Ptr)
Declare Sub wxFontPickerCtrl_SetMaxPointSize WXCALL Alias "wxFontPickerCtrl_SetMaxPointSize" (self As wxFontPickerCtrl Ptr, maxPointSize As wxInt)
Declare Function wxFontPickerCtrl_GetMaxPointSize WXCALL Alias "wxFontPickerCtrl_GetMaxPointSize" (self As wxFontPickerCtrl Ptr) As wxInt
Declare Function wxFontPickerEvent_GetFont WXCALL Alias "wxFontPickerEvent_GetFont" (self As wxFontPickerEvent Ptr) As wxFont Ptr
Declare Sub wxFontPickerEvent_SetFont WXCALL Alias "wxFontPickerEvent_SetFont" (self As wxFontPickerEvent Ptr, font As wxFont Ptr)

' wxPickerBase
Declare Sub wxPickerBase_SetInternalMargin WXCALL Alias "wxPickerBase_SetInternalMargin" (self As wxPickerBase Ptr, margin As wxInt)
Declare Function wxPickerBase_GetInternalMargin WXCALL Alias "wxPickerBase_GetInternalMargin" (self As wxPickerBase Ptr) As wxInt
Declare Sub wxPickerBase_SetTextCtrlProportion WXCALL Alias "wxPickerBase_SetTextCtrlProportion" (self As wxPickerBase Ptr, prop As wxInt)
Declare Sub wxPickerBase_SetPickerCtrlProportion WXCALL Alias "wxPickerBase_SetPickerCtrlProportion" (self As wxPickerBase Ptr, prop As wxInt)
Declare Function wxPickerBase_GetTextCtrlProportion WXCALL Alias "wxPickerBase_GetTextCtrlProportion" (self As wxPickerBase Ptr) As wxInt
Declare Function wxPickerBase_GetPickerCtrlProportion WXCALL Alias "wxPickerBase_GetPickerCtrlProportion" (self As wxPickerBase Ptr) As wxInt
Declare Function wxPickerBase_HasTextCtrl WXCALL Alias "wxPickerBase_HasTextCtrl" (self As wxPickerBase Ptr) As wxBool
Declare Function wxPickerBase_GetTextCtrl WXCALL Alias "wxPickerBase_GetTextCtrl" (self As wxPickerBase Ptr) As wxTextCtrl Ptr
Declare Function wxPickerBase_IsTextCtrlGrowable WXCALL Alias "wxPickerBase_IsTextCtrlGrowable" (self As wxPickerBase Ptr) As wxBool
Declare Sub wxPickerBase_SetPickerCtrlGrowable WXCALL Alias "wxPickerBase_SetPickerCtrlGrowable" (self As wxPickerBase Ptr, grow As wxBool)
Declare Sub wxPickerBase_SetTextCtrlGrowable WXCALL Alias "wxPickerBase_SetTextCtrlGrowable" (self As wxPickerBase Ptr, grow As wxBool)
Declare Function wxPickerBase_IsPickerCtrlGrowable WXCALL Alias "wxPickerBase_IsPickerCtrlGrowable" (self As wxPickerBase Ptr) As wxBool

#EndIf ' __picker_bi__

