#Ifndef __htmlhelpctrl_bi__
#Define __htmlhelpctrl_bi__

#Include Once "common.bi"

Declare Function wxHtmlHelpController_ctor WXCALL Alias "wxHtmlHelpController_ctor" (style As wxUInt) As wxHtmlHelpController Ptr
Declare Sub wxHtmlHelpController_SetTitleFormat WXCALL Alias "wxHtmlHelpController_SetTitleFormat" (self As wxHtmlHelpController Ptr, fmt As wxString Ptr)
Declare Sub wxHtmlHelpController_SetTempDir WXCALL Alias "wxHtmlHelpController_SetTempDir" (self As wxHtmlHelpController Ptr, path As wxString Ptr)
Declare Function wxHtmlHelpController_AddBook WXCALL Alias "wxHtmlHelpController_AddBook" (self As wxHtmlHelpController Ptr, book_url As wxString Ptr) As wxBool
Declare Function wxHtmlHelpController_Display WXCALL Alias "wxHtmlHelpController_Display" (self As wxHtmlHelpController Ptr, x As wxString Ptr) As wxBool
Declare Function wxHtmlHelpController_DisplayInt WXCALL Alias "wxHtmlHelpController_DisplayInt" (self As wxHtmlHelpController Ptr, id As wxInt) As wxBool
Declare Function wxHtmlHelpController_DisplayContents WXCALL Alias "wxHtmlHelpController_DisplayContents" (self As wxHtmlHelpController Ptr) As wxBool
Declare Function wxHtmlHelpController_DisplayIndex WXCALL Alias "wxHtmlHelpController_DisplayIndex" (self As wxHtmlHelpController Ptr) As wxBool
Declare Function wxHtmlHelpController_KeywordSearch WXCALL Alias "wxHtmlHelpController_KeywordSearch" (self As wxHtmlHelpController Ptr, keyword As wxString Ptr, mode As wxHelpSearchMode) As wxBool
Declare Sub wxHtmlHelpController_UseConfig WXCALL Alias "wxHtmlHelpController_UseConfig" (self As wxHtmlHelpController Ptr, cfg As wxConfigBase Ptr, rootpath As wxString Ptr)
Declare Sub wxHtmlHelpController_ReadCustomization WXCALL Alias "wxHtmlHelpController_ReadCustomization" (self As wxHtmlHelpController Ptr, cfg As wxConfigBase Ptr, path As wxString Ptr)
Declare Sub wxHtmlHelpController_WriteCustomization WXCALL Alias "wxHtmlHelpController_WriteCustomization" (self As wxHtmlHelpController Ptr, cfg As wxConfigBase Ptr, path As wxString Ptr)

' class wxHtmlHelpFrame
Declare Function wxHtmlHelpController_GetFrame WXCALL Alias "wxHtmlHelpController_GetFrame" (self As wxHtmlHelpController Ptr) As wxHtmlHelpFrame Ptr 
Declare Sub wxHtmlHelpController_OnCloseFrame WXCALL Alias "wxHtmlHelpController_OnCloseFrame" (self As wxHtmlHelpController Ptr, closeEvent As wxCloseEvent Ptr)

#EndIf ' __htmlhelpctrl_bi__


