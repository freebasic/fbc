''
''
'' vlbox -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __wxc_vlbox_bi__
#define __wxc_vlbox_bi__

#include once "wx.bi"


type Virtual_voidDcRectSizeT as sub WXCALL (byval as wxDC ptr, byval as wxRect ptr, byval as integer)
#ifndef Virtual_IntInt
type Virtual_IntInt as function WXCALL (byval as integer) as integer
#endif

declare function wxVListBox alias "wxVListBox_ctor" (byval parent as wxWindow ptr, byval id as wxWindowID, byval pos as wxPoint ptr, byval size as wxSize ptr, byval style as integer, byval name as zstring ptr) as wxVListBox ptr
declare sub wxVListBox_RegisterVirtual (byval self as _VListBox ptr, byval onDrawItem as Virtual_voidDcRectSizeT, byval onMeasureItem as Virtual_IntInt, byval onDrawSeparator as Virtual_voidDcRectSizeT, byval onDrawBackground as Virtual_voidDcRectSizeT, byval onGetLineHeight as Virtual_IntInt)
declare function wxVListBox_Create (byval self as _VListBox ptr, byval parent as wxWindow ptr, byval id as wxWindowID, byval pos as wxPoint ptr, byval size as wxSize ptr, byval style as integer, byval name as zstring ptr) as integer
declare sub wxVListBox_OnDrawSeparator (byval self as _VListBox ptr, byval dc as wxDC ptr, byval rect as wxRect ptr, byval n as integer)
declare sub wxVListBox_OnDrawBackground (byval self as _VListBox ptr, byval dc as wxDC ptr, byval rect as wxRect ptr, byval n as integer)
declare function wxVListBox_OnGetLineHeight (byval self as _VListBox ptr, byval line as integer) as wxCoord
declare function wxVListBox_GetItemCount (byval self as _VListBox ptr) as integer
declare function wxVListBox_HasMultipleSelection (byval self as _VListBox ptr) as integer
declare function wxVListBox_GetSelection (byval self as _VListBox ptr) as integer
declare function wxVListBox_IsCurrent (byval self as _VListBox ptr, byval item as integer) as integer
declare function wxVListBox_IsSelected (byval self as _VListBox ptr, byval item as integer) as integer
declare function wxVListBox_GetSelectedCount (byval self as _VListBox ptr) as integer
declare function wxVListBox_GetFirstSelected (byval self as _VListBox ptr, byval cookie as uinteger ptr) as integer
declare function wxVListBox_GetNextSelected (byval self as _VListBox ptr, byval cookie as uinteger ptr) as integer
declare sub wxVListBox_GetMargins (byval self as _VListBox ptr, byval pt as wxPoint ptr)
declare function wxVListBox_GetSelectionBackground (byval self as _VListBox ptr) as wxColour ptr
declare sub wxVListBox_SetItemCount (byval self as _VListBox ptr, byval count as integer)
declare sub wxVListBox_Clear (byval self as _VListBox ptr)
declare sub wxVListBox_SetSelection (byval self as _VListBox ptr, byval selection as integer)
declare function wxVListBox_Select (byval self as _VListBox ptr, byval item as integer, byval select as integer) as integer
declare function wxVListBox_SelectRange (byval self as _VListBox ptr, byval from as integer, byval to as integer) as integer
declare sub wxVListBox_Toggle (byval self as _VListBox ptr, byval item as integer)
declare function wxVListBox_SelectAll (byval self as _VListBox ptr) as integer
declare function wxVListBox_DeselectAll (byval self as _VListBox ptr) as integer
declare sub wxVListBox_SetMargins (byval self as _VListBox ptr, byval pt as wxPoint ptr)
declare sub wxVListBox_SetMargins2 (byval self as _VListBox ptr, byval x as integer, byval y as integer)
declare sub wxVListBox_SetSelectionBackground (byval self as _VListBox ptr, byval col as wxColour ptr)

#endif
