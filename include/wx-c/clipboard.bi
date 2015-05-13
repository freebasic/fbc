#Ifndef __clipboard_bi__
#Define __clipboard_bi__

#Include Once "common.bi"

' class wxClipboard
Declare Function wxClipboard_ctor WXCALL Alias "wxClipboard_ctor" () As wxClipboard Ptr
Declare Function wxTheClipboard_static WXCALL Alias "wxTheClipboard_static" () As wxClipboard Ptr
Declare Function wxClipboard_Open WXCALL Alias "wxClipboard_Open" (self As wxClipboard Ptr) As wxBool
Declare Sub wxClipboard_Close WXCALL Alias "wxClipboard_Close" (self As wxClipboard Ptr)
Declare Function wxClipboard_IsOpened WXCALL Alias "wxClipboard_IsOpened" (self As wxClipboard Ptr) As wxBool
Declare Function wxClipboard_AddData WXCALL Alias "wxClipboard_AddData" (self As wxClipboard Ptr, pData   As wxDataObject Ptr) As wxBool
Declare Function wxClipboard_SetData WXCALL Alias "wxClipboard_SetData" (self As wxClipboard Ptr, pData   As wxDataObject Ptr) As wxBool
Declare Function wxClipboard_IsSupported WXCALL Alias "wxClipboard_IsSupported" (self As wxClipboard Ptr, pFormat As wxDataFormat Ptr) As wxBool
Declare Function wxClipboard_GetData WXCALL Alias "wxClipboard_GetData" (self As wxClipboard Ptr, pData   As wxDataObject Ptr) As wxBool
Declare Sub wxClipboard_Clear WXCALL Alias "wxClipboard_Clear" (self As wxClipboard Ptr)
Declare Function wxClipboard_Flush WXCALL Alias "wxClipboard_Flush" (self As wxClipboard Ptr) As wxBool
Declare Sub wxClipboard_UsePrimarySelection WXCALL Alias "wxClipboard_UsePrimarySelection" (self As wxClipboard Ptr, primary As wxBool)

' class wxClipboardLocker
Declare Function wxClipBoardLocker_ctor WXCALL Alias "wxClipBoardLocker_ctor" (clipboard As wxClipboard Ptr) As wxClipboardLocker Ptr
Declare Sub wxClipBoardLocker_dtor WXCALL Alias "wxClipBoardLocker_dtor" (self As wxClipboardLocker Ptr)
Declare Function wxClipboardLocker_IsOpen WXCALL Alias "wxClipboardLocker_IsOpen" (self As wxClipboardLocker Ptr) As wxBool

#EndIf ' __clipboard_bi__

