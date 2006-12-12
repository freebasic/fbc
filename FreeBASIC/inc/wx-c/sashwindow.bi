''
''
'' sashwindow -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __wxc_sashwindow_bi__
#define __wxc_sashwindow_bi__

#include once "wx.bi"


declare function wxSashEdge alias "wxSashEdge_ctor" () as wxSashEdge ptr
declare sub wxSashEdge_dtor (byval self as wxSashEdge ptr)
declare function wxSashEdge_m_show (byval self as wxSashEdge ptr) as integer
declare function wxSashEdge_m_border (byval self as wxSashEdge ptr) as integer
declare function wxSashEdge_m_margin (byval self as wxSashEdge ptr) as integer

declare function wxSashWindow alias "wxSashWindow_ctor" () as wxSashWindow ptr
declare function wxSashWindow_Create (byval self as wxSashWindow ptr, byval parent as wxWindow ptr, byval id as wxWindowID, byval pos as wxPoint ptr, byval size as wxSize ptr, byval style as integer, byval name as zstring ptr) as integer
declare sub wxSashWindow_SetSashVisible (byval self as wxSashWindow ptr, byval edge as wxSashEdgePosition, byval sash as integer)
declare function wxSashWindow_GetSashVisible (byval self as wxSashWindow ptr, byval edge as wxSashEdgePosition) as integer
declare sub wxSashWindow_SetSashBorder (byval self as wxSashWindow ptr, byval edge as wxSashEdgePosition, byval border as integer)
declare function wxSashWindow_HasBorder (byval self as wxSashWindow ptr, byval edge as wxSashEdgePosition) as integer
declare function wxSashWindow_GetEdgeMargin (byval self as wxSashWindow ptr, byval edge as wxSashEdgePosition) as integer
declare sub wxSashWindow_SetDefaultBorderSize (byval self as wxSashWindow ptr, byval with as integer)
declare function wxSashWindow_GetDefaultBorderSize (byval self as wxSashWindow ptr) as integer
declare sub wxSashWindow_SetExtraBorderSize (byval self as wxSashWindow ptr, byval width as integer)
declare function wxSashWindow_GetExtraBorderSize (byval self as wxSashWindow ptr) as integer
declare sub wxSashWindow_SetMinimumSizeX (byval self as wxSashWindow ptr, byval min as integer)
declare sub wxSashWindow_SetMinimumSizeY (byval self as wxSashWindow ptr, byval min as integer)
declare function wxSashWindow_GetMinimumSizeX (byval self as wxSashWindow ptr) as integer
declare function wxSashWindow_GetMinimumSizeY (byval self as wxSashWindow ptr) as integer
declare sub wxSashWindow_SetMaximumSizeX (byval self as wxSashWindow ptr, byval max as integer)
declare sub wxSashWindow_SetMaximumSizeY (byval self as wxSashWindow ptr, byval max as integer)
declare function wxSashWindow_GetMaximumSizeX (byval self as wxSashWindow ptr) as integer
declare function wxSashWindow_GetMaximumSizeY (byval self as wxSashWindow ptr) as integer
declare function wxSashEvent alias "wxSashEvent_ctor" (byval id as integer, byval edge as wxSashEdgePosition) as wxSashEvent ptr
declare sub wxSashEvent_SetEdge (byval self as wxSashEvent ptr, byval edge as wxSashEdgePosition)
declare function wxSashEvent_GetEdge (byval self as wxSashEvent ptr) as wxSashEdgePosition ptr
declare sub wxSashEvent_SetDragRect (byval self as wxSashEvent ptr, byval rect as wxRect ptr)
declare sub wxSashEvent_GetDragRect (byval self as wxSashEvent ptr, byval rect as wxRect ptr)
declare sub wxSashEvent_SetDragStatus (byval self as wxSashEvent ptr, byval status as wxSashDragStatus)
declare function wxSashEvent_GetDragStatus (byval self as wxSashEvent ptr) as wxSashDragStatus

#endif
