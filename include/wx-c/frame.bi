#Ifndef __frame_bi__
#Define __frame_bi__

#Include Once "common.bi"

' class wxFrame
Declare Function wxFrame_ctor WXCALL Alias "wxFrame_ctor" () As wxFrame Ptr 
Declare Function wxFrame_Create WXCALL Alias "wxFrame_Create" (self As wxFrame  Ptr, _
                                 parent   As wxWindow Ptr = WX_NULL, _
                                 id       As  wxWindowID   = -1, _
                                 titleArg As wxString Ptr = WX_NULL, _
                                 x        As  wxInt        = -1, _
                                 y        As  wxInt        = -1, _
                                 w        As  wxInt        = -1, _
                                 h        As  wxInt        = -1, _
                                 style    As  wxUInt       =  0, _
                                 nameArg  As wxString Ptr = WX_NULL) As wxChar
Declare Function wxFrame_ShowFullScreen WXCALL Alias "wxFrame_ShowFullScreen" (self As wxFrame Ptr, show As wxBool, style As wxFullScreen) As wxBool
Declare Function wxFrame_IsFullScreen WXCALL Alias "wxFrame_IsFullScreen" (self As wxFrame Ptr) As wxChar
Declare Sub wxFrame_Maximize WXCALL Alias "wxFrame_Maximize" (self As wxFrame Ptr, iconize As wxBool)
Declare Function wxFrame_IsMaximized WXCALL Alias "wxFrame_IsMaximized" (self As wxFrame Ptr) As wxBool
Declare Sub wxFrame_Iconize WXCALL Alias "wxFrame_Iconize" (self As wxFrame Ptr, iconize As wxBool)
Declare Function wxFrame_IsIconized WXCALL Alias "wxFrame_IsIconized" (self As wxFrame Ptr) As wxBool
Declare Sub wxFrame_SetIcon WXCALL Alias "wxFrame_SetIcon" (self As wxFrame Ptr, icon As wxIcon Ptr)
Declare Function wxFrame_GetIcon WXCALL Alias "wxFrame_GetIcon" (self As wxFrame Ptr) As wxIcon Ptr
Declare Sub wxFrame_SetMenuBar WXCALL Alias "wxFrame_SetMenuBar" (self As wxFrame Ptr, mbar As wxMenuBar Ptr)
Declare Function wxFrame_GetMenuBar WXCALL Alias "wxFrame_GetMenuBar" (self As wxFrame Ptr) As wxMenuBar Ptr
Declare Sub wxFrame_GetClientAreaOrigin WXCALL Alias "wxFrame_GetClientAreaOrigin" (self As wxFrame Ptr, p As wxPoint Ptr)
Declare Sub wxFrame_SendSizeEvent WXCALL Alias "wxFrame_SendSizeEvent" (self As wxFrame Ptr)

' class wxStatusBar
Declare Function wxFrame_CreateStatusBar WXCALL Alias "wxFrame_CreateStatusBar" (self As wxFrame Ptr, number As wxInt, style As wxUInt, id As wxInt, nam As wxString Ptr=WX_NULL) As wxStatusBar Ptr
Declare Sub wxFrame_SetStatusBar WXCALL Alias "wxFrame_SetStatusBar" (self As wxFrame Ptr, statusbar As wxStatusBar Ptr)
Declare Function wxFrame_GetStatusBar WXCALL Alias "wxFrame_GetStatusBar" (self As wxFrame Ptr) As wxStatusBar Ptr
Declare Sub wxFrame_SetStatusBarPane WXCALL Alias "wxFrame_SetStatusBarPane" (self As wxFrame Ptr, n As wxInt)
Declare Function wxFrame_GetStatusBarPane WXCALL Alias "wxFrame_GetStatusBarPane" (self As wxFrame Ptr) As wxInt
Declare Sub wxFrame_SetStatusWidths WXCALL Alias "wxFrame_SetStatusWidths" (self As wxFrame Ptr, n As wxInt, widths As wxInt Ptr)
Declare Sub wxFrame_SetStatusText WXCALL Alias "wxFrame_SetStatusText" (self As wxFrame Ptr, txt As wxString Ptr, n As wxInt)

' class wxToolBar
Declare Function wxFrame_CreateToolBar WXCALL Alias "wxFrame_CreateToolBar" (self As wxFrame Ptr, style As wxUInt, id As wxInt, nameArg As wxString Ptr=WX_NULL) As wxToolBar Ptr
Declare Sub wxFrame_SetToolBar WXCALL Alias "wxFrame_SetToolBar" (self As wxFrame Ptr, toolbar As wxToolBar Ptr)
Declare Function wxFrame_GetToolBar WXCALL Alias "wxFrame_GetToolBar" (self As wxFrame Ptr) As wxToolBar Ptr

#EndIf ' __frame_bi__

