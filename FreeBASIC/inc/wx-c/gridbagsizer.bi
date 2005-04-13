''
''
'' gridbagsizer -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gridbagsizer_bi__
#define __gridbagsizer_bi__

#include once "wx-c/wx.bi"

declare function wxGBSizerItem cdecl alias "wxGBSizerItem_ctor" (byval width as integer, byval height as integer, byval pos as wxGBPosition ptr, byval span as wxGBSpan ptr, byval flag as integer, byval border as integer, byval userData as wxObject ptr) as wxGBSizerItem ptr
declare function wxGBSizerItem_ctorWindow cdecl alias "wxGBSizerItem_ctorWindow" (byval window as wxWindow ptr, byval pos as wxGBPosition ptr, byval span as wxGBSpan ptr, byval flag as integer, byval border as integer, byval userData as wxObject ptr) as wxGBSizerItem ptr
declare function wxGBSizerItem_ctorSizer cdecl alias "wxGBSizerItem_ctorSizer" (byval sizer as wxSizer ptr, byval pos as wxGBPosition ptr, byval span as wxGBSpan ptr, byval flag as integer, byval border as integer, byval userData as wxObject ptr) as wxGBSizerItem ptr
declare function wxGBSizerItem_ctorDefault cdecl alias "wxGBSizerItem_ctorDefault" () as wxGBSizerItem ptr
declare function wxGBSizerItem_GetPos cdecl alias "wxGBSizerItem_GetPos" (byval self as wxGBSizerItem ptr) as wxGBPosition ptr
declare function wxGBSizerItem_GetSpan cdecl alias "wxGBSizerItem_GetSpan" (byval self as wxGBSizerItem ptr) as wxGBSpan ptr
declare function wxGBSizerItem_SetPos cdecl alias "wxGBSizerItem_SetPos" (byval self as wxGBSizerItem ptr, byval pos as wxGBPosition ptr) as integer
declare function wxGBSizerItem_SetSpan cdecl alias "wxGBSizerItem_SetSpan" (byval self as wxGBSizerItem ptr, byval span as wxGBSpan ptr) as integer
declare function wxGBSizerItem_IntersectsSizer cdecl alias "wxGBSizerItem_IntersectsSizer" (byval self as wxGBSizerItem ptr, byval other as wxGBSizerItem ptr) as integer
declare function wxGBSizerItem_IntersectsSpan cdecl alias "wxGBSizerItem_IntersectsSpan" (byval self as wxGBSizerItem ptr, byval pos as wxGBPosition ptr, byval span as wxGBSpan ptr) as integer
declare sub wxGBSizerItem_GetEndPos cdecl alias "wxGBSizerItem_GetEndPos" (byval self as wxGBSizerItem ptr, byval row as integer ptr, byval col as integer ptr)
declare function wxGBSizerItem_GetGBSizer cdecl alias "wxGBSizerItem_GetGBSizer" (byval self as wxGBSizerItem ptr) as wxGridBagSizer ptr
declare sub wxGBSizerItem_SetGBSizer cdecl alias "wxGBSizerItem_SetGBSizer" (byval self as wxGBSizerItem ptr, byval sizer as wxGridBagSizer ptr)
declare function wxGBSpan_ctorDefault cdecl alias "wxGBSpan_ctorDefault" () as wxGBSpan ptr
declare function wxGBSpan cdecl alias "wxGBSpan_ctor" (byval rowspan as integer, byval colspan as integer) as wxGBSpan ptr
declare function wxGBSpan_GetRowspan cdecl alias "wxGBSpan_GetRowspan" (byval self as wxGBSpan ptr) as integer
declare function wxGBSpan_GetColspan cdecl alias "wxGBSpan_GetColspan" (byval self as wxGBSpan ptr) as integer
declare sub wxGBSpan_SetRowspan cdecl alias "wxGBSpan_SetRowspan" (byval self as wxGBSpan ptr, byval rowspan as integer)
declare sub wxGBSpan_SetColspan cdecl alias "wxGBSpan_SetColspan" (byval self as wxGBSpan ptr, byval colspan as integer)
declare function wxGridBagSizer cdecl alias "wxGridBagSizer_ctor" (byval vgap as integer, byval hgap as integer) as wxGridBagSizer ptr
declare function wxGridBagSizer_AddWindow cdecl alias "wxGridBagSizer_AddWindow" (byval self as wxGridBagSizer ptr, byval window as wxWindow ptr, byval pos as wxGBPosition ptr, byval span as wxGBSpan ptr, byval flag as integer, byval border as integer, byval userData as wxObject ptr) as integer
declare function wxGridBagSizer_AddSizer cdecl alias "wxGridBagSizer_AddSizer" (byval self as wxGridBagSizer ptr, byval sizer as wxSizer ptr, byval pos as wxGBPosition ptr, byval span as wxGBSpan ptr, byval flag as integer, byval border as integer, byval userData as wxObject ptr) as integer
declare function wxGridBagSizer_Add cdecl alias "wxGridBagSizer_Add" (byval self as wxGridBagSizer ptr, byval width as integer, byval height as integer, byval pos as wxGBPosition ptr, byval span as wxGBSpan ptr, byval flag as integer, byval border as integer, byval userData as wxObject ptr) as integer
declare function wxGridBagSizer_AddItem cdecl alias "wxGridBagSizer_AddItem" (byval self as wxGridBagSizer ptr, byval item as wxGBSizerItem ptr) as integer
declare sub wxGridBagSizer_GetEmptyCellSize cdecl alias "wxGridBagSizer_GetEmptyCellSize" (byval self as wxGridBagSizer ptr, byval size as wxSize ptr)
declare sub wxGridBagSizer_SetEmptyCellSize cdecl alias "wxGridBagSizer_SetEmptyCellSize" (byval self as wxGridBagSizer ptr, byval sz as wxSize ptr)
declare sub wxGridBagSizer_GetCellSize cdecl alias "wxGridBagSizer_GetCellSize" (byval self as wxGridBagSizer ptr, byval row as integer, byval col as integer, byval size as wxSize ptr)
declare function wxGridBagSizer_GetItemPosition cdecl alias "wxGridBagSizer_GetItemPosition" (byval self as wxGridBagSizer ptr, byval window as wxWindow ptr) as wxGBPosition ptr
declare function wxGridBagSizer_GetItemPositionSizer cdecl alias "wxGridBagSizer_GetItemPositionSizer" (byval self as wxGridBagSizer ptr, byval sizer as wxSizer ptr) as wxGBPosition ptr
declare function wxGridBagSizer_GetItemPositionIndex cdecl alias "wxGridBagSizer_GetItemPositionIndex" (byval self as wxGridBagSizer ptr, byval index as integer) as wxGBPosition ptr
declare function wxGridBagSizer_SetItemPosition cdecl alias "wxGridBagSizer_SetItemPosition" (byval self as wxGridBagSizer ptr, byval window as wxWindow ptr, byval pos as wxGBPosition ptr) as integer
declare function wxGridBagSizer_SetItemPositionSizer cdecl alias "wxGridBagSizer_SetItemPositionSizer" (byval self as wxGridBagSizer ptr, byval sizer as wxSizer ptr, byval pos as wxGBPosition ptr) as integer
declare function wxGridBagSizer_SetItemPositionIndex cdecl alias "wxGridBagSizer_SetItemPositionIndex" (byval self as wxGridBagSizer ptr, byval index as integer, byval pos as wxGBPosition ptr) as integer
declare function wxGridBagSizer_GetItemSpan cdecl alias "wxGridBagSizer_GetItemSpan" (byval self as wxGridBagSizer ptr, byval window as wxWindow ptr) as wxGBSpan ptr
declare function wxGridBagSizer_GetItemSpanSizer cdecl alias "wxGridBagSizer_GetItemSpanSizer" (byval self as wxGridBagSizer ptr, byval sizer as wxSizer ptr) as wxGBSpan ptr
declare function wxGridBagSizer_GetItemSpanIndex cdecl alias "wxGridBagSizer_GetItemSpanIndex" (byval self as wxGridBagSizer ptr, byval index as integer) as wxGBSpan ptr
declare function wxGridBagSizer_SetItemSpan cdecl alias "wxGridBagSizer_SetItemSpan" (byval self as wxGridBagSizer ptr, byval window as wxWindow ptr, byval span as wxGBSpan ptr) as integer
declare function wxGridBagSizer_SetItemSpanSizer cdecl alias "wxGridBagSizer_SetItemSpanSizer" (byval self as wxGridBagSizer ptr, byval sizer as wxSizer ptr, byval span as wxGBSpan ptr) as integer
declare function wxGridBagSizer_SetItemSpanIndex cdecl alias "wxGridBagSizer_SetItemSpanIndex" (byval self as wxGridBagSizer ptr, byval index as integer, byval span as wxGBSpan ptr) as integer
declare function wxGridBagSizer_FindItem cdecl alias "wxGridBagSizer_FindItem" (byval self as wxGridBagSizer ptr, byval window as wxWindow ptr) as wxGBSizerItem ptr
declare function wxGridBagSizer_FindItemSizer cdecl alias "wxGridBagSizer_FindItemSizer" (byval self as wxGridBagSizer ptr, byval sizer as wxSizer ptr) as wxGBSizerItem ptr
declare function wxGridBagSizer_FindItemAtPosition cdecl alias "wxGridBagSizer_FindItemAtPosition" (byval self as wxGridBagSizer ptr, byval pos as wxGBPosition ptr) as wxGBSizerItem ptr
declare function wxGridBagSizer_FindItemAtPoint cdecl alias "wxGridBagSizer_FindItemAtPoint" (byval self as wxGridBagSizer ptr, byval pt as wxPoint ptr) as wxGBSizerItem ptr
declare function wxGridBagSizer_FindItemWithData cdecl alias "wxGridBagSizer_FindItemWithData" (byval self as wxGridBagSizer ptr, byval userData as wxObject ptr) as wxGBSizerItem ptr
declare function wxGridBagSizer_CheckForIntersectionItem cdecl alias "wxGridBagSizer_CheckForIntersectionItem" (byval self as wxGridBagSizer ptr, byval item as wxGBSizerItem ptr, byval excludeItem as wxGBSizerItem ptr) as integer
declare function wxGridBagSizer_CheckForIntersectionPos cdecl alias "wxGridBagSizer_CheckForIntersectionPos" (byval self as wxGridBagSizer ptr, byval pos as wxGBPosition ptr, byval span as wxGBSpan ptr, byval excludeItem as wxGBSizerItem ptr) as integer
declare function wxGBPosition cdecl alias "wxGBPosition_ctor" () as wxGBPosition ptr
declare function wxGBPosition_ctorPos cdecl alias "wxGBPosition_ctorPos" (byval row as integer, byval col as integer) as wxGBPosition ptr
declare function wxGBPosition_GetRow cdecl alias "wxGBPosition_GetRow" (byval self as wxGBPosition ptr) as integer
declare function wxGBPosition_GetCol cdecl alias "wxGBPosition_GetCol" (byval self as wxGBPosition ptr) as integer
declare sub wxGBPosition_SetRow cdecl alias "wxGBPosition_SetRow" (byval self as wxGBPosition ptr, byval row as integer)
declare sub wxGBPosition_SetCol cdecl alias "wxGBPosition_SetCol" (byval self as wxGBPosition ptr, byval col as integer)

#endif
