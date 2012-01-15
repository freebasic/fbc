#Ifndef __sizeritem_bi__
#Define __sizeritem_bi__

#Include Once "common.bi"

Declare Function wxSizerItem_ctor WXCALL Alias "wxSizerItem_ctor" () As wxSizerItem Ptr
Declare Function wxSizerItem_ctorSpace WXCALL Alias "wxSizerItem_ctorSpace" (w As wxInt, h As wxInt, proportion As wxInt, flag As wxInt, border As wxInt, userData As wxObject Ptr) As wxSizerItem Ptr
Declare Function wxSizerItem_ctorWindow WXCALL Alias "wxSizerItem_ctorWindow" (win As wxWindow Ptr, proportion As wxInt, flag As wxInt, border As wxInt, userData As wxObject Ptr) As wxSizerItem Ptr
Declare Function wxSizerItem_ctorSizer WXCALL Alias "wxSizerItem_ctorSizer" (sizer As wxSizer Ptr, proportion As wxInt, flag As wxInt, border As wxInt, userData As wxObject Ptr) As wxSizerItem Ptr
Declare Sub wxSizerItem_DeleteWindows WXCALL Alias "wxSizerItem_DeleteWindows" (self As wxSizerItem Ptr)
Declare Sub wxSizerItem_DetachSizer WXCALL Alias "wxSizerItem_DetachSizer" (self As wxSizerItem Ptr)
Declare Sub wxSizerItem_GetSize WXCALL Alias "wxSizerItem_GetSize" (self As wxSizerItem Ptr, size As wxSize Ptr)
Declare Sub wxSizerItem_CalcMin WXCALL Alias "wxSizerItem_CalcMin" (self As wxSizerItem Ptr, min As wxSize Ptr)
Declare Sub wxSizerItem_SetDimension WXCALL Alias "wxSizerItem_SetDimension" (self As wxSizerItem Ptr, pt As wxPoint Ptr, size As wxSize Ptr)
Declare Sub wxSizerItem_GetMinSize WXCALL Alias "wxSizerItem_GetMinSize" (self As wxSizerItem Ptr, size As wxSize Ptr)
Declare Sub wxSizerItem_SetInitSize WXCALL Alias "wxSizerItem_SetInitSize" (self As wxSizerItem Ptr, x As wxInt, y As wxInt)
Declare Sub wxSizerItem_SetRatio WXCALL Alias "wxSizerItem_SetRatio" (self As wxSizerItem Ptr, w As wxInt, h As wxInt)
Declare Sub wxSizerItem_SetRatioFloat WXCALL Alias "wxSizerItem_SetRatioFloat" (self As wxSizerItem Ptr, ratio As wxFloat)
Declare Function wxSizerItem_GetRatioFloat WXCALL Alias "wxSizerItem_GetRatioFloat" (self As wxSizerItem Ptr) As wxFloat
Declare Function wxSizerItem_IsWindow WXCALL Alias "wxSizerItem_IsWindow" (self As wxSizerItem Ptr) As wxBool
Declare Function wxSizerItem_IsSizer WXCALL Alias "wxSizerItem_IsSizer" (self As wxSizerItem Ptr) As wxBool
Declare Function wxSizerItem_IsSpacer WXCALL Alias "wxSizerItem_IsSpacer" (self As wxSizerItem Ptr) As wxBool
Declare Sub wxSizerItem_SetProportion WXCALL Alias "wxSizerItem_SetProportion" (self As wxSizerItem Ptr, proportion As wxInt)
Declare Function wxSizerItem_GetProportion WXCALL Alias "wxSizerItem_GetProportion" (self As wxSizerItem Ptr) As wxInt
Declare Sub wxSizerItem_SetFlag WXCALL Alias "wxSizerItem_SetFlag" (self As wxSizerItem Ptr, flag As wxInt )
Declare Function wxSizerItem_GetFlag WXCALL Alias "wxSizerItem_GetFlag" (self As wxSizerItem Ptr) As wxInt
Declare Sub wxSizerItem_SetBorder WXCALL Alias "wxSizerItem_SetBorder" (self As wxSizerItem Ptr, border As wxInt)
Declare Function wxSizerItem_GetBorder WXCALL Alias "wxSizerItem_GetBorder" (self As wxSizerItem Ptr) As wxInt
Declare Function wxSizerItem_GetWindow WXCALL Alias "wxSizerItem_GetWindow" (self As wxSizerItem Ptr)As wxWindow Ptr
Declare Sub wxSizerItem_SetWindow WXCALL Alias "wxSizerItem_SetWindow" (self As wxSizerItem Ptr, win As wxWindow Ptr)
Declare Function wxSizerItem_GetSizer WXCALL Alias "wxSizerItem_GetSizer" (self As wxSizerItem Ptr) As wxSizer Ptr
Declare Sub wxSizerItem_SetSizer WXCALL Alias "wxSizerItem_SetSizer" (self As wxSizerItem Ptr, sizer As wxSizer Ptr)
Declare Sub wxSizerItem_GetSpacer WXCALL Alias "wxSizerItem_GetSpacer" (self As wxSizerItem Ptr, size As wxSize Ptr)
Declare Sub wxSizerItem_SetSpacer WXCALL Alias "wxSizerItem_SetSpacer" (self As wxSizerItem Ptr, size As wxSize Ptr)
Declare Sub wxSizerItem_Show WXCALL Alias "wxSizerItem_Show" (self As wxSizerItem Ptr, show As wxBool)
Declare Function wxSizerItem_IsShown WXCALL Alias "wxSizerItem_IsShown" (self As wxSizerItem Ptr) As wxBool
Declare Function wxSizerItem_GetUserData WXCALL Alias "wxSizerItem_GetUserData" (self As wxSizerItem Ptr) As wxObject Ptr
Declare Sub wxSizerItem_GetPosition WXCALL Alias "wxSizerItem_GetPosition" (self As wxSizerItem Ptr, pt As wxPoint Ptr)

#EndIf ' __sizeritem_bi__

