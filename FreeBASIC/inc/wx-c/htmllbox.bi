''
''
'' htmllbox -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __htmllbox_bi__
#define __htmllbox_bi__

#include once "wx-c/wx.bi"


type Virtual_VoidNoParams as sub ( )
type Virtual_VoidSizeT as sub (byval as integer)
type Virtual_wxStringSizeT as function (byval as integer) as byte
type Virtual_wxColourwxColour as function (byval as wxColour ptr) as wxColour
type Virtual_OnDrawItem as sub (byval as wxDC ptr, byval as wxRect ptr, byval as integer)
type Virtual_OnMeasureItem as function (byval as integer) as wxCoord

declare function wxHtmlListBox_ctor2 cdecl alias "wxHtmlListBox_ctor2" (byval parent as wxWindow ptr, byval id as wxWindowID, byval pos as wxPoint ptr, byval size as wxSize ptr, byval style as integer, byval name as zstring ptr) as wxHtmlListBox ptr
declare sub wxHtmlListBox_RegisterVirtual cdecl alias "wxHtmlListBox_RegisterVirtual" (byval self as _HtmlListBox ptr, byval refreshAll as Virtual_VoidNoParams, byval setItemCount as Virtual_VoidSizeT, byval onGetItem as Virtual_wxStringSizeT, byval onGetItemMarkup as Virtual_wxStringSizeT, byval getSelectedTextColour as Virtual_wxColourwxColour, byval getSelectedTextBgColour as Virtual_wxColourwxColour, byval onDrawItem as Virtual_OnDrawItem, byval onMeasureItem as Virtual_OnMeasureItem, byval onDrawSeparator as Virtual_OnDrawItem, byval onDrawBackground as Virtual_OnDrawItem, byval onGetLineHeight as Virtual_OnMeasureItem)
declare function wxHtmlListBox_Create cdecl alias "wxHtmlListBox_Create" (byval self as _HtmlListBox ptr, byval parent as wxWindow ptr, byval id as wxWindowID, byval pos as wxPoint ptr, byval size as wxSize ptr, byval style as integer, byval name as zstring ptr) as integer
declare sub wxHtmlListBox_RefreshAll cdecl alias "wxHtmlListBox_RefreshAll" (byval self as _HtmlListBox ptr)
declare sub wxHtmlListBox_SetItemCount cdecl alias "wxHtmlListBox_SetItemCount" (byval self as _HtmlListBox ptr, byval count as integer)
declare function wxHtmlListBox_OnGetItemMarkup cdecl alias "wxHtmlListBox_OnGetItemMarkup" (byval self as _HtmlListBox ptr, byval n as integer) as wxString ptr
declare function wxHtmlListBox_GetSelectedTextColour cdecl alias "wxHtmlListBox_GetSelectedTextColour" (byval self as _HtmlListBox ptr, byval colFg as wxColour ptr) as wxColour ptr
declare function wxHtmlListBox_GetSelectedTextBgColour cdecl alias "wxHtmlListBox_GetSelectedTextBgColour" (byval self as _HtmlListBox ptr, byval colBg as wxColour ptr) as wxColour ptr
declare sub wxHtmlListBox_OnDrawItem cdecl alias "wxHtmlListBox_OnDrawItem" (byval self as _HtmlListBox ptr, byval dc as wxDC ptr, byval rect as wxRect ptr, byval n as integer)
declare function wxHtmlListBox_OnMeasureItem cdecl alias "wxHtmlListBox_OnMeasureItem" (byval self as _HtmlListBox ptr, byval n as integer) as wxCoord
declare sub wxHtmlListBox_OnSize cdecl alias "wxHtmlListBox_OnSize" (byval self as _HtmlListBox ptr, byval event as wxSizeEvent ptr)
declare sub wxHtmlListBox_Init cdecl alias "wxHtmlListBox_Init" (byval self as _HtmlListBox ptr)
declare sub wxHtmlListBox_CacheItem cdecl alias "wxHtmlListBox_CacheItem" (byval self as _HtmlListBox ptr, byval n as integer)
declare sub wxHtmlListBox_OnDrawSeparator cdecl alias "wxHtmlListBox_OnDrawSeparator" (byval self as _HtmlListBox ptr, byval dc as wxDC ptr, byval rect as wxRect ptr, byval n as integer)
declare sub wxHtmlListBox_OnDrawBackground cdecl alias "wxHtmlListBox_OnDrawBackground" (byval self as _HtmlListBox ptr, byval dc as wxDC ptr, byval rect as wxRect ptr, byval n as integer)
declare function wxHtmlListBox_OnGetLineHeight cdecl alias "wxHtmlListBox_OnGetLineHeight" (byval self as _HtmlListBox ptr, byval line as integer) as wxCoord

#endif
