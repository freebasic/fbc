#Ifndef __icon_bi__
#Define __icon_bi__

#Include Once "common.bi"

Declare Function wxIcon_ctor WXCALL Alias "wxIcon_ctor" () As wxIcon Ptr
Declare Sub wxIcon_CopyFromBitmap WXCALL Alias "wxIcon_CopyFromBitmap" (self As wxIcon Ptr, bitmap As wxBitmap Ptr)
Declare Function wxIcon_LoadFile WXCALL Alias "wxIcon_LoadFile" (self As wxIcon Ptr, filename As wxString Ptr, typ As wxBitmapType) As wxBool

#EndIf ' __icon_bi__

