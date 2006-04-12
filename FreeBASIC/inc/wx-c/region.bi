''
''
'' region -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __wxc_region_bi__
#define __wxc_region_bi__

#include once "wx-c/wx.bi"

declare function wxRegion cdecl alias "wxRegion_ctor" () as wxRegion ptr
declare function wxRegion_ctorByCoords cdecl alias "wxRegion_ctorByCoords" (byval x as wxCoord, byval y as wxCoord, byval w as wxCoord, byval h as wxCoord) as wxRegion ptr
declare function wxRegion_ctorByCorners cdecl alias "wxRegion_ctorByCorners" (byval topLeft as wxPoint ptr, byval bottomRight as wxPoint ptr) as wxRegion ptr
declare function wxRegion_ctorByRect cdecl alias "wxRegion_ctorByRect" (byval rect as wxRect ptr) as wxRegion ptr
declare function wxRegion_ctorByPoly cdecl alias "wxRegion_ctorByPoly" (byval n as integer, byval points as wxPoint ptr, byval fillStyle as integer) as wxRegion ptr
declare function wxRegion_ctorByBitmap cdecl alias "wxRegion_ctorByBitmap" (byval bmp as wxBitmap ptr, byval transColour as wxColour ptr, byval tolerance as integer) as wxRegion ptr
declare function wxRegion_ctorByRegion cdecl alias "wxRegion_ctorByRegion" (byval region as wxRegion ptr) as wxRegion ptr
declare sub wxRegion_dtor cdecl alias "wxRegion_dtor" (byval self as wxRegion ptr)
declare sub wxRegion_Clear cdecl alias "wxRegion_Clear" (byval self as wxRegion ptr)
declare function wxRegion_Offset cdecl alias "wxRegion_Offset" (byval self as wxRegion ptr, byval x as wxCoord, byval y as wxCoord) as integer
declare function wxRegion_Union cdecl alias "wxRegion_Union" (byval self as wxRegion ptr, byval x as wxCoord, byval y as wxCoord, byval width as wxCoord, byval height as wxCoord) as integer
declare function wxRegion_UnionRect cdecl alias "wxRegion_UnionRect" (byval self as wxRegion ptr, byval rect as wxRect ptr) as integer
declare function wxRegion_UnionRegion cdecl alias "wxRegion_UnionRegion" (byval self as wxRegion ptr, byval region as wxRegion ptr) as integer
declare function wxRegion_Intersect cdecl alias "wxRegion_Intersect" (byval self as wxRegion ptr, byval x as wxCoord, byval y as wxCoord, byval width as wxCoord, byval height as wxCoord) as integer
declare function wxRegion_IntersectRect cdecl alias "wxRegion_IntersectRect" (byval self as wxRegion ptr, byval rect as wxRect ptr) as integer
declare function wxRegion_IntersectRegion cdecl alias "wxRegion_IntersectRegion" (byval self as wxRegion ptr, byval region as wxRegion ptr) as integer
declare function wxRegion_Subtract cdecl alias "wxRegion_Subtract" (byval self as wxRegion ptr, byval x as wxCoord, byval y as wxCoord, byval width as wxCoord, byval height as wxCoord) as integer
declare function wxRegion_SubtractRect cdecl alias "wxRegion_SubtractRect" (byval self as wxRegion ptr, byval rect as wxRect ptr) as integer
declare function wxRegion_SubtractRegion cdecl alias "wxRegion_SubtractRegion" (byval self as wxRegion ptr, byval region as wxRegion ptr) as integer
declare function wxRegion_Xor cdecl alias "wxRegion_Xor" (byval self as wxRegion ptr, byval x as wxCoord, byval y as wxCoord, byval width as wxCoord, byval height as wxCoord) as integer
declare function wxRegion_XorRect cdecl alias "wxRegion_XorRect" (byval self as wxRegion ptr, byval rect as wxRect ptr) as integer
declare function wxRegion_XorRegion cdecl alias "wxRegion_XorRegion" (byval self as wxRegion ptr, byval region as wxRegion ptr) as integer
declare function wxRegion_ContainsCoords cdecl alias "wxRegion_ContainsCoords" (byval self as wxRegion ptr, byval x as integer, byval y as integer) as wxRegionContain ptr
declare function wxRegion_ContainsPoint cdecl alias "wxRegion_ContainsPoint" (byval self as wxRegion ptr, byval pt as wxPoint ptr) as wxRegionContain ptr
declare function wxRegion_ContainsRectCoords cdecl alias "wxRegion_ContainsRectCoords" (byval self as wxRegion ptr, byval x as integer, byval y as integer, byval width as integer, byval height as integer) as wxRegionContain ptr
declare function wxRegion_ContainsRect cdecl alias "wxRegion_ContainsRect" (byval self as wxRegion ptr, byval rect as wxRect ptr) as wxRegionContain ptr
declare sub wxRegion_GetBox cdecl alias "wxRegion_GetBox" (byval self as wxRegion ptr, byval rect as wxRect ptr)
declare function wxRegion_IsEmpty cdecl alias "wxRegion_IsEmpty" (byval self as wxRegion ptr) as integer
declare function wxRegion_ConvertToBitmap cdecl alias "wxRegion_ConvertToBitmap" (byval self as wxRegion ptr) as wxBitmap ptr
declare function wxRegion_UnionBitmap cdecl alias "wxRegion_UnionBitmap" (byval self as wxRegion ptr, byval bmp as wxBitmap ptr, byval transColour as wxColour ptr, byval tolerance as integer) as integer
declare function wxRegionIterator cdecl alias "wxRegionIterator_ctor" () as wxRegionIterator ptr
declare function wxRegionIterator_ctorByRegion cdecl alias "wxRegionIterator_ctorByRegion" (byval region as wxRegion ptr) as wxRegionIterator ptr
declare sub wxRegionIterator_Reset cdecl alias "wxRegionIterator_Reset" (byval self as wxRegionIterator ptr)
declare sub wxRegionIterator_ResetToRegion cdecl alias "wxRegionIterator_ResetToRegion" (byval self as wxRegionIterator ptr, byval region as wxRegion ptr)
declare function wxRegionIterator_HaveRects cdecl alias "wxRegionIterator_HaveRects" (byval self as wxRegionIterator ptr) as integer
declare function wxRegionIterator_GetX cdecl alias "wxRegionIterator_GetX" (byval self as wxRegionIterator ptr) as wxCoord
declare function wxRegionIterator_GetY cdecl alias "wxRegionIterator_GetY" (byval self as wxRegionIterator ptr) as wxCoord
declare function wxRegionIterator_GetW cdecl alias "wxRegionIterator_GetW" (byval self as wxRegionIterator ptr) as wxCoord
declare function wxRegionIterator_GetWidth cdecl alias "wxRegionIterator_GetWidth" (byval self as wxRegionIterator ptr) as wxCoord
declare function wxRegionIterator_GetH cdecl alias "wxRegionIterator_GetH" (byval self as wxRegionIterator ptr) as wxCoord
declare function wxRegionIterator_GetHeight cdecl alias "wxRegionIterator_GetHeight" (byval self as wxRegionIterator ptr) as wxCoord
declare sub wxRegionIterator_GetRect cdecl alias "wxRegionIterator_GetRect" (byval self as wxRegionIterator ptr, byval rect as wxRect ptr)

#endif
