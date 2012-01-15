#Ifndef __mdi_bi__
#Define __mdi_bi__

#Include Once "common.bi"

Type Virtual_OnCreateClient As Function WXCALL As wxMDIClientWindow Ptr

Declare Function wxMDIParentFrame_ctor WXCALL Alias "wxMDIParentFrame_ctor" () As wxMDIParentFrame Ptr
Declare Sub wxMDIParentFrame_RegisterVirtual WXCALL Alias "wxMDIParentFrame_RegisterVirtual" (self As wxMDIParentFrame Ptr, onCreateClient As Virtual_OnCreateClient)
Declare Function wxMDIParentFrame_OnCreateClient WXCALL Alias "wxMDIParentFrame_OnCreateClient" (self As wxMDIParentFrame Ptr) As wxMDIClientWindow Ptr
Declare Function wxMDIParentFrame_Create WXCALL Alias "wxMDIParentFrame_Create" (self As wxMDIParentFrame Ptr, _
                             parent   As wxWindow         Ptr     , _
                             id       As  wxWindowID           = -1, _
                             titleArg As wxString         Ptr     , _
                             x        As  wxInt                = -1, _
                             y        As  wxInt                = -1, _
                             w        As  wxInt                = -1, _
                             h        As  wxInt                = -1, _
                             style    As  wxUInt               =  0, _
                             nameArg  As wxString         Ptr = WX_NULL) As wxBool
Declare Function wxMDIParentFrame_GetActiveChild WXCALL Alias "wxMDIParentFrame_GetActiveChild" (self As wxMDIParentFrame Ptr) As wxMDIChildFrame Ptr
Declare Function wxMDIParentFrame_GetClientWindow WXCALL Alias "wxMDIParentFrame_GetClientWindow" (self As wxMDIParentFrame Ptr) As wxMDIClientWindow Ptr
Declare Sub wxMDIParentFrame_Cascade WXCALL Alias "wxMDIParentFrame_Cascade" (self As wxMDIParentFrame Ptr)
Declare Sub wxMDIParentFrame_Tile WXCALL Alias "wxMDIParentFrame_Tile" (self As wxMDIParentFrame Ptr)
Declare Sub wxMDIParentFrame_ArrangeIcons WXCALL Alias "wxMDIParentFrame_ArrangeIcons" (self As wxMDIParentFrame Ptr)
Declare Sub wxMDIParentFrame_ActivateNext WXCALL Alias "wxMDIParentFrame_ActivateNext" (self As wxMDIParentFrame Ptr)
Declare Sub wxMDIParentFrame_ActivatePrevious WXCALL Alias "wxMDIParentFrame_ActivatePrevious" (self As wxMDIParentFrame Ptr)
Declare Sub wxMDIParentFrame_GetClientSize WXCALL Alias "wxMDIParentFrame_GetClientSize" (self As wxMDIParentFrame Ptr, w As wxInt Ptr, h As wxInt Ptr)

' class wxMDIChildFrame
Declare Function wxMDIChildFrame_ctor WXCALL Alias "wxMDIChildFrame_ctor" () As wxMDIChildFrame Ptr
Declare Sub wxMDIChildFrame_Activate WXCALL Alias "wxMDIChildFrame_Activate" (self As wxMDIChildFrame Ptr)
Declare Function wxMDIChildFrame_Create WXCALL Alias "wxMDIChildFrame_Create" (self As wxMDIChildFrame Ptr, _
                            parent   As wxMDIParentFrame Ptr     , _
                            id       As  wxWindowID           = -1, _
                            titleArg As wxString         Ptr = WX_NULL, _
                            x        As  wxInt                = -1, _
                            y        As  wxInt                = -1, _
                            w        As  wxInt                = -1, _
                            h        As  wxInt                = -1, _
                            style    As  wxUInt               =  0, _
                            nameArg  As wxString         Ptr = WX_NULL) As wxBool
Declare Sub wxMDIChildFrame_Restore WXCALL Alias "wxMDIChildFrame_Restore" (self As wxMDIChildFrame Ptr)
Declare Sub wxMDIChildFrame_Maximize WXCALL Alias "wxMDIChildFrame_Maximize" (self As wxMDIChildFrame Ptr, maximize As wxBool)

' class wxMDIClientWindow
Declare Function wxMDIClientWindow_ctor WXCALL Alias "wxMDIClientWindow_ctor" () As wxMDIClientWindow Ptr
Declare Function wxMDIClientWindow_CreateClient WXCALL Alias "wxMDIClientWindow_CreateClient" (self As wxMDIClientWindow Ptr, parent As wxMDIParentFrame Ptr, style As wxUint) As wxBool 

#EndIf ' __mdi_bi__

