#Ifndef __statictext_bi__
#Define __statictext_bi__

#Include Once "common.bi"

Declare Function wxStaticText_ctor WXCALL Alias "wxStaticText_ctor" () As wxStaticText Ptr
Declare Function wxStaticText_Create WXCALL Alias "wxStaticText_Create" (self As wxStaticText Ptr, _
                         parent   As wxWindow     Ptr          , _
                         id       As  wxWindowID       = -1     , _
                         labelArg As wxString     Ptr = WX_NULL, _
                         x        As  wxInt            = -1     , _
                         y        As  wxInt            = -1     , _
                         w        As  wxInt            = -1     , _
                         h        As  wxInt            = -1     , _
                         style    As  wxUInt           =  0     , _
                         nameArg  As wxString     Ptr = WX_NULL) As wxBool

#EndIf '  __statictext_bi__

