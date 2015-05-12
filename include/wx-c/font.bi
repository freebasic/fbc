#Ifndef __font_bi__
#Define __font_bi__

#Include Once "common.bi"

Declare Function wxFont_NORMAL_FONT WXCALL Alias "wxFont_NORMAL_FONT" () As wxFont Ptr
Declare Function wxFont_SMALL_FONT WXCALL Alias "wxFont_SMALL_FONT" ()  As wxFont Ptr
Declare Function wxFont_ITALIC_FONT WXCALL Alias "wxFont_ITALIC_FONT" () As wxFont Ptr
Declare Function wxFont_SWISS_FONT WXCALL Alias "wxFont_SWISS_FONT" ()  As wxFont Ptr
Declare Function wxFont_ctorDef WXCALL Alias "wxFont_ctorDef" () As wxFont Ptr
Declare Function wxFont_ctor WXCALL Alias "wxFont_ctor" ( _
				 PointSize    As wxInt, _
                 Family       As wxInt, _
                 style        As wxInt, _
                 Weight       As wxInt, _
                 Underline    As wxBool , _
                 FaceNameArg  As wxString Ptr, _
                 FontEncoding As wxFontEncoding) As wxFont Ptr
Declare Sub wxFont_dtor WXCALL Alias "wxFont_dtor" (self As wxFont Ptr)
Declare Function wxFont_New WXCALL Alias "wxFont_New" (strNativeFontDesc As wxString Ptr) As wxFont Ptr
Declare Sub wxFont_Set WXCALL Alias "wxFont_Set" (self As wxFont Ptr, src As wxFont Ptr)
Declare Function wxFont_Ok WXCALL Alias "wxFont_Ok" (self As wxFont Ptr) As wxBool
Declare Function wxFont_IsFixedWidth WXCALL Alias "wxFont_IsFixedWidth" (self As wxFont Ptr) As wxBool
Declare Sub wxFont_SetPointSize WXCALL Alias "wxFont_SetPointSize" (self As wxFont Ptr, pointSize As wxInt)
Declare Function wxFont_GetPointSize WXCALL Alias "wxFont_GetPointSize" (self As wxFont Ptr) As wxInt
Declare Sub wxFont_SetFamily WXCALL Alias "wxFont_SetFamily" (self As wxFont Ptr, family As wxFontFamily)
Declare Function wxFont_GetFamily WXCALL Alias "wxFont_GetFamily" (self As wxFont Ptr) As wxFontFamily
Declare Sub wxFont_SetStyle WXCALL Alias "wxFont_SetStyle" (self As wxFont Ptr, style As wxInt)
Declare Function wxFont_GetStyle WXCALL Alias "wxFont_GetStyle" (self As wxFont Ptr) As wxInt
Declare Sub wxFont_SetWeight WXCALL Alias "wxFont_SetWeight" (self As wxFont Ptr, weight As wxInt)
Declare Function wxFont_GetWeight WXCALL Alias "wxFont_GetWeight" (self As wxFont Ptr) As wxInt
Declare Sub wxFont_SetUnderlined WXCALL Alias "wxFont_SetUnderlined" (self As wxFont Ptr, underlined As wxBool)
Declare Function wxFont_GetUnderlined WXCALL Alias "wxFont_GetUnderlined" (self As wxFont Ptr) As wxBool
Declare Sub wxFont_SetEncoding WXCALL Alias "wxFont_SetEncoding" (self As wxFont Ptr, enc As wxFontEncoding)
Declare Function wxFont_GetEncoding WXCALL Alias "wxFont_GetEncoding" (self As wxFont Ptr) As wxFontEncoding
Declare Sub wxFont_SetNoAntiAliasing WXCALL Alias "wxFont_SetNoAntiAliasing" (self As wxFont Ptr, no As wxBool)
Declare Function wxFont_GetNoAntiAliasing WXCALL Alias "wxFont_GetNoAntiAliasing" (self As wxFont Ptr) As wxBool
Declare Sub wxFont_SetDefaultEncoding WXCALL Alias "wxFont_SetDefaultEncoding" (enc As wxFontEncoding)
Declare Function wxFont_GetDefaultEncoding WXCALL Alias "wxFont_GetDefaultEncoding" () As wxFontEncoding
Declare Sub wxFont_SetNativeFontInfoUserDesc WXCALL Alias "wxFont_SetNativeFontInfoUserDesc" (self As wxFont Ptr, info As wxString Ptr)
Declare Function wxFont_GetNativeFontInfoDesc WXCALL Alias "wxFont_GetNativeFontInfoDesc" (self As wxFont Ptr) As wxString Ptr
Declare Sub wxFont_SetFaceName WXCALL Alias "wxFont_SetFaceName" (self As wxFont Ptr, faceName As wxString Ptr)
Declare Function wxFont_GetFaceName WXCALL Alias "wxFont_GetFaceName" (self As wxFont Ptr) As wxString Ptr
Declare Function wxFont_GetNativeFontInfo WXCALL Alias "wxFont_GetNativeFontInfo" (self As wxFont Ptr) As wxNativeFontInfo Ptr
Declare Function wxFont_GetNativeFontInfoUserDesc WXCALL Alias "wxFont_GetNativeFontInfoUserDesc" (self As wxFont Ptr) As wxString Ptr
Declare Function wxFont_GetFamilyString WXCALL Alias "wxFont_GetFamilyString" (self As wxFont Ptr) As wxString Ptr
Declare Function wxFont_GetStyleString WXCALL Alias "wxFont_GetStyleString" (self As wxFont Ptr) As wxString Ptr
Declare Function wxFont_GetWeightString WXCALL Alias "wxFont_GetWeightString" (self As wxFont Ptr) As wxString Ptr

#EndIf ' __font_bi__

