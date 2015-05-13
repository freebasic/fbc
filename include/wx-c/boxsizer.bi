#Ifndef __boxsizer_bi__
#Define __boxsizer_bi__

#Include Once "common.bi"

Type Virtual_voidvoid As Sub      WXCALL
Type Virtual_sizevoid As Function WXCALL As wxSize Ptr

' class wxBoxSizer
Declare Function wxBoxSizer_ctor WXCALL Alias "wxBoxSizer_ctor" (orient As wxInt) As wxBoxSizer Ptr
Declare Sub wxBoxSizer_RegisterVirtual WXCALL Alias "wxBoxSizer_RegisterVirtual" (self As wxBoxSizer Ptr, recalcSizes As Virtual_voidvoid)
Declare Sub wxBoxSizer_RegisterDisposable WXCALL Alias "wxBoxSizer_RegisterDisposable" (self As wxBoxSizer Ptr, on_dispose As Virtual_Dispose)
Declare Sub wxBoxSizer_RecalcSizes WXCALL Alias "wxBoxSizer_RecalcSizes" (self As wxBoxSizer Ptr)
Declare Function wxBoxSizer_GetOrientation WXCALL Alias "wxBoxSizer_GetOrientation" (self As wxBoxSizer Ptr) As wxInt
Declare Sub wxBoxSizer_SetOrientation WXCALL Alias "wxBoxSizer_SetOrientation" (self As wxBoxSizer Ptr, o As wxInt)

#EndIf ' __boxsizer_bi__

