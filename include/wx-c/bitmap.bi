''
''
'' bitmap -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __wxc_bitmap_bi__
#define __wxc_bitmap_bi__

#include once "wx.bi"

declare function wxBitmap alias "wxBitmap_ctor" () as wxBitmap ptr
declare function wxBitmap_ctorByImage (byval image as wxImage ptr, byval depth as integer) as wxBitmap ptr
declare function wxBitmap_ctorByName (byval name as zstring ptr, byval type as integer) as wxBitmap ptr
declare function wxBitmap_ctorBySize (byval width as integer, byval height as integer, byval depth as integer) as wxBitmap ptr
declare function wxBitmap_ctorByBitmap (byval bitmap as wxBitmap ptr) as wxBitmap ptr
declare function wxBitmap_ConvertToImage (byval self as wxBitmap ptr) as wxImage ptr
declare function wxBitmap_GetHeight (byval self as wxBitmap ptr) as integer
declare sub wxBitmap_SetHeight (byval self as wxBitmap ptr, byval height as integer)
declare function wxBitmap_GetWidth (byval self as wxBitmap ptr) as integer
declare sub wxBitmap_SetWidth (byval self as wxBitmap ptr, byval width as integer)
declare function wxBitmap_LoadFile (byval self as wxBitmap ptr, byval name as zstring ptr, byval type as wxBitmapType) as integer
declare function wxBitmap_SaveFile (byval self as wxBitmap ptr, byval name as zstring ptr, byval type as wxBitmapType, byval palette as wxPalette ptr) as integer
declare function wxBitmap_Ok (byval self as wxBitmap ptr) as integer
declare function wxBitmap_GetDepth (byval self as wxBitmap ptr) as integer
declare sub wxBitmap_SetDepth (byval self as wxBitmap ptr, byval depth as integer)
declare function wxBitmap_GetSubBitmap (byval self as wxBitmap ptr, byval rect as wxRect ptr) as wxBitmap ptr
declare function wxBitmap_GetMask (byval self as wxBitmap ptr) as wxMask ptr
declare sub wxBitmap_SetMask (byval self as wxBitmap ptr, byval mask as wxMask ptr)
declare function wxBitmap_GetPalette (byval self as wxBitmap ptr) as wxPalette ptr
declare function wxBitmap_GetColourMap (byval self as wxBitmap ptr) as wxPalette ptr
declare function wxBitmap_CopyFromIcon (byval self as wxBitmap ptr, byval icon as wxIcon ptr) as integer
declare function wxMask alias "wxMask_ctor" () as wxMask ptr
declare function wxMask_ctorByBitmpaColour (byval bitmap as wxBitmap ptr, byval colour as wxColour ptr) as wxMask ptr
declare function wxMask_ctorByBitmapIndex (byval bitmap as wxBitmap ptr, byval paletteIndex as integer) as wxMask ptr
declare function wxMask_ctorByBitmap (byval bitmap as wxBitmap ptr) as wxMask ptr
declare function wxMask_CreateByBitmapColour (byval self as wxMask ptr, byval bitmap as wxBitmap ptr, byval colour as wxColour ptr) as integer
declare function wxMask_CreateByBitmapIndex (byval self as wxMask ptr, byval bitmap as wxBitmap ptr, byval paletteIndex as integer) as integer
declare function wxMask_CreateByBitmap (byval self as wxMask ptr, byval bitmap as wxBitmap ptr) as integer

#endif
