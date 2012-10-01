#Ifndef __staticbox_bi__
#Define __staticbox_bi__

#Include Once "common.bi"

Declare Function wxStaticBox_ctor WXCALL Alias "wxStaticBox_ctor" () As wxStaticBox Ptr
Declare Sub wxStaticBox_dtor WXCALL Alias "wxStaticBox_dtor" (self As wxStaticBox Ptr)
Declare Function wxStaticBox_Create WXCALL Alias "wxStaticBox_Create" (self As wxStaticBox Ptr, _
                        parent   As wxWindow    Ptr          , _
                        id       As  wxWindowID      = -1     , _
                        labelArg As wxString    Ptr = WX_NULL, _
                        x        As  wxInt           = -1     , _
                        y        As  wxInt           = -1     , _
                        w        As  wxInt           = -1     , _
                        h        As  wxInt           = -1     , _
                        style    As  wxUInt          =  0     , _
                        nameArg  As wxString    Ptr = WX_NULL) As wxBool

#EndIf ' __staticbox_bi__

