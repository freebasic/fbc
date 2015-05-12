#Ifndef __region_bi__
#Define __region_bi__

#Include Once "common.bi"

' class wxRegion
Declare Function wxRegion_ctor WXCALL Alias "wxRegion_ctor" () As wxRegion Ptr
Declare Function wxRegion_ctorByCoords WXCALL Alias "wxRegion_ctorByCoords" (x As wxCoord, y As wxCoord, w As wxCoord, h As wxCoord) As wxRegion Ptr
Declare Function wxRegion_ctorByCorners WXCALL Alias "wxRegion_ctorByCorners" (topLeft As wxPoint Ptr, bottomRight As wxPoint Ptr) As wxRegion Ptr
Declare Function wxRegion_ctorByRect WXCALL Alias "wxRegion_ctorByRect" (r As wxRect Ptr) As wxRegion Ptr
Declare Function wxRegion_ctorByPoly WXCALL Alias "wxRegion_ctorByPoly" (n As size_t, points As wxPoint Ptr, fillStyle As wxInt) As wxRegion Ptr
Declare Function wxRegion_ctorByBitmap WXCALL Alias "wxRegion_ctorByBitmap" (bitmap As wxBitmap Ptr, transColour As wxColour Ptr, tolerance As wxInt) As wxRegion Ptr
Declare Function wxRegion_ctorByRegion WXCALL Alias "wxRegion_ctorByRegion" (region As wxRegion Ptr) As wxRegion Ptr
Declare Sub wxRegion_dtor WXCALL Alias "wxRegion_dtor" (self As wxRegion Ptr)
Declare Sub wxRegion_Clear WXCALL Alias "wxRegion_Clear" (self As wxRegion Ptr)
Declare Function wxRegion_Offset WXCALL Alias "wxRegion_Offset" (self As wxRegion Ptr, x As wxCoord, y As wxCoord) As wxBool
Declare Function wxRegion_Union WXCALL Alias "wxRegion_Union" (self As wxRegion Ptr, x As wxCoord, y As wxCoord, w As wxCoord, h As wxCoord) As wxBool
Declare Function wxRegion_UnionRect WXCALL Alias "wxRegion_UnionRect" (self As wxRegion Ptr, r As wxRect Ptr) As wxBool
Declare Function wxRegion_UnionRegion WXCALL Alias "wxRegion_UnionRegion" (self As wxRegion Ptr, region As wxRegion Ptr) As wxBool
Declare Function wxRegion_Intersect WXCALL Alias "wxRegion_Intersect" (self As wxRegion Ptr, x As wxCoord, y As wxCoord, w As wxCoord, h As wxCoord) As wxBool
Declare Function wxRegion_IntersectRect WXCALL Alias "wxRegion_IntersectRect" (self As wxRegion Ptr, r As wxRect Ptr) As wxBool
Declare Function wxRegion_IntersectRegion WXCALL Alias "wxRegion_IntersectRegion" (self As wxRegion Ptr, region As wxRegion Ptr) As wxBool
Declare Function wxRegion_Subtract WXCALL Alias "wxRegion_Subtract" (self As wxRegion Ptr, x As wxCoord, y As wxCoord, w As wxCoord, h As wxCoord) As wxBool
Declare Function wxRegion_SubtractRect WXCALL Alias "wxRegion_SubtractRect" (self As wxRegion Ptr, r As wxRect Ptr) As wxBool
Declare Function wxRegion_SubtractRegion WXCALL Alias "wxRegion_SubtractRegion" (self As wxRegion Ptr, region As wxRegion Ptr) As wxBool
Declare Function wxRegion_Xor WXCALL Alias "wxRegion_Xor" (self As wxRegion Ptr, x As wxCoord, y As wxCoord, w As wxCoord, h As wxCoord) As wxBool
Declare Function wxRegion_XorRect WXCALL Alias "wxRegion_XorRect" (self As wxRegion Ptr, r As wxRect Ptr) As wxBool
Declare Function wxRegion_XorRegion WXCALL Alias "wxRegion_XorRegion" (self As wxRegion Ptr, region As wxRegion Ptr) As wxBool
Declare Function wxRegion_ContainsCoords WXCALL Alias "wxRegion_ContainsCoords" (self As wxRegion Ptr, x As wxInt, y As wxInt) As wxRegionContain
Declare Function wxRegion_ContainsPoint WXCALL Alias "wxRegion_ContainsPoint" (self As wxRegion Ptr, p As wxPoint Ptr) As wxRegionContain
Declare Function wxRegion_ContainsRectCoords WXCALL Alias "wxRegion_ContainsRectCoords" (self As wxRegion Ptr, x As wxInt, y As wxInt, w As wxInt, h As wxInt) As wxRegionContain
Declare Function wxRegion_ContainsRect WXCALL Alias "wxRegion_ContainsRect" (self As wxRegion Ptr, r As wxRect Ptr) As wxRegionContain
Declare Sub wxRegion_GetBox WXCALL Alias "wxRegion_GetBox" (self As wxRegion Ptr, r As wxRect Ptr)
Declare Function wxRegion_IsEmpty WXCALL Alias "wxRegion_IsEmpty" (self As wxRegion Ptr) As wxBool
Declare Function wxRegion_ConvertToBitmap WXCALL Alias "wxRegion_ConvertToBitmap" (self As wxRegion Ptr) As wxBitmap Ptr
Declare Function wxRegion_UnionBitmap WXCALL Alias "wxRegion_UnionBitmap" (self As wxRegion Ptr, bitmap As wxBitmap Ptr, transColour As wxColour Ptr, tolerance As wxInt) As wxBool

' class wxRegionIterator
Declare Function wxRegionIterator_ctor WXCALL Alias "wxRegionIterator_ctor" () As wxRegionIterator Ptr
Declare Function wxRegionIterator_ctorByRegion WXCALL Alias "wxRegionIterator_ctorByRegion" (region As wxRegion Ptr) As wxRegionIterator Ptr
Declare Sub wxRegionIterator_Reset WXCALL Alias "wxRegionIterator_Reset" (self As wxRegionIterator Ptr)
Declare Sub wxRegionIterator_ResetToRegion WXCALL Alias "wxRegionIterator_ResetToRegion" (self As wxRegionIterator Ptr, region As wxRegion Ptr)
Declare Function wxRegionIterator_HaveRects WXCALL Alias "wxRegionIterator_HaveRects" (self As wxRegionIterator Ptr) As wxBool
Declare Function wxRegionIterator_GetX WXCALL Alias "wxRegionIterator_GetX" (self As wxRegionIterator Ptr) As wxCoord
Declare Function wxRegionIterator_GetY WXCALL Alias "wxRegionIterator_GetY" (self As wxRegionIterator Ptr) As wxCoord
Declare Function wxRegionIterator_GetW WXCALL Alias "wxRegionIterator_GetW" (self As wxRegionIterator Ptr) As wxCoord
Declare Function wxRegionIterator_GetWidth WXCALL Alias "wxRegionIterator_GetWidth" (self As wxRegionIterator Ptr) As wxCoord
Declare Function wxRegionIterator_GetH WXCALL Alias "wxRegionIterator_GetH" (self As wxRegionIterator Ptr) As wxCoord
Declare Function wxRegionIterator_GetHeight WXCALL Alias "wxRegionIterator_GetHeight" (self As wxRegionIterator Ptr) As wxCoord
Declare Sub wxRegionIterator_GetRect WXCALL Alias "wxRegionIterator_GetRect" (self As wxRegionIterator Ptr, r As wxRect Ptr)

#EndIf ' __region_bi__

