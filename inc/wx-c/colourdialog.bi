#Ifndef __colourdialog_bi__
#Define __colourdialog_bi__

#Include Once "common.bi"

' class wxColourDialog 
Declare Function wxColourDialog_ctor WXCALL Alias "wxColourDialog_ctor" () As wxColourDialog Ptr 
Declare Function wxColourDialog_Create WXCALL Alias "wxColourDialog_Create" (self As wxColourDialog Ptr, parent As wxWindow Ptr, pData As wxColourData Ptr) As wxBool
Declare Function wxColourDialog_GetColourData WXCALL Alias "wxColourDialog_GetColourData" (self As wxColourDialog Ptr) As wxColourData Ptr
Declare Function wxColourDialog_ShowModal WXCALL Alias "wxColourDialog_ShowModal" (self As wxColourDialog Ptr) As wxInt
Declare Function wxColourDialog_GetColourFromUser WXCALL Alias "wxColourDialog_GetColourFromUser" (parent As wxWindow Ptr, col As wxColour Ptr) As wxColour Ptr
Declare Function wxColourData_ctor WXCALL Alias "wxColourData_ctor" () As wxColourData Ptr
Declare Sub wxColourData_SetChooseFull WXCALL Alias "wxColourData_SetChooseFull" (self As wxColourData Ptr, flag As wxBool)
Declare Function wxColourData_GetChooseFull WXCALL Alias "wxColourData_GetChooseFull" (self As wxColourData Ptr) As wxBool 
Declare Sub wxColourData_SetColour WXCALL Alias "wxColourData_SetColour" (self As wxColourData Ptr, colour As wxColour Ptr)
Declare Function wxColourData_GetColour WXCALL Alias "wxColourData_GetColour" (self As wxColourData Ptr) As wxColour Ptr
Declare Sub wxColourData_SetCustomColour WXCALL Alias "wxColourData_SetCustomColour" (self As wxColourData Ptr, i As wxInt, colour As wxColour Ptr)
Declare Function wxColourData_GetCustomColour WXCALL Alias "wxColourData_GetCustomColour" (self As wxColourData Ptr, i As wxInt) As wxColour Ptr

#EndIf ' __colourdialog_bi__

