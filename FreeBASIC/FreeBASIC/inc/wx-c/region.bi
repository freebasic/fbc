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

#include once "wx.bi"

declare function wxRegion alias "wxRegion_ctor" () as wxRegion ptr
declare function wxRegion_ctorByCoords (byval x as wxCoord, byval y as wxCoord, byval w as wxCoord, byval h as wxCoord) as wxRegion ptr
declare function wxRegion_ctorByCorners (byval topLeft as wxPoint ptr, byval bottomRight as wxPoint ptr) as wxRegion ptr
declare function wxRegion_ctorByRect (byval rect as wxRect ptr) as wxRegion ptr
declare function wxRegion_ctorByPoly (byval n as integer, byval points as wxPoint ptr, byval fillStyle as integer) as wxRegion ptr
declare function wxRegion_ctorByBitmap (byval bmp as wxBitmap ptr, byval transColour as wxColour ptr, byval tolerance as integer) as wxRegion ptr
declare function wxRegion_ctorByRegion (byval region as wxRegion ptr) as wxRegion ptr
declare sub wxRegion_dtor (byval self as wxRegion ptr)
declare sub wxRegion_Clear (byval self as wxRegion ptr)
declare function wxRegion_Offset (byval self as wxRegion ptr, byval x as wxCoord, byval y as wxCoord) as integer
declare function wxRegion_Union (byval self as wxRegion ptr, byval x as wxCoord, byval y as wxCoord, byval width as wxCoord, byval height as wxCoord) as integer
declare function wxRegion_UnionRect (byval self as wxRegion ptr, byval rect as wxRect ptr) as integer
declare function wxRegion_UnionRegion (byval self as wxRegion ptr, byval region as wxRegion ptr) as integer
declare function wxRegion_Intersect (byval self as wxRegion ptr, byval x as wxCoord, byval y as wxCoord, byval width as wxCoord, byval height as wxCoord) as integer
declare function wxRegion_IntersectRect (byval self as wxRegion ptr, byval rect as wxRect ptr) as integer
declare function wxRegion_IntersectRegion (byval self as wxRegion ptr, byval region as wxRegion ptr) as integer
declare function wxRegion_Subtract (byval self as wxRegion ptr, byval x as wxCoord, byval y as wxCoord, byval width as wxCoord, byval height as wxCoord) as integer
declare function wxRegion_SubtractRect (byval self as wxRegion ptr, byval rect as wxRect ptr) as integer
declare function wxRegion_SubtractRegion (byval self as wxRegion ptr, byval region as wxRegion ptr) as integer
declare function wxRegion_Xor (byval self as wxRegion ptr, byval x as wxCoord, byval y as wxCoord, byval width as wxCoord, byval height as wxCoord) as integer
declare function wxRegion_XorRect (byval self as wxRegion ptr, byval rect as wxRect ptr) as integer
declare function wxRegion_XorRegion (byval self as wxRegion ptr, byval region as wxRegion ptr) as integer
declare function wxRegion_ContainsCoords (byval self as wxRegion ptr, byval x as integer, byval y as integer) as wxRegionContain ptr
declare function wxRegion_ContainsPoint (byval self as wxRegion ptr, byval pt as wxPoint ptr) as wxRegionContain ptr
declare function wxRegion_ContainsRectCoords (byval self as wxRegion ptr, byval x as integer, byval y as integer, byval width as integer, byval height as integer) as wxRegionContain ptr
declare function wxRegion_ContainsRect (byval self as wxRegion ptr, byval rect as wxRect ptr) as wxRegionContain ptr
declare sub wxRegion_GetBox (byval self as wxRegion ptr, byval rect as wxRect ptr)
declare function wxRegion_IsEmpty (byval self as wxRegion ptr) as integer
declare function wxRegion_ConvertToBitmap (byval self as wxRegion ptr) as wxBitmap ptr
declare function wxRegion_UnionBitmap (byval self as wxRegion ptr, byval bmp as wxBitmap ptr, byval transColour as wxColour ptr, byval tolerance as integer) as integer
declare function wxRegionIterator alias "wxRegionIterator_ctor" () as wxRegionIterator ptr
declare function wxRegionIterator_ctorByRegion (byval region as wxRegion ptr) as wxRegionIterator ptr
declare sub wxRegionIterator_Reset (byval self as wxRegionIterator ptr)
declare sub wxRegionIterator_ResetToRegion (byval self as wxRegionIterator ptr, byval region as wxRegion ptr)
declare function wxRegionIterator_HaveRects (byval self as wxRegionIterator ptr) as integer
declare function wxRegionIterator_GetX (byval self as wxRegionIterator ptr) as wxCoord
declare function wxRegionIterator_GetY (byval self as wxRegionIterator ptr) as wxCoord
declare function wxRegionIterator_GetW (byval self as wxRegionIterator ptr) as wxCoord
declare function wxRegionIterator_GetWidth (byval self as wxRegionIterator ptr) as wxCoord
declare function wxRegionIterator_GetH (byval self as wxRegionIterator ptr) as wxCoord
declare function wxRegionIterator_GetHeight (byval self as wxRegionIterator ptr) as wxCoord
declare sub wxRegionIterator_GetRect (byval self as wxRegionIterator ptr, byval rect as wxRect ptr)

#endif
