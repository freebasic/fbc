#Ifndef __sizer_bi__
#Define __sizer_bi__

#Include Once "common.bi"

Declare Sub wxSizer_AddWindow WXCALL Alias "wxSizer_AddWindow" (self As wxSizer Ptr, _
                       win        As wxWindow Ptr, _
                       proportion As  wxInt, _
                       flag       As  wxInt, _
                       border     As  wxInt, _
                       userData   As wxObject Ptr)
Declare Sub wxSizer_AddSizer WXCALL Alias "wxSizer_AddSizer" (self As wxSizer Ptr, _
                      sizer      As wxSizer Ptr, _
                      proportion As  wxInt, _
                      flag       As  wxInt, _
                      border     As  wxInt, _
                      userData   As wxObject Ptr)
Declare Sub wxSizer_Add WXCALL Alias "wxSizer_Add" (self As wxSizer Ptr, w As wxInt, h As wxInt, proportion As wxInt, flag As wxInt, border As wxInt, userData As wxObject Ptr)
Declare Sub wxSizer_Fit WXCALL Alias "wxSizer_Fit" (self As wxSizer Ptr, win As wxWindow Ptr, size As wxSize Ptr)
Declare Sub wxSizer_FitInside WXCALL Alias "wxSizer_FitInside" (self As wxSizer Ptr, win As wxWindow Ptr)
Declare Sub wxSizer_InsertWindow WXCALL Alias "wxSizer_InsertWindow" (self As wxSizer Ptr, before As wxInt, win   As wxWindow Ptr, iOption As wxInt, flag As wxInt, border As wxInt, userData As wxObject Ptr)
Declare Sub wxSizer_InsertSizer WXCALL Alias "wxSizer_InsertSizer" (self As wxSizer Ptr, before As wxInt, sizer As wxSizer  Ptr, iOption As wxInt, flag As wxInt, border As wxInt, userData As wxObject Ptr)
Declare Sub wxSizer_Insert WXCALL Alias "wxSizer_Insert" (self As wxSizer Ptr, before As wxInt, w As wxInt, h As wxInt, iOption As wxInt, flag As wxInt, border As wxInt, userData As wxObject Ptr)
Declare Sub wxSizer_PrependWindow WXCALL Alias "wxSizer_PrependWindow" (self As wxSizer Ptr, win As wxWindow Ptr, iOption As wxInt, flag As wxInt, border As wxInt, userData As wxObject Ptr)
Declare Sub wxSizer_PrependSizer WXCALL Alias "wxSizer_PrependSizer" (self As wxSizer Ptr, sizer As wxSizer Ptr, iOption As wxInt, flag As wxInt, border As wxInt, userData As wxObject Ptr)
Declare Sub wxSizer_Prepend WXCALL Alias "wxSizer_Prepend" (self As wxSizer Ptr, w As wxInt, h As wxInt, iOption As wxInt, flag As wxInt, border As wxInt, userData As wxObject Ptr)
Declare Function wxSizer_RemoveWindow WXCALL Alias "wxSizer_RemoveWindow" (self As wxSizer Ptr, win As wxWindow Ptr) As wxBool
Declare Function wxSizer_RemoveSizer WXCALL Alias "wxSizer_RemoveSizer" (self As wxSizer Ptr, sizer As wxSizer Ptr) As wxBool
Declare Function wxSizer_Remove WXCALL Alias "wxSizer_Remove" (self As wxSizer Ptr, iPos As wxInt) As wxBool
Declare Sub wxSizer_Clear WXCALL Alias "wxSizer_Clear" (self As wxSizer Ptr, deleteWindows As wxBool)
Declare Sub wxSizer_DeleteWindows WXCALL Alias "wxSizer_DeleteWindows" (self As wxSizer Ptr)
Declare Sub wxSizer_SetMinSize WXCALL Alias "wxSizer_SetMinSize" (self As wxSizer Ptr, size As wxSize Ptr)
Declare Function wxSizer_SetItemMinSizeWindow WXCALL Alias "wxSizer_SetItemMinSizeWindow" (self As wxSizer Ptr, win As wxWindow Ptr, size As wxSize Ptr) As wxBool
Declare Function wxSizer_SetItemMinSizeSizer WXCALL Alias "wxSizer_SetItemMinSizeSizer" (self As wxSizer Ptr, sizer As wxSizer Ptr, size As wxSize Ptr) As wxBool
Declare Function wxSizer_SetItemMinSize WXCALL Alias "wxSizer_SetItemMinSize" (self As wxSizer Ptr, iPos As wxInt, size As wxSize Ptr) As wxBool
Declare Sub wxSizer_GetSize WXCALL Alias "wxSizer_GetSize" (self As wxSizer Ptr, size As wxSize Ptr)
Declare Sub wxSizer_GetPosition WXCALL Alias "wxSizer_GetPosition" (self As wxSizer Ptr, pt As wxPoint Ptr)
Declare Sub wxSizer_GetMinSize WXCALL Alias "wxSizer_GetMinSize" (self As wxSizer Ptr, size As wxSize Ptr)
Declare Sub wxSizer_RecalcSizes WXCALL Alias "wxSizer_RecalcSizes" (self As wxSizer Ptr)
Declare Sub wxSizer_CalcMin WXCALL Alias "wxSizer_CalcMin" (self As wxSizer Ptr, size As wxSize Ptr)
Declare Sub wxSizer_Layout WXCALL Alias "wxSizer_Layout" (self As wxSizer Ptr)
Declare Sub wxSizer_SetSizeHints WXCALL Alias "wxSizer_SetSizeHints" (self As wxSizer Ptr, win As wxWindow Ptr)
Declare Sub wxSizer_SetVirtualSizeHints WXCALL Alias "wxSizer_SetVirtualSizeHints" (self As wxSizer Ptr, win As wxWindow Ptr)
Declare Sub wxSizer_SetDimension WXCALL Alias "wxSizer_SetDimension" (self As wxSizer Ptr, x As wxInt, y As wxInt, w As wxInt, h As wxInt)
Declare Sub wxSizer_ShowWindow WXCALL Alias "wxSizer_ShowWindow" (self As wxSizer Ptr, win As wxWindow Ptr, show As wxBool)
Declare Sub wxSizer_HideWindow WXCALL Alias "wxSizer_HideWindow" (self As wxSizer Ptr, win As wxWindow Ptr)
Declare Sub wxSizer_ShowSizer WXCALL Alias "wxSizer_ShowSizer" (self As wxSizer Ptr, sizer As wxSizer Ptr, show As wxBool)
Declare Sub wxSizer_HideSizer WXCALL Alias "wxSizer_HideSizer" (self As wxSizer Ptr, sizer As wxSizer Ptr)
Declare Function wxSizer_IsShownWindow WXCALL Alias "wxSizer_IsShownWindow" (self As wxSizer Ptr, win As wxWindow Ptr) As wxBool
Declare Function wxSizer_IsShownSizer WXCALL Alias "wxSizer_IsShownSizer" (self As wxSizer Ptr, sizer As wxSizer Ptr) As wxBool
Declare Function wxSizer_Detach WXCALL Alias "wxSizer_Detach" (self As wxSizer Ptr, win As wxWindow Ptr) As wxBool
Declare Function wxSizer_Detach2 WXCALL Alias "wxSizer_Detach2" (self As wxSizer Ptr, sizer As wxSizer Ptr) As wxBool
Declare Function wxSizer_Detach3 WXCALL Alias "wxSizer_Detach3" (self As wxSizer Ptr, index As wxInt) As wxBool

#EndIf ' __sizer_bi__

