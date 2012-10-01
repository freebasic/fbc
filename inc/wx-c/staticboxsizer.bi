#Ifndef __staticboxsizer_bi__
#Define __staticboxsizer_bi__

#Include Once "common.bi"

Declare Function wxStaticBoxSizer_ctor WXCALL Alias "wxStaticBoxSizer_ctor" (box As wxStaticBox Ptr, orient As wxInt) As wxStaticBoxSizer Ptr
Declare Function wxStaticBoxSizer_ctor2 WXCALL Alias "wxStaticBoxSizer_ctor2" (orient As wxInt, parent As wxWindow Ptr, label As wxString Ptr) As wxStaticBoxSizer Ptr
Declare Function wxStaticBoxSizer_GetStaticBox WXCALL Alias "wxStaticBoxSizer_GetStaticBox" (self As wxStaticBoxSizer Ptr) As wxStaticBox Ptr


#EndIf ' __staticboxsizer_bi__

