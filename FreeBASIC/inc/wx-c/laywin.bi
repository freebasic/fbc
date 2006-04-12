''
''
'' laywin -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __wxc_laywin_bi__
#define __wxc_laywin_bi__

#include once "wx-c/wx.bi"


declare function wxSashLayoutWindow cdecl alias "wxSashLayoutWindow_ctor" () as wxSashLayoutWindow ptr
declare function wxSashLayoutWindow_Create cdecl alias "wxSashLayoutWindow_Create" (byval self as wxSashLayoutWindow ptr, byval parent as wxWindow ptr, byval id as wxWindowID, byval pos as wxPoint ptr, byval size as wxSize ptr, byval style as integer, byval name as zstring ptr) as integer
declare function wxSashLayoutWindow_GetAlignment cdecl alias "wxSashLayoutWindow_GetAlignment" (byval self as wxSashLayoutWindow ptr) as wxLayoutAlignment
declare sub wxSashLayoutWindow_SetAlignment cdecl alias "wxSashLayoutWindow_SetAlignment" (byval self as wxSashLayoutWindow ptr, byval align as wxLayoutAlignment)
declare function wxSashLayoutWindow_GetOrientation cdecl alias "wxSashLayoutWindow_GetOrientation" (byval self as wxSashLayoutWindow ptr) as wxLayoutOrientation
declare sub wxSashLayoutWindow_SetOrientation cdecl alias "wxSashLayoutWindow_SetOrientation" (byval self as wxSashLayoutWindow ptr, byval orient as wxLayoutOrientation)
declare sub wxSashLayoutWindow_SetDefaultSize cdecl alias "wxSashLayoutWindow_SetDefaultSize" (byval self as wxSashLayoutWindow ptr, byval size as wxSize ptr)
declare function wxLayoutAlgorithm cdecl alias "wxLayoutAlgorithm_ctor" () as wxLayoutAlgorithm ptr
declare function wxLayoutAlgorithm_LayoutMDIFrame cdecl alias "wxLayoutAlgorithm_LayoutMDIFrame" (byval self as wxLayoutAlgorithm ptr, byval frame as wxMDIParentFrame ptr, byval rect as wxRect ptr) as integer
declare function wxLayoutAlgorithm_LayoutFrame cdecl alias "wxLayoutAlgorithm_LayoutFrame" (byval self as wxLayoutAlgorithm ptr, byval frame as wxFrame ptr, byval mainWindow as wxWindow ptr) as integer
declare function wxLayoutAlgorithm_LayoutWindow cdecl alias "wxLayoutAlgorithm_LayoutWindow" (byval self as wxLayoutAlgorithm ptr, byval frame as wxWindow ptr, byval mainWindow as wxWindow ptr) as integer
declare function wxQueryLayoutInfoEvent cdecl alias "wxQueryLayoutInfoEvent_ctor" (byval id as wxWindowID) as wxQueryLayoutInfoEvent ptr
declare sub wxQueryLayoutInfoEvent_SetRequestedLength cdecl alias "wxQueryLayoutInfoEvent_SetRequestedLength" (byval self as wxQueryLayoutInfoEvent ptr, byval length as integer)
declare function wxQueryLayoutInfoEvent_GetRequestedLength cdecl alias "wxQueryLayoutInfoEvent_GetRequestedLength" (byval self as wxQueryLayoutInfoEvent ptr) as integer
declare sub wxQueryLayoutInfoEvent_SetFlags cdecl alias "wxQueryLayoutInfoEvent_SetFlags" (byval self as wxQueryLayoutInfoEvent ptr, byval flags as integer)
declare function wxQueryLayoutInfoEvent_GetFlags cdecl alias "wxQueryLayoutInfoEvent_GetFlags" (byval self as wxQueryLayoutInfoEvent ptr) as integer
declare sub wxQueryLayoutInfoEvent_SetSize cdecl alias "wxQueryLayoutInfoEvent_SetSize" (byval self as wxQueryLayoutInfoEvent ptr, byval size as wxSize ptr)
declare sub wxQueryLayoutInfoEvent_GetSize cdecl alias "wxQueryLayoutInfoEvent_GetSize" (byval self as wxQueryLayoutInfoEvent ptr, byval size as wxSize ptr)
declare sub wxQueryLayoutInfoEvent_SetOrientation cdecl alias "wxQueryLayoutInfoEvent_SetOrientation" (byval self as wxQueryLayoutInfoEvent ptr, byval orient as wxLayoutOrientation)
declare function wxQueryLayoutInfoEvent_GetOrientation cdecl alias "wxQueryLayoutInfoEvent_GetOrientation" (byval self as wxQueryLayoutInfoEvent ptr) as wxLayoutOrientation
declare sub wxQueryLayoutInfoEvent_SetAlignment cdecl alias "wxQueryLayoutInfoEvent_SetAlignment" (byval self as wxQueryLayoutInfoEvent ptr, byval align as wxLayoutAlignment)
declare function wxQueryLayoutInfoEvent_GetAlignment cdecl alias "wxQueryLayoutInfoEvent_GetAlignment" (byval self as wxQueryLayoutInfoEvent ptr) as wxLayoutAlignment
declare function wxCalculateLayoutEvent cdecl alias "wxCalculateLayoutEvent_ctor" (byval id as wxWindowID) as wxCalculateLayoutEvent ptr
declare sub wxCalculateLayoutEvent_SetFlags cdecl alias "wxCalculateLayoutEvent_SetFlags" (byval self as wxCalculateLayoutEvent ptr, byval flags as integer)
declare function wxCalculateLayoutEvent_GetFlags cdecl alias "wxCalculateLayoutEvent_GetFlags" (byval self as wxCalculateLayoutEvent ptr) as integer
declare sub wxCalculateLayoutEvent_SetRect cdecl alias "wxCalculateLayoutEvent_SetRect" (byval self as wxCalculateLayoutEvent ptr, byval rect as wxRect ptr)
declare sub wxCalculateLayoutEvent_GetRect cdecl alias "wxCalculateLayoutEvent_GetRect" (byval self as wxCalculateLayoutEvent ptr, byval rect as wxRect ptr)

#endif
