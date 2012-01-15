#Ifndef __panel_bi__
#Define __panel_bi__

#Include Once "common.bi"

Declare Function wxPanel_ctor WXCALL Alias "wxPanel_ctor" () As wxPanel Ptr 
Declare Function wxPanel_ctor2 WXCALL Alias "wxPanel_ctor2" (parent As wxWindow Ptr, _
                   id      As  wxWindowID   = -1, _
                   x       As  wxInt        = -1, _
                   y       As  wxInt        = -1, _
                   w       As  wxInt        = -1, _
                   h       As  wxInt        = -1, _
                   style   As  wxUInt       =  0, _
                   nameArg As wxString Ptr = WX_NULL) As wxPanel Ptr 
Declare Function wxPanel_Create WXCALL Alias "wxPanel_Create" (self As wxPanel  Ptr, _
                    parent  As wxWindow Ptr    , _
                    id      As  wxWindowID   = -1, _
                    x       As  wxInt        = -1, _
                    y       As  wxInt        = -1, _
                    w       As  wxInt        = -1, _
                    h       As  wxInt        = -1, _
                    style   As  wxUInt       =  0, _
                    nameArg As wxString Ptr = WX_NULL) As wxBool
Declare Sub wxPanel_InitDialog WXCALL Alias "wxPanel_InitDialog" (self As wxPanel Ptr)
Declare Sub wxTopLevelWindow_SetDefaultItem WXCALL Alias "wxTopLevelWindow_SetDefaultItem" (self As wxTopLevelWindow Ptr, btn As wxWindow Ptr)
Declare Function wxTopLevelWindow_GetDefaultItem WXCALL Alias "wxTopLevelWindow_GetDefaultItem" (self As wxTopLevelWindow Ptr) As wxWindow Ptr

#EndIf ' __panel_bi__

