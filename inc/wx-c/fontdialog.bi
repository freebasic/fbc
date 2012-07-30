#Ifndef __fontdialog_bi__
#Define __fontdialog_bi__

#Include Once "common.bi"

' class wxFontDialog
Declare Function wxFontDialog_ctor WXCALL Alias "wxFontDialog_ctor" () As wxFontDialog Ptr
Declare Function wxFontDialog_Create WXCALL Alias "wxFontDialog_Create" (self As wxFontDialog Ptr, parent As wxWindow Ptr, pData As wxFontData Ptr) As wxBool
Declare Sub wxFontDialog_dtor WXCALL Alias "wxFontDialog_dtor" (self As wxFontDialog Ptr)
Declare Function wxFontDialog_ShowModal WXCALL Alias "wxFontDialog_ShowModal" (self As wxFontDialog Ptr) As wxInt
Declare Function wxFontDialog_GetFontData WXCALL Alias "wxFontDialog_GetFontData" (self As wxFontDialog Ptr) As wxFontData Ptr

' class wxFontData
Declare Function wxFontData_ctor WXCALL Alias "wxFontData_ctor" () As wxFontData Ptr
Declare Sub wxFontData_dtor WXCALL Alias "wxFontData_dtor" (self As wxFontData Ptr)
Declare Sub wxFontData_SetAllowSymbols WXCALL Alias "wxFontData_SetAllowSymbols" (self As wxFontData Ptr, flag As wxBool)
Declare Function wxFontData_GetAllowSymbols WXCALL Alias "wxFontData_GetAllowSymbols" (self As wxFontData Ptr) As wxBool
Declare Sub wxFontData_SetColour WXCALL Alias "wxFontData_SetColour" (self As wxFontData Ptr, col As wxColour Ptr)
Declare Function wxFontData_GetColour WXCALL Alias "wxFontData_GetColour" (self As wxFontData Ptr) As wxColour Ptr
Declare Sub wxFontData_SetShowHelp WXCALL Alias "wxFontData_SetShowHelp" (self As wxFontData Ptr, flag As wxBool)
Declare Function wxFontData_GetShowHelp WXCALL Alias "wxFontData_GetShowHelp" (self As wxFontData Ptr) As wxBool
Declare Sub wxFontData_EnableEffects WXCALL Alias "wxFontData_EnableEffects" (self As wxFontData Ptr, flag As wxBool)
Declare Function wxFontData_GetEnableEffects WXCALL Alias "wxFontData_GetEnableEffects" (self As wxFontData Ptr) As wxBool
Declare Sub wxFontData_SetInitialFont WXCALL Alias "wxFontData_SetInitialFont" (self As wxFontData Ptr, font As wxFont Ptr)
Declare Function wxFontData_GetInitialFont WXCALL Alias "wxFontData_GetInitialFont" (self As wxFontData Ptr) As wxFont Ptr
Declare Sub wxFontData_SetChosenFont WXCALL Alias "wxFontData_SetChosenFont" (self As wxFontData Ptr, font As wxFont Ptr)
Declare Function wxFontData_GetChosenFont WXCALL Alias "wxFontData_GetChosenFont" (self As wxFontData Ptr) As wxFont Ptr
Declare Sub wxFontData_SetRange WXCALL Alias "wxFontData_SetRange" (self As wxFontData Ptr, minRange As wxInt, maxRange As wxInt)

#EndIf '__fontdialog_bi__

