#Ifndef __splitterwindow_bi__
#Define __splitterwindow_bi__

#Include Once "common.bi"

Type Virtual_OnDoubleClickSash    As Sub      WXCALL (x As wxInt, y As wxInt)
Type Virtual_OnUnsplit            As Sub      WXCALL (win As wxWindow Ptr)
Type Virtual_OnSashPositionChange As Function WXCALL (As wxInt) As wxBool

Declare Function wxSplitWnd_ctor WXCALL Alias "wxSplitWnd_ctor" (parent As wxWindow Ptr, _
                                     id      As  wxWindowID   = -1, _
                                     x       As  wxInt        = -1, _
                                     y       As  wxInt        = -1, _
                                     w       As  wxInt        = -1, _
                                     h       As  wxInt        = -1, _
                                     style   As  wxUInt       =  0, _
                                     nameArg As wxString Ptr = WX_NULL) As wxSplitterWindow Ptr
Declare Sub wxSplitWnd_RegisterVirtual WXCALL Alias "wxSplitWnd_RegisterVirtual" (self As wxSplitterWindow Ptr, on_doubleclicksash As Virtual_OnDoubleClickSash, on_unsplit As Virtual_OnUnsplit, on_sashpositionchange As Virtual_OnSashPositionChange)
Declare Sub wxSplitWnd_OnDoubleClickSash WXCALL Alias "wxSplitWnd_OnDoubleClickSash" (self As wxSplitterWindow Ptr, x As wxInt, y As wxInt)
Declare Sub wxSplitWnd_OnUnsplit WXCALL Alias "wxSplitWnd_OnUnsplit" (self As wxSplitterWindow Ptr, removed As wxWindow Ptr)
Declare Function wxSplitWnd_OnSashPositionChange WXCALL Alias "wxSplitWnd_OnSashPositionChange" (self As wxSplitterWindow Ptr,  newSashPosition As wxInt) As wxBool
Declare Function wxSplitWnd_GetSplitMode WXCALL Alias "wxSplitWnd_GetSplitMode" (self As wxSplitterWindow Ptr) As wxInt
Declare Function wxSplitWnd_IsSplit WXCALL Alias "wxSplitWnd_IsSplit" (self As wxSplitterWindow Ptr) As wxBool
Declare Function wxSplitWnd_SplitHorizontally WXCALL Alias "wxSplitWnd_SplitHorizontally" (self As wxSplitterWindow Ptr, win1 As wxWindow Ptr, win2 As wxWindow Ptr, sashPosition As wxInt) As wxBool
Declare Function wxSplitWnd_SplitVertically WXCALL Alias "wxSplitWnd_SplitVertically" (self As wxSplitterWindow Ptr, win1 As wxWindow Ptr, win2 As wxWindow Ptr, sashPosition As wxInt) As wxBool
Declare Function wxSplitWnd_Unsplit WXCALL Alias "wxSplitWnd_Unsplit" (self As wxSplitterWindow Ptr, toRemove As wxWindow Ptr) As wxBool
Declare Sub wxSplitWnd_SetSashPosition WXCALL Alias "wxSplitWnd_SetSashPosition" (self As wxSplitterWindow Ptr, position As wxInt, redraw As wxBool)
Declare Function wxSplitWnd_GetSashPosition WXCALL Alias "wxSplitWnd_GetSashPosition" (self As wxSplitterWindow Ptr) As wxInt
Declare Function wxSplitWnd_GetMinimumPaneSize WXCALL Alias "wxSplitWnd_GetMinimumPaneSize" (self As wxSplitterWindow Ptr) As wxInt
Declare Function wxSplitWnd_GetWindow1 WXCALL Alias "wxSplitWnd_GetWindow1" (self As wxSplitterWindow Ptr) As wxWindow Ptr
Declare Function wxSplitWnd_GetWindow2 WXCALL Alias "wxSplitWnd_GetWindow2" (self As wxSplitterWindow Ptr) As wxWindow Ptr
Declare Sub wxSplitWnd_Initialize WXCALL Alias "wxSplitWnd_Initialize" (self As wxSplitterWindow Ptr, win As wxWindow Ptr)
Declare Function wxSplitWnd_ReplaceWindow WXCALL Alias "wxSplitWnd_ReplaceWindow" (self As wxSplitterWindow Ptr, winOld As wxWindow Ptr, winNew As wxWindow Ptr) As wxBool
Declare Sub wxSplitWnd_SetMinimumPaneSize WXCALL Alias "wxSplitWnd_SetMinimumPaneSize" (self As wxSplitterWindow Ptr, paneSize As wxInt)
Declare Sub wxSplitWnd_SetSplitMode WXCALL Alias "wxSplitWnd_SetSplitMode" (self As wxSplitterWindow Ptr, mode As wxInt)
Declare Sub wxSplitWnd_UpdateSize WXCALL Alias "wxSplitWnd_UpdateSize" (self As wxSplitterWindow Ptr)
Declare Sub wxSplitWnd_SetSashGravity WXCALL Alias "wxSplitWnd_SetSashGravity" (self As wxSplitterWindow Ptr, gravity As wxDouble)
Declare Function wxSplitWnd_GetSashGravity WXCALL Alias "wxSplitWnd_GetSashGravity" (self As wxSplitterWindow Ptr) As wxDouble

#EndIf ' __splitterwindow_bi__

