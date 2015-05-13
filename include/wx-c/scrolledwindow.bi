#Ifndef __scrolledwindow_bi__
#Define __scrolledwindow_bi__

#Include Once "common.bi"

' cass wxScrolledWindow
Declare Function wxScrollWnd_ctor WXCALL Alias "wxScrollWnd_ctor" (parent As wxWindow Ptr, _
                      id      As  wxWindowID   = -1 , _
                      x       As  wxInt        = -1 , _
                      y       As  wxInt        = -1 , _
                      w       As  wxInt        = -1 , _
                      h       As  wxInt        = -1 , _
                      style   As  wxUInt       =  0 , _
                      nameArg As wxString Ptr = WX_NULL) As wxScrolledWindow Ptr
Declare Sub wxScrollWnd_PrepareDC WXCALL Alias "wxScrollWnd_PrepareDC" (self As wxScrolledWindow Ptr, dx As wxDC Ptr)
Declare Sub wxScrollWnd_SetScrollbars WXCALL Alias "wxScrollWnd_SetScrollbars" (self As wxScrolledWindow Ptr, pixelsPerUnitX As wxInt, pixelsPerUnitY As wxInt, noUnitsX As wxInt, noUnitsY As wxInt, x As wxInt, y As wxInt, noRefresh As wxBool)
Declare Sub wxScrollWnd_GetViewStart WXCALL Alias "wxScrollWnd_GetViewStart" (self As wxScrolledWindow Ptr, x As wxInt Ptr, y As wxInt Ptr)
Declare Sub wxScrollWnd_GetScrollPixelsPerUnit WXCALL Alias "wxScrollWnd_GetScrollPixelsPerUnit" (self As wxScrolledWindow Ptr, xUnit As wxInt Ptr, yUnit As wxInt Ptr)
Declare Sub wxScrollWnd_CalcScrolledPosition WXCALL Alias "wxScrollWnd_CalcScrolledPosition" (self As wxScrolledWindow Ptr, x As wxInt, y As wxInt, xx As wxInt Ptr, yy As wxInt Ptr)
Declare Sub wxScrollWnd_CalcUnscrolledPosition WXCALL Alias "wxScrollWnd_CalcUnscrolledPosition" (self As wxScrolledWindow Ptr, x As wxInt, y As wxInt, xx As wxInt Ptr, yy As wxInt Ptr)
Declare Sub wxScrollWnd_GetVirtualSize WXCALL Alias "wxScrollWnd_GetVirtualSize" (self As wxScrolledWindow Ptr, x As wxInt Ptr, y As wxInt Ptr)
Declare Sub wxScrollWnd_Scroll WXCALL Alias "wxScrollWnd_Scroll" (self As wxScrolledWindow Ptr, x As wxInt, y As wxInt)
Declare Sub wxScrollWnd_SetScrollRate WXCALL Alias "wxScrollWnd_SetScrollRate" (self As wxScrolledWindow Ptr, xstep As wxInt, ystep As wxInt)
Declare Sub wxScrollWnd_SetTargetWindow WXCALL Alias "wxScrollWnd_SetTargetWindow" (self As wxScrolledWindow Ptr, win As wxWindow Ptr)

#EndIf ' __scrolledwindow_bi__

