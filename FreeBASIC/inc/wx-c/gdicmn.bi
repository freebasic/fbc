''
''
'' gdicmn -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __wxc_gdicmn_bi__
#define __wxc_gdicmn_bi__

#include once "wx-c/wx.bi"

declare function wxGDIObj_GetRedPen cdecl alias "wxGDIObj_GetRedPen" () as wxPen ptr
declare function wxGDIObj_GetCyanPen cdecl alias "wxGDIObj_GetCyanPen" () as wxPen ptr
declare function wxGDIObj_GetGreenPen cdecl alias "wxGDIObj_GetGreenPen" () as wxPen ptr
declare function wxGDIObj_GetBlackPen cdecl alias "wxGDIObj_GetBlackPen" () as wxPen ptr
declare function wxGDIObj_GetWhitePen cdecl alias "wxGDIObj_GetWhitePen" () as wxPen ptr
declare function wxGDIObj_GetTransparentPen cdecl alias "wxGDIObj_GetTransparentPen" () as wxPen ptr
declare function wxGDIObj_GetBlackDashedPen cdecl alias "wxGDIObj_GetBlackDashedPen" () as wxPen ptr
declare function wxGDIObj_GetGreyPen cdecl alias "wxGDIObj_GetGreyPen" () as wxPen ptr
declare function wxGDIObj_GetMediumGreyPen cdecl alias "wxGDIObj_GetMediumGreyPen" () as wxPen ptr
declare function wxGDIObj_GetLightGreyPen cdecl alias "wxGDIObj_GetLightGreyPen" () as wxPen ptr
declare function wxNullBitmap_Get cdecl alias "wxNullBitmap_Get" () as wxBitmap ptr
declare function wxNullIcon_Get cdecl alias "wxNullIcon_Get" () as wxIcon ptr
declare function wxNullCursor_Get cdecl alias "wxNullCursor_Get" () as wxCursor ptr
declare function wxNullPen_Get cdecl alias "wxNullPen_Get" () as wxPen ptr
declare function wxNullBrush_Get cdecl alias "wxNullBrush_Get" () as wxBrush ptr
declare function wxNullPalette_Get cdecl alias "wxNullPalette_Get" () as wxPalette ptr
declare function wxNullFont_Get cdecl alias "wxNullFont_Get" () as wxFont ptr
declare function wxNullColour_Get cdecl alias "wxNullColour_Get" () as wxColour ptr
declare function wxBLUE_BRUSH_Get cdecl alias "wxBLUE_BRUSH_Get" () as wxBrush ptr
declare function wxGREEN_BRUSH_Get cdecl alias "wxGREEN_BRUSH_Get" () as wxBrush ptr
declare function wxWHITE_BRUSH_Get cdecl alias "wxWHITE_BRUSH_Get" () as wxBrush ptr
declare function wxBLACK_BRUSH_Get cdecl alias "wxBLACK_BRUSH_Get" () as wxBrush ptr
declare function wxGREY_BRUSH_Get cdecl alias "wxGREY_BRUSH_Get" () as wxBrush ptr
declare function wxMEDIUM_GREY_BRUSH_Get cdecl alias "wxMEDIUM_GREY_BRUSH_Get" () as wxBrush ptr
declare function wxLIGHT_GREY_BRUSH_Get cdecl alias "wxLIGHT_GREY_BRUSH_Get" () as wxBrush ptr
declare function wxTRANSPARENT_BRUSH_Get cdecl alias "wxTRANSPARENT_BRUSH_Get" () as wxBrush ptr
declare function wxCYAN_BRUSH_Get cdecl alias "wxCYAN_BRUSH_Get" () as wxBrush ptr
declare function wxRED_BRUSH_Get cdecl alias "wxRED_BRUSH_Get" () as wxBrush ptr
declare function wxColourDatabase cdecl alias "wxColourDatabase_ctor" () as wxColourDatabase ptr
declare sub wxColourDataBase_dtor cdecl alias "wxColourDataBase_dtor" (byval self as wxColourDatabase ptr)
declare function wxColourDatabase_Find cdecl alias "wxColourDatabase_Find" (byval self as wxColourDatabase ptr, byval name as zstring ptr) as wxColour ptr
declare function wxColourDatabase_FindName cdecl alias "wxColourDatabase_FindName" (byval self as wxColourDatabase ptr, byval colour as wxColour ptr) as wxString ptr
declare sub wxColourDatabase_AddColour cdecl alias "wxColourDatabase_AddColour" (byval self as wxColourDatabase ptr, byval name as zstring ptr, byval colour as wxColour ptr)
declare function wxPenList cdecl alias "wxPenList_ctor" () as wxPenList ptr
declare sub wxPenList_AddPen cdecl alias "wxPenList_AddPen" (byval self as wxPenList ptr, byval pen as wxPen ptr)
declare sub wxPenList_RemovePen cdecl alias "wxPenList_RemovePen" (byval self as wxPenList ptr, byval pen as wxPen ptr)
declare function wxPenList_FindOrCreatePen cdecl alias "wxPenList_FindOrCreatePen" (byval self as wxPenList ptr, byval colour as wxColour ptr, byval width as integer, byval style as integer) as wxPen ptr
declare function wxBrushList cdecl alias "wxBrushList_ctor" () as wxBrushList ptr
declare sub wxBrushList_AddPen cdecl alias "wxBrushList_AddPen" (byval self as wxBrushList ptr, byval brush as wxBrush ptr)
declare sub wxBrushList_RemovePen cdecl alias "wxBrushList_RemovePen" (byval self as wxBrushList ptr, byval brush as wxBrush ptr)
declare function wxBrushList_FindOrCreateBrush cdecl alias "wxBrushList_FindOrCreateBrush" (byval self as wxBrushList ptr, byval colour as wxColour ptr, byval style as integer) as wxBrush ptr
declare function wxFontList cdecl alias "wxFontList_ctor" () as wxFontList ptr
declare sub wxFontList_AddFont cdecl alias "wxFontList_AddFont" (byval self as wxFontList ptr, byval font as wxFont ptr)
declare sub wxFontList_RemoveFont cdecl alias "wxFontList_RemoveFont" (byval self as wxFontList ptr, byval font as wxFont ptr)
declare function wxFontList_FindOrCreateFont cdecl alias "wxFontList_FindOrCreateFont" (byval self as wxFontList ptr, byval pointSize as integer, byval family as integer, byval style as integer, byval weight as integer, byval underline as integer, byval face as zstring ptr, byval encoding as wxFontEncoding) as wxFont ptr
declare function wxBitmapList cdecl alias "wxBitmapList_ctor" () as wxBitmapList ptr
declare sub wxBitmapList_AddBitmap cdecl alias "wxBitmapList_AddBitmap" (byval self as wxBitmapList ptr, byval bitmap as wxBitmap ptr)
declare sub wxBitmapList_RemoveBitmap cdecl alias "wxBitmapList_RemoveBitmap" (byval self as wxBitmapList ptr, byval bitmap as wxBitmap ptr)
declare function wxSTANDARD_CURSOR_Get cdecl alias "wxSTANDARD_CURSOR_Get" () as wxCursor ptr
declare function wxHOURGLASS_CURSOR_Get cdecl alias "wxHOURGLASS_CURSOR_Get" () as wxCursor ptr
declare function wxCROSS_CURSOR_Get cdecl alias "wxCROSS_CURSOR_Get" () as wxCursor ptr

#endif
