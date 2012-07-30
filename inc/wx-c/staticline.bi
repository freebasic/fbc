#Ifndef __staticline_bi__
#Define __staticline_bi__

#Include Once "common.bi"

Declare Function wxStaticLine_ctor WXCALL Alias "wxStaticLine_ctor" () As wxStaticLine Ptr
Declare Function wxStaticLine_Create WXCALL Alias "wxStaticLine_Create" (self As wxStaticLine Ptr, _
                         parent  As wxWindow     Ptr     , _
                         id      As  wxWindowID       = -1, _
                         x       As  wxInt            = -1, _
                         y       As  wxInt            = -1, _
                         w       As  wxInt            = -1, _
                         h       As  wxInt            = -1, _
                         style   As  wxUInt           =  0, _
                         nameArg As wxString     Ptr = WX_NULL) As wxBool
Declare Function wxStaticLine_IsVertical WXCALL Alias "wxStaticLine_IsVertical" (self As wxStaticLine Ptr) As wxBool
Declare Function wxStaticLine_GetDefaultSize WXCALL Alias "wxStaticLine_GetDefaultSize" (self As wxStaticLine Ptr) As wxInt

#EndIf ' __staticline_bi__

