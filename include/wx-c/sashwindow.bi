#Ifndef __sashwindow_bi__
#Define __sashwindow_bi__

#Include Once "common.bi"

' class wxSashEdge
Declare Function wxSashEdge_ctor WXCALL Alias "wxSashEdge_ctor" () As wxSashEdge Ptr
Declare Sub wxSashEdge_dtor WXCALL Alias "wxSashEdge_dtor" (self As wxSashEdge Ptr)
Declare Function wxSashEdge_m_show WXCALL Alias "wxSashEdge_m_show" (self As wxSashEdge Ptr) As wxBool 
Declare Function wxSashEdge_m_border WXCALL Alias "wxSashEdge_m_border" (self As wxSashEdge Ptr) As wxBool
Declare Function wxSashEdge_m_margin WXCALL Alias "wxSashEdge_m_margin" (self As wxSashEdge Ptr) As wxInt

' class wxSashWindow
Declare Function wxSashWindow_ctor WXCALL Alias "wxSashWindow_ctor" () As wxSashWindow Ptr  
Declare Function wxSashWindow_Create WXCALL Alias "wxSashWindow_Create" (self As wxSashWindow Ptr, _
                         parent  As wxWindow     Ptr     , _
                         id      As  wxWindowID       = -1, _
                         x       As  wxInt            = -1, _
                         y       As  wxInt            = -1, _
                         w       As  wxInt            = -1, _
                         h       As  wxInt            = -1, _
                         style   As  wxUInt           =  0, _
                         nameArg As wxString     Ptr = WX_NULL) As wxBool
Declare Sub wxSashWindow_SetSashVisible WXCALL Alias "wxSashWindow_SetSashVisible" (self As wxSashWindow Ptr, edge As wxSashEdgePosition,flag As wxBool)
Declare Function wxSashWindow_GetSashVisible WXCALL Alias "wxSashWindow_GetSashVisible" (self As wxSashWindow Ptr, edge As wxSashEdgePosition) As wxBool
Declare Sub wxSashWindow_SetSashBorder WXCALL Alias "wxSashWindow_SetSashBorder" (self As wxSashWindow Ptr, edge As wxSashEdgePosition, flag As wxBool)
Declare Function wxSashWindow_HasBorder WXCALL Alias "wxSashWindow_HasBorder" (self As wxSashWindow Ptr, edge As wxSashEdgePosition) As wxBool
Declare Function wxSashWindow_GetEdgeMargin WXCALL Alias "wxSashWindow_GetEdgeMargin" (self As wxSashWindow Ptr, edge As wxSashEdgePosition) As wxInt
Declare Sub wxSashWindow_SetDefaultBorderSize WXCALL Alias "wxSashWindow_SetDefaultBorderSize" (self As wxSashWindow Ptr, w As wxInt)
Declare Function wxSashWindow_GetDefaultBorderSize WXCALL Alias "wxSashWindow_GetDefaultBorderSize" (self As wxSashWindow Ptr) As wxInt
Declare Sub wxSashWindow_SetExtraBorderSize WXCALL Alias "wxSashWindow_SetExtraBorderSize" (self As wxSashWindow Ptr, w As wxInt)
Declare Function wxSashWindow_GetExtraBorderSize WXCALL Alias "wxSashWindow_GetExtraBorderSize" (self As wxSashWindow Ptr) As wxInt
Declare Sub wxSashWindow_SetMinimumSizeX WXCALL Alias "wxSashWindow_SetMinimumSizeX" (self As wxSashWindow Ptr, min As wxInt)
Declare Sub wxSashWindow_SetMinimumSizeY WXCALL Alias "wxSashWindow_SetMinimumSizeY" (self As wxSashWindow Ptr, min As wxInt)
Declare Function wxSashWindow_GetMinimumSizeX WXCALL Alias "wxSashWindow_GetMinimumSizeX" (self As wxSashWindow Ptr) As wxInt
Declare Function wxSashWindow_GetMinimumSizeY WXCALL Alias "wxSashWindow_GetMinimumSizeY" (self As wxSashWindow Ptr) As wxInt
Declare Sub wxSashWindow_SetMaximumSizeX WXCALL Alias "wxSashWindow_SetMaximumSizeX" (self As wxSashWindow Ptr, max As wxInt)
Declare Sub wxSashWindow_SetMaximumSizeY WXCALL Alias "wxSashWindow_SetMaximumSizeY" (self As wxSashWindow Ptr, max As wxInt)
Declare Function wxSashWindow_GetMaximumSizeX WXCALL Alias "wxSashWindow_GetMaximumSizeX" (self As wxSashWindow Ptr) As wxInt
Declare Function wxSashWindow_GetMaximumSizeY WXCALL Alias "wxSashWindow_GetMaximumSizeY" (self As wxSashWindow Ptr) As wxInt

' class wxSashEvent
Declare Function wxSashEvent_ctor WXCALL Alias "wxSashEvent_ctor" (id As wxInt, edge As wxSashEdgePosition) As wxSashEvent Ptr
Declare Sub wxSashEvent_SetEdge WXCALL Alias "wxSashEvent_SetEdge" (self As wxSashEvent Ptr, edge As wxSashEdgePosition)
Declare Function wxSashEvent_GetEdge WXCALL Alias "wxSashEvent_GetEdge" (self As wxSashEvent Ptr) As wxSashEdgePosition Ptr
Declare Sub wxSashEvent_SetDragRect WXCALL Alias "wxSashEvent_SetDragRect" (self As wxSashEvent Ptr, r As wxRect Ptr)
Declare Sub wxSashEvent_GetDragRect WXCALL Alias "wxSashEvent_GetDragRect" (self As wxSashEvent Ptr, r As wxRect Ptr)
Declare Sub wxSashEvent_SetDragStatus WXCALL Alias "wxSashEvent_SetDragStatus" (self As wxSashEvent Ptr, status As wxSashDragStatus)
Declare Function wxSashEvent_GetDragStatus WXCALL Alias "wxSashEvent_GetDragStatus" (self As wxSashEvent Ptr) As wxSashDragStatus

#EndIf ' __sashwindow_bi__

