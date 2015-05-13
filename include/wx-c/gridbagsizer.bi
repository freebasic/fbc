#Ifndef __gridbagsizer_bi__
#Define __gridbagsizer_bi__

#Include Once "common.bi"

' class wxGBSizerItem
Declare Function wxGBSizerItem_ctor WXCALL Alias "wxGBSizerItem_ctor" (w As  wxInt, _
                        h         As  wxInt           , _
                        p         As wxGBPosition Ptr, _
                        span      As wxGBSpan     Ptr, _
                        flag      As  wxInt           , _
                        border    As  wxInt           , _
                        pUserData As wxObject     Ptr) As wxGBSizerItem Ptr 
Declare Function wxGBSizerItem_ctorWindow WXCALL Alias "wxGBSizerItem_ctorWindow" (win As wxWindow Ptr, _
                              p         As wxGBPosition Ptr, _
                              span      As wxGBSpan     Ptr, _
                              flag      As  wxInt           , _
                              border    As  wxInt           , _
                              pUserData As wxObject Ptr) As wxGBSizerItem Ptr
Declare Function wxGBSizerItem_ctorSizer WXCALL Alias "wxGBSizerItem_ctorSizer" (sizer As wxSizer Ptr, _
                             p         As wxGBPosition Ptr, _
                             span      As wxGBSpan     Ptr, _
                             flag      As  wxInt           , _
                             border    As  wxInt           , _
                             pUserData As wxObject     Ptr) As wxGBSizerItem Ptr
Declare Function wxGBSizerItem_ctorDefault WXCALL Alias "wxGBSizerItem_ctorDefault" () As wxGBSizerItem Ptr
Declare Function wxGBSizerItem_GetPos WXCALL Alias "wxGBSizerItem_GetPos" (self As wxGBSizerItem Ptr) As wxGBPosition Ptr
Declare Function wxGBSizerItem_GetSpan WXCALL Alias "wxGBSizerItem_GetSpan" (self As wxGBSizerItem Ptr) As wxGBSpan Ptr
Declare Function wxGBSizerItem_SetPos WXCALL Alias "wxGBSizerItem_SetPos" (self As wxGBSizerItem Ptr, p As wxGBPosition Ptr) As wxBool
Declare Function wxGBSizerItem_SetSpan WXCALL Alias "wxGBSizerItem_SetSpan" (self As wxGBSizerItem Ptr, span As wxGBSpan Ptr) As wxBool
Declare Function wxGBSizerItem_IntersectsSizer WXCALL Alias "wxGBSizerItem_IntersectsSizer" (self As wxGBSizerItem Ptr, other As wxGBSizerItem Ptr) As wxBool
Declare Function wxGBSizerItem_IntersectsSpan WXCALL Alias "wxGBSizerItem_IntersectsSpan" (self As wxGBSizerItem Ptr, p As wxGBPosition Ptr, span As wxGBSpan Ptr) As wxBool
Declare Sub wxGBSizerItem_GetEndPos WXCALL Alias "wxGBSizerItem_GetEndPos" (self As wxGBSizerItem Ptr, row As wxInt Ptr, col As wxInt Ptr)
Declare Function wxGBSizerItem_GetGBSizer WXCALL Alias "wxGBSizerItem_GetGBSizer" (self As wxGBSizerItem Ptr) As wxGridBagSizer Ptr
Declare Sub wxGBSizerItem_SetGBSizer WXCALL Alias "wxGBSizerItem_SetGBSizer" (self As wxGBSizerItem Ptr, sizer As wxGridBagSizer Ptr)

' class wxGBSpan
Declare Function wxGBSpan_ctorDefault WXCALL Alias "wxGBSpan_ctorDefault" () As wxGBSpan Ptr
Declare Function wxGBSpan_ctor WXCALL Alias "wxGBSpan_ctor" (rs As wxInt, cs As wxInt) As wxGBSpan Ptr
Declare Function wxGBSpan_GetRowspan WXCALL Alias "wxGBSpan_GetRowspan" (self As wxGBSpan Ptr) As wxInt
Declare Function wxGBSpan_GetColspan WXCALL Alias "wxGBSpan_GetColspan" (self As wxGBSpan Ptr) As wxInt
Declare Sub wxGBSpan_SetRowspan WXCALL Alias "wxGBSpan_SetRowspan" (self As wxGBSpan Ptr, rs As wxInt)
Declare Sub wxGBSpan_SetColspan WXCALL Alias "wxGBSpan_SetColspan" (self As wxGBSpan Ptr, cs As wxInt)

