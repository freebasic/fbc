''
''
'' htmllbox -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __wxc_htmllbox_bi__
#define __wxc_htmllbox_bi__

#include once "wx.bi"


type Virtual_VoidNoParams as sub WXCALL ( )
type Virtual_VoidSizeT as sub WXCALL (byval as integer)
type Virtual_wxStringSizeT as function WXCALL (byval as integer) as byte
type Virtual_wxColourwxColour as function WXCALL (byval as wxColour ptr) as wxColour ptr
type Virtual_OnDrawItem as sub WXCALL (byval as wxDC ptr, byval as wxRect ptr, byval as integer)
type Virtual_OnMeasureItem as function WXCALL (byval as integer) as wxCoord

declare function wxHtmlListBox_ctor2 (byval parent as wxWindow ptr, byval id as wxWindowID, byval pos as wxPoint ptr, byval size as wxSize ptr, byval style as integer, byval name as zstring ptr) as wxHtmlListBox ptr
declare sub wxHtmlListBox_RegisterVirtual (byval self as _HtmlListBox ptr, byval refreshAll as Virtual_VoidNoParams, byval setItemCount as Virtual_VoidSizeT, byval onGetItem as Virtual_wxStringSizeT, byval onGetItemMarkup as Virtual_wxStringSizeT, byval getSelectedTextColour as Virtual_wxColourwxColour, byval getSelectedTextBgColour as Virtual_wxColourwxColour, byval onDrawItem as Virtual_OnDrawItem, byval onMeasureItem as Virtual_OnMeasureItem, byval onDrawSeparator as Virtual_OnDrawItem, byval onDrawBackground as Virtual_OnDrawItem, byval onGetLineHeight as Virtual_OnMeasureItem)
declare function wxHtmlListBox_Create (byval self as _HtmlListBox ptr, byval parent as wxWindow ptr, byval id as wxWindowID, byval pos as wxPoint ptr, byval size as wxSize ptr, byval style as integer, byval name as zstring ptr) as integer
declare sub wxHtmlListBox_RefreshAll (byval self as _HtmlListBox ptr)
declare sub wxHtmlListBox_SetItemCount (byval self as _HtmlListBox ptr, byval count as integer)
declare function wxHtmlListBox_OnGetItemMarkup (byval self as _HtmlListBox ptr, byval n as integer) as wxString ptr
declare function wxHtmlListBox_GetSelectedTextColour (byval self as _HtmlListBox ptr, byval colFg as wxColour ptr) as wxColour ptr
declare function wxHtmlListBox_GetSelectedTextBgColour (byval self as _HtmlListBox ptr, byval colBg as wxColour ptr) as wxColour ptr
declare sub wxHtmlListBox_OnDrawItem (byval self as _HtmlListBox ptr, byval dc as wxDC ptr, byval rect as wxRect ptr, byval n as integer)
declare function wxHtmlListBox_OnMeasureItem (byval self as _HtmlListBox ptr, byval n as integer) as wxCoord
declare sub wxHtmlListBox_OnSize (byval self as _HtmlListBox ptr, byval event as wxSizeEvent ptr)
declare sub wxHtmlListBox_Init (byval self as _HtmlListBox ptr)
declare sub wxHtmlListBox_CacheItem (byval self as _HtmlListBox ptr, byval n as integer)
declare sub wxHtmlListBox_OnDrawSeparator (byval self as _HtmlListBox ptr, byval dc as wxDC ptr, byval rect as wxRect ptr, byval n as integer)
declare sub wxHtmlListBox_OnDrawBackground (byval self as _HtmlListBox ptr, byval dc as wxDC ptr, byval rect as wxRect ptr, byval n as integer)
declare function wxHtmlListBox_OnGetLineHeight (byval self as _HtmlListBox ptr, byval line as integer) as wxCoord

#endif
