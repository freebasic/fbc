#Ifndef __dialog_bi__
#Define __dialog_bi__

#Include Once "common.bi"

' class wxDialog
Declare Function wxDialog_ctor WXCALL Alias "wxDialog_ctor" () As wxDialog Ptr
Declare Sub wxDialog_dtor WXCALL Alias "wxDialog_dtor" (self As wxDialog Ptr)
Declare Function wxDialog_Create WXCALL Alias "wxDialog_Create" (self As wxDialog Ptr, parent As wxWindow Ptr, id As wxWindowID, titleArg As wxString Ptr, x As wxInt, y As wxInt, w As wxInt, h As wxInt, style As wxUInt, nameArg As wxString Ptr) As wxBool
Declare Function wxDialog_CreateButtonSizer WXCALL Alias "wxDialog_CreateButtonSizer" (self As wxDialog Ptr, flags As wxUInt) As wxSizer Ptr
Declare Function wxDialog_CreateSeparatedButtonSizer WXCALL Alias "wxDialog_CreateSeparatedButtonSizer" (self As wxDialog Ptr, flags As wxUInt) As wxSizer Ptr
Declare Function wxDialog_CreateStdDialogButtonSizer WXCALL Alias "wxDialog_CreateStdDialogButtonSizer" (self As wxDialog Ptr, flags As wxUInt) As wxSizer Ptr
Declare Sub wxDialog_SetReturnCode WXCALL Alias "wxDialog_SetReturnCode" (self As wxDialog Ptr, returnCode As wxInt)
Declare Function wxDialog_GetReturnCode WXCALL Alias "wxDialog_GetReturnCode" (self As wxDialog Ptr) As wxInt
Declare Sub wxDialog_SetTitle WXCALL Alias "wxDialog_SetTitle" (self As wxDialog Ptr, txt As wxString Ptr)
Declare Function wxDialog_GetTitle WXCALL Alias "wxDialog_GetTitle" (self As wxDialog Ptr) As wxString Ptr
Declare Function wxDialog_IsModal WXCALL Alias "wxDialog_IsModal" (self As wxDialog Ptr) As wxBool
Declare Function wxDialog_ShowModal WXCALL Alias "wxDialog_ShowModal" (self As wxDialog Ptr) As wxInt
Declare Sub wxDialog_EndModal WXCALL Alias "wxDialog_EndModal" (self As wxDialog Ptr, retCode As wxInt)
Declare Sub wxDialog_SetIcon WXCALL Alias "wxDialog_SetIcon" (self As wxDialog Ptr, icon As wxIcon Ptr)
Declare Sub wxDialog_SetIcons WXCALL Alias "wxDialog_SetIcons" (self As wxDialog Ptr, icons As wxIconBundle Ptr)

#EndIf ' __dialog_bi__

