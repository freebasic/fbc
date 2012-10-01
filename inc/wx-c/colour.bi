#Ifndef __colour_bi__
#Define __colour_bi__

#Include Once "common.bi"

Declare Function wxColour_ctor WXCALL Alias "wxColour_ctor" () As wxColour Ptr
Declare Sub wxColour_dtor WXCALL Alias "wxColour_dtor" (self As wxColour Ptr)
Declare Function wxColour_ctorByName WXCALL Alias "wxColour_ctorByName" (nam As wxString Ptr) As wxColour Ptr
Declare Function wxColour_ctorByParts WXCALL Alias "wxColour_ctorByParts" (r As wxChar, g As wxChar, b As wxChar) As wxColour Ptr
Declare Function wxColour_ctorByPartsWithAlpha WXCALL Alias "wxColour_ctorByPartsWithAlpha" (r As wxChar, g As wxChar, b As wxChar, a As wxChar) As wxColour Ptr
Declare Function wxColour_Blue WXCALL Alias "wxColour_Blue" (self As wxColour Ptr) As wxChar
Declare Function wxColour_Red WXCALL Alias "wxColour_Red" (self As wxColour Ptr) As wxChar
Declare Function wxColour_Green WXCALL Alias "wxColour_Green" (self As wxColour Ptr) As wxChar
Declare Function wxColour_Alpha WXCALL Alias "wxColour_Alpha" (self As wxColour Ptr) As wxChar
Declare Function wxColour_Ok WXCALL Alias "wxColour_Ok" (self As wxColour Ptr) As wxBool
Declare Sub wxColour_Set WXCALL Alias "wxColour_Set" (self As wxColour Ptr, r As wxChar, g As wxChar, b As wxChar, a As wxChar)
Declare Sub wxColour_SetFromString WXCALL Alias "wxColour_SetFromString" (self As wxColour Ptr, desc As wxString Ptr)
Declare Sub wxColour_SetFromColour WXCALL Alias "wxColour_SetFromColour" (self As wxColour Ptr, src As wxColour Ptr)
Declare Function wxColour_GetAsString WXCALL Alias "wxColour_GetAsString" (self As wxColour Ptr, flags As wxInt = wxC2S_HTML_SYNTAX) As wxString Ptr

#EndIf

