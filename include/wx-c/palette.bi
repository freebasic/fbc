#Ifndef __palette_bi__
#Define __palette_bi__

#Include Once "common.bi"

Declare Function wxPalette_ctor WXCALL Alias "wxPalette_ctor" () As wxPalette Ptr
Declare Sub wxPalette_dtor WXCALL Alias "wxPalette_dtor" (self As wxPalette Ptr)
Declare Function wxPalette_Ok WXCALL Alias "wxPalette_Ok" (self As wxPalette Ptr) As wxBool
Declare Function wxPalette_Create WXCALL Alias "wxPalette_Create" (self As wxPalette Ptr, n As wxInt, r As wxChar Ptr, g As wxChar Ptr, b As wxChar Ptr) As wxBool
Declare Function wxPalette_GetPixel WXCALL Alias "wxPalette_GetPixel" (self As wxPalette Ptr, r As wxChar, g As wxChar, b As wxChar) As wxInt
Declare Function wxPalette_GetRGB WXCALL Alias "wxPalette_GetRGB" (self As wxPalette Ptr, pixel As wxInt, r As wxChar Ptr, g As wxChar Ptr, b As wxChar Ptr) As wxBool

#EndIf ' __palette_bi__

