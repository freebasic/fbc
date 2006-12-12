''
''
'' gridbagsizer -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __wxc_gridbagsizer_bi__
#define __wxc_gridbagsizer_bi__

#include once "wx.bi"

declare function wxGBSizerItem alias "wxGBSizerItem_ctor" (byval width as integer, byval height as integer, byval pos as wxGBPosition ptr, byval span as wxGBSpan ptr, byval flag as integer, byval border as integer, byval userData as wxObject ptr) as wxGBSizerItem ptr
declare function wxGBSizerItem_ctorWindow (byval window as wxWindow ptr, byval pos as wxGBPosition ptr, byval span as wxGBSpan ptr, byval flag as integer, byval border as integer, byval userData as wxObject ptr) as wxGBSizerItem ptr
declare function wxGBSizerItem_ctorSizer (byval sizer as wxSizer ptr, byval pos as wxGBPosition ptr, byval span as wxGBSpan ptr, byval flag as integer, byval border as integer, byval userData as wxObject ptr) as wxGBSizerItem ptr
declare function wxGBSizerItem_ctorDefault () as wxGBSizerItem ptr
declare function wxGBSizerItem_GetPos (byval self as wxGBSizerItem ptr) as wxGBPosition ptr
declare function wxGBSizerItem_GetSpan (byval self as wxGBSizerItem ptr) as wxGBSpan ptr
declare function wxGBSizerItem_SetPos (byval self as wxGBSizerItem ptr, byval pos as wxGBPosition ptr) as integer
declare function wxGBSizerItem_SetSpan (byval self as wxGBSizerItem ptr, byval span as wxGBSpan ptr) as integer
declare function wxGBSizerItem_IntersectsSizer (byval self as wxGBSizerItem ptr, byval other as wxGBSizerItem ptr) as integer
declare function wxGBSizerItem_IntersectsSpan (byval self as wxGBSizerItem ptr, byval pos as wxGBPosition ptr, byval span as wxGBSpan ptr) as integer
declare sub wxGBSizerItem_GetEndPos (byval self as wxGBSizerItem ptr, byval row as integer ptr, byval col as integer ptr)
declare function wxGBSizerItem_GetGBSizer (byval self as wxGBSizerItem ptr) as wxGridBagSizer ptr
declare sub wxGBSizerItem_SetGBSizer (byval self as wxGBSizerItem ptr, byval sizer as wxGridBagSizer ptr)
declare function wxGBSpan_ctorDefault () as wxGBSpan ptr
declare function wxGBSpan alias "wxGBSpan_ctor" (byval rowspan as integer, byval colspan as integer) as wxGBSpan ptr
declare function wxGBSpan_GetRowspan (byval self as wxGBSpan ptr) as integer
declare function wxGBSpan_GetColspan (byval self as wxGBSpan ptr) as integer
declare sub wxGBSpan_SetRowspan (byval self as wxGBSpan ptr, byval rowspan as integer)
declare sub wxGBSpan_SetColspan (byval self as wxGBSpan ptr, byval colspan as integer)
declare function wxGridBagSizer alias "wxGridBagSizer_ctor" (byval vgap as integer, byval hgap as integer) as wxGridBagSizer ptr
declare function wxGridBagSizer_AddWindow (byval self as wxGridBagSizer ptr, byval window as wxWindow ptr, byval pos as wxGBPosition ptr, byval span as wxGBSpan ptr, byval flag as integer, byval border as integer, byval userData as wxObject ptr) as integer
declare function wxGridBagSizer_AddSizer (byval self as wxGridBagSizer ptr, byval sizer as wxSizer ptr, byval pos as wxGBPosition ptr, byval span as wxGBSpan ptr, byval flag as integer, byval border as integer, byval userData as wxObject ptr) as integer
declare function wxGridBagSizer_Add (byval self as wxGridBagSizer ptr, byval width as integer, byval height as integer, byval pos as wxGBPosition ptr, byval span as wxGBSpan ptr, byval flag as integer, byval border as integer, byval userData as wxObject ptr) as integer
declare function wxGridBagSizer_AddItem (byval self as wxGridBagSizer ptr, byval item as wxGBSizerItem ptr) as integer
declare sub wxGridBagSizer_GetEmptyCellSize (byval self as wxGridBagSizer ptr, byval size as wxSize ptr)
declare sub wxGridBagSizer_SetEmptyCellSize (byval self as wxGridBagSizer ptr, byval sz as wxSize ptr)
declare sub wxGridBagSizer_GetCellSize (byval self as wxGridBagSizer ptr, byval row as integer, byval col as integer, byval size as wxSize ptr)
declare function wxGridBagSizer_GetItemPosition (byval self as wxGridBagSizer ptr, byval window as wxWindow ptr) as wxGBPosition ptr
declare function wxGridBagSizer_GetItemPositionSizer (byval self as wxGridBagSizer ptr, byval sizer as wxSizer ptr) as wxGBPosition ptr
declare function wxGridBagSizer_GetItemPositionIndex (byval self as wxGridBagSizer ptr, byval index as integer) as wxGBPosition ptr
declare function wxGridBagSizer_SetItemPosition (byval self as wxGridBagSizer ptr, byval window as wxWindow ptr, byval pos as wxGBPosition ptr) as integer
declare function wxGridBagSizer_SetItemPositionSizer (byval self as wxGridBagSizer ptr, byval sizer as wxSizer ptr, byval pos as wxGBPosition ptr) as integer
declare function wxGridBagSizer_SetItemPositionIndex (byval self as wxGridBagSizer ptr, byval index as integer, byval pos as wxGBPosition ptr) as integer
declare function wxGridBagSizer_GetItemSpan (byval self as wxGridBagSizer ptr, byval window as wxWindow ptr) as wxGBSpan ptr
declare function wxGridBagSizer_GetItemSpanSizer (byval self as wxGridBagSizer ptr, byval sizer as wxSizer ptr) as wxGBSpan ptr
declare function wxGridBagSizer_GetItemSpanIndex (byval self as wxGridBagSizer ptr, byval index as integer) as wxGBSpan ptr
declare function wxGridBagSizer_SetItemSpan (byval self as wxGridBagSizer ptr, byval window as wxWindow ptr, byval span as wxGBSpan ptr) as integer
declare function wxGridBagSizer_SetItemSpanSizer (byval self as wxGridBagSizer ptr, byval sizer as wxSizer ptr, byval span as wxGBSpan ptr) as integer
declare function wxGridBagSizer_SetItemSpanIndex (byval self as wxGridBagSizer ptr, byval index as integer, byval span as wxGBSpan ptr) as integer
declare function wxGridBagSizer_FindItem (byval self as wxGridBagSizer ptr, byval window as wxWindow ptr) as wxGBSizerItem ptr
declare function wxGridBagSizer_FindItemSizer (byval self as wxGridBagSizer ptr, byval sizer as wxSizer ptr) as wxGBSizerItem ptr
declare function wxGridBagSizer_FindItemAtPosition (byval self as wxGridBagSizer ptr, byval pos as wxGBPosition ptr) as wxGBSizerItem ptr
declare function wxGridBagSizer_FindItemAtPoint (byval self as wxGridBagSizer ptr, byval pt as wxPoint ptr) as wxGBSizerItem ptr
declare function wxGridBagSizer_FindItemWithData (byval self as wxGridBagSizer ptr, byval userData as wxObject ptr) as wxGBSizerItem ptr
declare function wxGridBagSizer_CheckForIntersectionItem (byval self as wxGridBagSizer ptr, byval item as wxGBSizerItem ptr, byval excludeItem as wxGBSizerItem ptr) as integer
declare function wxGridBagSizer_CheckForIntersectionPos (byval self as wxGridBagSizer ptr, byval pos as wxGBPosition ptr, byval span as wxGBSpan ptr, byval excludeItem as wxGBSizerItem ptr) as integer
declare function wxGBPosition alias "wxGBPosition_ctor" () as wxGBPosition ptr
declare function wxGBPosition_ctorPos (byval row as integer, byval col as integer) as wxGBPosition ptr
declare function wxGBPosition_GetRow (byval self as wxGBPosition ptr) as integer
declare function wxGBPosition_GetCol (byval self as wxGBPosition ptr) as integer
declare sub wxGBPosition_SetRow (byval self as wxGBPosition ptr, byval row as integer)
declare sub wxGBPosition_SetCol (byval self as wxGBPosition ptr, byval col as integer)

#endif
