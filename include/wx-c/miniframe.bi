#Ifndef __miniframe_bi__
#Define __miniframe_bi__

#Include Once "common.bi"

Declare Function wxMiniFrame_ctor WXCALL Alias "wxMiniFrame_ctor" () As wxMiniFrame Ptr
Declare Function wxMiniFrame_Create WXCALL Alias "wxMiniFrame_Create" (self As wxMiniFrame Ptr, _
                        parent   As wxWindow    Ptr = WX_NULL, _
                        id       As  wxWindowID      = -1     , _
                        titleArg As wxString    Ptr = WX_NULL, _
                        x        As  wxInt           = -1     , _
                        y        As  wxInt           = -1     , _
                        w        As  wxInt           = -1     , _
                        h        As  wxInt           = -1     , _
                        style    As  wxUInt          =  0     , _
                        nameArg  As wxString    Ptr = WX_NULL) As wxBool

#EndIf ' __miniframe_bi__