' class wxGridBagSizer
Declare Function wxGridBagSizer_ctor WXCALL Alias "wxGridBagSizer_ctor" (vgap As wxInt, hgap As wxInt) As wxGridBagSizer Ptr
Declare Function wxGridBagSizer_AddWindow WXCALL Alias "wxGridBagSizer_AddWindow" (self As wxGridBagSizer Ptr, _
                              win       As wxWindow       Ptr, _
                              p         As wxGBPosition   Ptr, _
                              span      As wxGBSpan       Ptr, _
                              flag      As  wxInt             , _
                              border    As  wxInt             , _
                              pUserData As wxObject       Ptr) As wxBool 
Declare Function wxGridBagSizer_AddSizer WXCALL Alias "wxGridBagSizer_AddSizer" (self As wxGridBagSizer Ptr, _
                             sizer     As wxSizer        Ptr, _
                             p         As wxGBPosition   Ptr, _
                             span      As wxGBSpan       Ptr, _
                             flag      As  wxInt             , _
                             border    As  wxInt             , _
                             pUserData As wxObject       Ptr) As wxBool
Declare Function wxGridBagSizer_Add WXCALL Alias "wxGridBagSizer_Add" (self As wxGridBagSizer Ptr, _
                        w         As  wxInt             , _
                        h         As  wxInt             , _
                        p         As wxGBPosition   Ptr, _
                        span      As wxGBSpan       Ptr, _
                        flag      As  wxInt             , _
                        border    As  wxInt             , _
                        pUserData As wxObject       Ptr) As wxBool
