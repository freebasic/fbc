#Ifndef __accel_bi__
#Define __accel_bi__

#Include Once "common.bi"

Declare Function wxAcceleratorEntry_ctor WXCALL Alias "wxAcceleratorEntry_ctor" (flags As wxInt, keyCode As wxInt, cmd As wxInt, item As wxMenuItem Ptr) As wxAcceleratorEntry Ptr
Declare Sub wxAcceleratorEntry_dtor WXCALL Alias "wxAcceleratorEntry_dtor" (self As wxAcceleratorEntry Ptr)
Declare Sub wxAcceleratorEntry_Set WXCALL Alias "wxAcceleratorEntry_Set" (self As wxAcceleratorEntry Ptr, flags As wxInt, keyCode As wxInt, cmd As wxInt, item As wxMenuItem Ptr)
Declare Sub wxAcceleratorEntry_SetMenuItem WXCALL Alias "wxAcceleratorEntry_SetMenuItem" (self As wxAcceleratorEntry Ptr, item As wxMenuItem Ptr)
Declare Function wxAcceleratorEntry_GetFlags WXCALL Alias "wxAcceleratorEntry_GetFlags" (self As wxAcceleratorEntry Ptr) As wxInt
Declare Function wxAcceleratorEntry_GetKeyCode WXCALL Alias "wxAcceleratorEntry_GetKeyCode" (self As wxAcceleratorEntry Ptr) As wxInt
Declare Function wxAcceleratorEntry_GetCommand WXCALL Alias "wxAcceleratorEntry_GetCommand" (self As wxAcceleratorEntry Ptr) As wxInt
Declare Function wxAcceleratorEntry_GetMenuItem WXCALL Alias "wxAcceleratorEntry_GetMenuItem" (self As wxAcceleratorEntry Ptr) As wxMenuItem Ptr

' class wxAcceleratorTable
Declare Function wxAcceleratorTable_ctor WXCALL Alias "wxAcceleratorTable_ctor" () As wxAcceleratorTable Ptr
Declare Function wxAcceleratorTable_ctorWithEntries WXCALL Alias "wxAcceleratorTable_ctorWithEntries" (entries As wxAcceleratorArrayNet Ptr) As wxAcceleratorTable Ptr
Declare Function wxAcceleratorTable_Ok WXCALL Alias "wxAcceleratorTable_Ok" (self As wxAcceleratorTable Ptr) As wxBool

' class wxAcceleratorArrayNet
Declare Function wxAcceleratorArrayNet_ctor WXCALL Alias "wxAcceleratorArrayNet_ctor" (size As wxInt) As wxAcceleratorArrayNet Ptr
Declare Sub wxAcceleratorArrayNet_dtor WXCALL Alias "wxAcceleratorArrayNet_dtor" (self As wxAcceleratorArrayNet Ptr)
Declare Sub wxAcceleratorArrayNet_Set WXCALL Alias "wxAcceleratorArrayNet_Set" (self As wxAcceleratorArrayNet Ptr, iPos As wxInt, entry As wxAcceleratorEntry Ptr)

#EndIf ' __accel_bi__

