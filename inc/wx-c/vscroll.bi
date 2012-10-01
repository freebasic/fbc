#Ifndef __vscroll_bi__
#Define __vscroll_bi__

#Include Once "common.bi"

Type  Virtual_IntInt As Function WXCALL (As wxInt) As wxInt

Declare Function wxVScrolledWindow_ctor WXCALL Alias "wxVScrolledWindow_ctor" (parent As wxWindow Ptr, _
                            id      As  wxWindowID = -1, _
                            x       As  wxInt = -1, _
                            y       As  wxInt = -1, _
                            w       As  wxInt = -1, _
                            h       As  wxInt = -1, _
                            style   As  wxUInt = 0, _
                            nameArg As wxString Ptr = WX_NULL) As wxVScrolledWindow Ptr
Declare Function wxVScrolledWindow_Create WXCALL Alias "wxVScrolledWindow_Create" (self As wxVScrolledWindow Ptr, _
                              parent  As wxWindow Ptr, _
                              id      As  wxWindowID = -1, _
                              x       As  wxInt  = -1, _
                              y       As  wxInt  = -1, _
                              w       As  wxInt  = -1, _
                              h       As  wxInt  = -1, _
                              style   As  wxUInt = 0, _
                              nameArg As wxString Ptr = WX_NULL) As wxBool
Declare Sub wxVScrolledWindow_RegisterVirtual WXCALL Alias "wxVScrolledWindow_RegisterVirtual" (self As wxVScrolledWindow Ptr, on_GetLineHeight As Virtual_IntInt)
Declare Sub wxVScrolledWindow_SetLineCount WXCALL Alias "wxVScrolledWindow_SetLineCount" (self As wxVScrolledWindow Ptr, count As wxInt)
Declare Function wxVScrolledWindow_ScrollToLine WXCALL Alias "wxVScrolledWindow_ScrollToLine" (self As wxVScrolledWindow Ptr, toLine As wxInt) As wxBool
Declare Function wxVScrolledWindow_ScrollLines WXCALL Alias "wxVScrolledWindow_ScrollLines" (self As wxVScrolledWindow Ptr, toLine As wxInt) As wxBool
Declare Function wxVScrolledWindow_ScrollPages WXCALL Alias "wxVScrolledWindow_ScrollPages" (self As wxVScrolledWindow Ptr, pages As wxInt) As wxBool
Declare Sub wxVScrolledWindow_RefreshLine WXCALL Alias "wxVScrolledWindow_RefreshLine" (self As wxVScrolledWindow Ptr, toLine As wxInt)
Declare Sub wxVScrolledWindow_RefreshLines WXCALL Alias "wxVScrolledWindow_RefreshLines" (self As wxVScrolledWindow Ptr, FirstLine As wxInt, LastLine As wxInt)
Declare Function wxVScrolledWindow_HitTest WXCALL Alias "wxVScrolledWindow_HitTest" (self As wxVScrolledWindow Ptr, x As wxCoord, y As wxCoord) As wxInt
Declare Function wxVScrolledWindow_HitTest2 WXCALL Alias "wxVScrolledWindow_HitTest2" (self As wxVScrolledWindow Ptr, pt As wxPoint Ptr) As wxInt
Declare Sub wxVScrolledWindow_RefreshAll WXCALL Alias "wxVScrolledWindow_RefreshAll" (self As wxVScrolledWindow Ptr)
Declare Function wxVScrolledWindow_GetLineCount WXCALL Alias "wxVScrolledWindow_GetLineCount" (self As wxVScrolledWindow Ptr) As wxInt
Declare Function wxVScrolledWindow_GetFirstVisisbleLine WXCALL Alias "wxVScrolledWindow_GetFirstVisisbleLine" (self As wxVScrolledWindow Ptr) As wxInt
Declare Function wxVScrolledWindow_GetLastVisibleLine WXCALL Alias "wxVScrolledWindow_GetLastVisibleLine" (self As wxVScrolledWindow Ptr) As wxInt
Declare Function wxVScrolledWindow_IsVisible WXCALL Alias "wxVScrolledWindow_IsVisible" (self As wxVScrolledWindow Ptr, toLine As wxInt) As wxBool

#EndIf ' __vscroll_bi__