Declare Function wxGridBagSizer_AddItem WXCALL Alias "wxGridBagSizer_AddItem" (self As wxGridBagSizer Ptr, item As wxGBSizerItem Ptr) As wxBool
Declare Sub wxGridBagSizer_GetEmptyCellSize WXCALL Alias "wxGridBagSizer_GetEmptyCellSize" (self As wxGridBagSizer Ptr, size As wxSize Ptr)
Declare Sub wxGridBagSizer_SetEmptyCellSize WXCALL Alias "wxGridBagSizer_SetEmptyCellSize" (self As wxGridBagSizer Ptr, size As wxSize Ptr)
Declare Sub wxGridBagSizer_GetCellSize WXCALL Alias "wxGridBagSizer_GetCellSize" (self As wxGridBagSizer Ptr, row As wxInt, col As wxInt, size As wxSize Ptr)
Declare Function wxGridBagSizer_GetItemPosition WXCALL Alias "wxGridBagSizer_GetItemPosition" (self As wxGridBagSizer Ptr, win As wxWindow Ptr) As wxGBPosition Ptr
Declare Function wxGridBagSizer_GetItemPositionSizer WXCALL Alias "wxGridBagSizer_GetItemPositionSizer" (self As wxGridBagSizer Ptr, sizer As wxSizer Ptr) As wxGBPosition Ptr
Declare Function wxGridBagSizer_GetItemPositionIndex WXCALL Alias "wxGridBagSizer_GetItemPositionIndex" (self As wxGridBagSizer Ptr, indx As wxInt) As wxGBPosition Ptr
Declare Function wxGridBagSizer_SetItemPosition WXCALL Alias "wxGridBagSizer_SetItemPosition" (self As wxGridBagSizer Ptr, win As wxWindow Ptr, p As wxGBPosition Ptr) As wxBool
Declare Function wxGridBagSizer_SetItemPositionSizer WXCALL Alias "wxGridBagSizer_SetItemPositionSizer" (self As wxGridBagSizer Ptr, sizer As wxSizer Ptr, p As wxGBPosition Ptr) As wxBool
Declare Function wxGridBagSizer_SetItemPositionIndex WXCALL Alias "wxGridBagSizer_SetItemPositionIndex" (self As wxGridBagSizer Ptr, indx As wxInt, p As wxGBPosition Ptr) As wxBool
Declare Function wxGridBagSizer_GetItemSpan WXCALL Alias "wxGridBagSizer_GetItemSpan" (self As wxGridBagSizer Ptr, win As wxWindow Ptr) As wxGBSpan Ptr
Declare Function wxGridBagSizer_GetItemSpanSizer WXCALL Alias "wxGridBagSizer_GetItemSpanSizer" (self As wxGridBagSizer Ptr, sizer As wxSizer Ptr) As wxGBSpan Ptr
Declare Function wxGridBagSizer_GetItemSpanIndex WXCALL Alias "wxGridBagSizer_GetItemSpanIndex" (self As wxGridBagSizer Ptr, indx As wxInt) As wxGBSpan Ptr
Declare Function wxGridBagSizer_SetItemSpan WXCALL Alias "wxGridBagSizer_SetItemSpan" (self As wxGridBagSizer Ptr, win As wxWindow Ptr, span As wxGBSpan Ptr) As wxBool
Declare Function wxGridBagSizer_SetItemSpanSizer WXCALL Alias "wxGridBagSizer_SetItemSpanSizer" (self As wxGridBagSizer Ptr, sizer As wxSizer Ptr, span As wxGBSpan Ptr) As wxBool
Declare Function wxGridBagSizer_SetItemSpanIndex WXCALL Alias "wxGridBagSizer_SetItemSpanIndex" (self As wxGridBagSizer Ptr, indx As wxInt, span As wxGBSpan Ptr) As wxBool
Declare Function wxGridBagSizer_FindItem WXCALL Alias "wxGridBagSizer_FindItem" (self As wxGridBagSizer Ptr, win As wxWindow Ptr) As wxGBSizerItem Ptr
Declare Function wxGridBagSizer_FindItemSizer WXCALL Alias "wxGridBagSizer_FindItemSizer" (self As wxGridBagSizer Ptr, sizer As wxSizer Ptr) As wxGBSizerItem Ptr
Declare Function wxGridBagSizer_FindItemAtPosition WXCALL Alias "wxGridBagSizer_FindItemAtPosition" (self As wxGridBagSizer Ptr, p As wxGBPosition Ptr) As wxGBSizerItem Ptr
Declare Function wxGridBagSizer_FindItemAtPoint WXCALL Alias "wxGridBagSizer_FindItemAtPoint" (self As wxGridBagSizer Ptr, pt As wxPoint Ptr) As wxGBSizerItem Ptr
Declare Function wxGridBagSizer_FindItemWithData WXCALL Alias "wxGridBagSizer_FindItemWithData" (self As wxGridBagSizer Ptr, pUserData As wxObject Ptr) As wxGBSizerItem Ptr
Declare Function wxGridBagSizer_CheckForIntersectionItem WXCALL Alias "wxGridBagSizer_CheckForIntersectionItem" (self As wxGridBagSizer Ptr, item As wxGBSizerItem Ptr, excItem As wxGBSizerItem Ptr) As wxBool
Declare Function wxGridBagSizer_CheckForIntersectionPos WXCALL Alias "wxGridBagSizer_CheckForIntersectionPos" (self As wxGridBagSizer Ptr, p As wxGBPosition Ptr, span As wxGBSpan Ptr, excItem As wxGBSizerItem Ptr) As wxBool

' class wxGBPosition
Declare Function wxGBPosition_ctor WXCALL Alias "wxGBPosition_ctor" () As wxGBPosition Ptr
Declare Function wxGBPosition_ctorPos WXCALL Alias "wxGBPosition_ctorPos" (row As wxInt, col As wxInt) As wxGBPosition Ptr
Declare Function wxGBPosition_GetRow WXCALL Alias "wxGBPosition_GetRow" (self As wxGBPosition Ptr) As wxInt
Declare Function wxGBPosition_GetCol WXCALL Alias "wxGBPosition_GetCol" (self As wxGBPosition Ptr) As wxInt
Declare Sub wxGBPosition_SetRow WXCALL Alias "wxGBPosition_SetRow" (self As wxGBPosition Ptr, row As wxInt)
Declare Sub wxGBPosition_SetCol WXCALL Alias "wxGBPosition_SetCol" (self As wxGBPosition Ptr, col As wxInt)

#EndIf ' __gridbagsizer_bi__

