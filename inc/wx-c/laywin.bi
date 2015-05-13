#Ifndef __laywin_bi__
#Define __laywin_bi__

#Include Once "common.bi"

' class wxSashLayoutWindow
Declare Function wxSashLayoutWindow_ctor WXCALL Alias "wxSashLayoutWindow_ctor" () As wxSashLayoutWindow Ptr
Declare Function wxSashLayoutWindow_Create WXCALL Alias "wxSashLayoutWindow_Create" (self As wxSashLayoutWindow Ptr, _
                               parent  As wxWindow           Ptr, _
                               id      As  wxWindowID   = -1, _
                               x       As  wxInt        = -1, _
                               y       As  wxInt        = -1, _
                               w       As  wxInt        = -1, _
                               h       As  wxInt        = -1, _
                               style   As  wxUInt       =  0, _
                               nameArg As wxString Ptr = WX_NULL) As wxBool
Declare Function wxSashLayoutWindow_GetAlignment WXCALL Alias "wxSashLayoutWindow_GetAlignment" (self As wxSashLayoutWindow Ptr) As wxLayoutAlignment
Declare Sub wxSashLayoutWindow_SetAlignment WXCALL Alias "wxSashLayoutWindow_SetAlignment" (self As wxSashLayoutWindow Ptr, align As wxLayoutAlignment)
Declare Function wxSashLayoutWindow_GetOrientation WXCALL Alias "wxSashLayoutWindow_GetOrientation" (self As wxSashLayoutWindow Ptr) As wxLayoutOrientation
Declare Sub wxSashLayoutWindow_SetOrientation WXCALL Alias "wxSashLayoutWindow_SetOrientation" (self As wxSashLayoutWindow Ptr, orient As wxLayoutOrientation)
Declare Sub wxSashLayoutWindow_SetDefaultSize WXCALL Alias "wxSashLayoutWindow_SetDefaultSize" (self As wxSashLayoutWindow Ptr, size As wxSize Ptr)

' class wxLayoutAlgorithm
Declare Function wxLayoutAlgorithm_ctor WXCALL Alias "wxLayoutAlgorithm_ctor" () As wxLayoutAlgorithm Ptr
Declare Function wxLayoutAlgorithm_LayoutMDIFrame WXCALL Alias "wxLayoutAlgorithm_LayoutMDIFrame" (self As wxLayoutAlgorithm Ptr, frame As wxMDIParentFrame Ptr, r As wxRect Ptr) As wxBool
Declare Function wxLayoutAlgorithm_LayoutFrame WXCALL Alias "wxLayoutAlgorithm_LayoutFrame" (self As wxLayoutAlgorithm Ptr, frame As wxFrame Ptr, mainWin As wxWindow Ptr) As wxBool
Declare Function wxLayoutAlgorithm_LayoutWindow WXCALL Alias "wxLayoutAlgorithm_LayoutWindow" (self As wxLayoutAlgorithm Ptr, win As wxWindow Ptr, mainWin As wxWindow Ptr) As wxBool

' class wxQueryLayoutInfoEvent
Declare Function wxQueryLayoutInfoEvent_ctor WXCALL Alias "wxQueryLayoutInfoEvent_ctor" (id As wxWindowID) As wxQueryLayoutInfoEvent Ptr
Declare Sub wxQueryLayoutInfoEvent_SetRequestedLength WXCALL Alias "wxQueryLayoutInfoEvent_SetRequestedLength" (self As wxQueryLayoutInfoEvent Ptr, length As wxInt)
Declare Function wxQueryLayoutInfoEvent_GetRequestedLength WXCALL Alias "wxQueryLayoutInfoEvent_GetRequestedLength" (self As wxQueryLayoutInfoEvent Ptr) As wxInt
Declare Sub wxQueryLayoutInfoEvent_SetFlags WXCALL Alias "wxQueryLayoutInfoEvent_SetFlags" (self As wxQueryLayoutInfoEvent Ptr, flags As wxInt)
Declare Function wxQueryLayoutInfoEvent_GetFlags WXCALL Alias "wxQueryLayoutInfoEvent_GetFlags" (self As wxQueryLayoutInfoEvent Ptr) As wxInt
Declare Sub wxQueryLayoutInfoEvent_SetSize WXCALL Alias "wxQueryLayoutInfoEvent_SetSize" (self As wxQueryLayoutInfoEvent Ptr, size As wxSize Ptr)
Declare Sub wxQueryLayoutInfoEvent_GetSize WXCALL Alias "wxQueryLayoutInfoEvent_GetSize" (self As wxQueryLayoutInfoEvent Ptr, size As wxSize Ptr)
Declare Sub wxQueryLayoutInfoEvent_SetOrientation WXCALL Alias "wxQueryLayoutInfoEvent_SetOrientation" (self As wxQueryLayoutInfoEvent Ptr, orient As wxLayoutOrientation)
Declare Function wxQueryLayoutInfoEvent_GetOrientation WXCALL Alias "wxQueryLayoutInfoEvent_GetOrientation" (self As wxQueryLayoutInfoEvent Ptr) As wxLayoutOrientation
Declare Sub wxQueryLayoutInfoEvent_SetAlignment WXCALL Alias "wxQueryLayoutInfoEvent_SetAlignment" (self As wxQueryLayoutInfoEvent Ptr, align As wxLayoutAlignment)
Declare Function wxQueryLayoutInfoEvent_GetAlignment WXCALL Alias "wxQueryLayoutInfoEvent_GetAlignment" (self As wxQueryLayoutInfoEvent Ptr) As wxLayoutAlignment

' class wxCalculateLayoutEvent
Declare Function wxCalculateLayoutEvent_ctor WXCALL Alias "wxCalculateLayoutEvent_ctor" (id As wxWindowID) As wxCalculateLayoutEvent Ptr 
Declare Sub wxCalculateLayoutEvent_SetFlags WXCALL Alias "wxCalculateLayoutEvent_SetFlags" (self As wxCalculateLayoutEvent Ptr, flags As wxInt)
Declare Function wxCalculateLayoutEvent_GetFlags WXCALL Alias "wxCalculateLayoutEvent_GetFlags" (self As wxCalculateLayoutEvent Ptr) As wxInt
Declare Sub wxCalculateLayoutEvent_SetRect WXCALL Alias "wxCalculateLayoutEvent_SetRect" (self As wxCalculateLayoutEvent Ptr, r As wxRect Ptr)
Declare Sub wxCalculateLayoutEvent_GetRect WXCALL Alias "wxCalculateLayoutEvent_GetRect" (self As wxCalculateLayoutEvent Ptr, r As wxRect Ptr)

#EndIf ' __laywin_bi__

