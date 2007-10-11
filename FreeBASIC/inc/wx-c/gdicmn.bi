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

#include once "wx.bi"

declare function wxGDIObj_GetRedPen () as wxPen ptr
declare function wxGDIObj_GetCyanPen () as wxPen ptr
declare function wxGDIObj_GetGreenPen () as wxPen ptr
declare function wxGDIObj_GetBlackPen () as wxPen ptr
declare function wxGDIObj_GetWhitePen () as wxPen ptr
declare function wxGDIObj_GetTransparentPen () as wxPen ptr
declare function wxGDIObj_GetBlackDashedPen () as wxPen ptr
declare function wxGDIObj_GetGreyPen () as wxPen ptr
declare function wxGDIObj_GetMediumGreyPen () as wxPen ptr
declare function wxGDIObj_GetLightGreyPen () as wxPen ptr
declare function wxNullBitmap_Get () as wxBitmap ptr
declare function wxNullIcon_Get () as wxIcon ptr
declare function wxNullCursor_Get () as wxCursor ptr
declare function wxNullPen_Get () as wxPen ptr
declare function wxNullBrush_Get () as wxBrush ptr
declare function wxNullPalette_Get () as wxPalette ptr
declare function wxNullFont_Get () as wxFont ptr
declare function wxNullColour_Get () as wxColour ptr
declare function wxBLUE_BRUSH_Get () as wxBrush ptr
declare function wxGREEN_BRUSH_Get () as wxBrush ptr
declare function wxWHITE_BRUSH_Get () as wxBrush ptr
declare function wxBLACK_BRUSH_Get () as wxBrush ptr
declare function wxGREY_BRUSH_Get () as wxBrush ptr
declare function wxMEDIUM_GREY_BRUSH_Get () as wxBrush ptr
declare function wxLIGHT_GREY_BRUSH_Get () as wxBrush ptr
declare function wxTRANSPARENT_BRUSH_Get () as wxBrush ptr
declare function wxCYAN_BRUSH_Get () as wxBrush ptr
declare function wxRED_BRUSH_Get () as wxBrush ptr
declare function wxColourDatabase alias "wxColourDatabase_ctor" () as wxColourDatabase ptr
declare sub wxColourDataBase_dtor (byval self as wxColourDatabase ptr)
declare function wxColourDatabase_Find (byval self as wxColourDatabase ptr, byval name as zstring ptr) as wxColour ptr
declare function wxColourDatabase_FindName (byval self as wxColourDatabase ptr, byval colour as wxColour ptr) as wxString ptr
declare sub wxColourDatabase_AddColour (byval self as wxColourDatabase ptr, byval name as zstring ptr, byval colour as wxColour ptr)
declare function wxPenList alias "wxPenList_ctor" () as wxPenList ptr
declare sub wxPenList_AddPen (byval self as wxPenList ptr, byval pen as wxPen ptr)
declare sub wxPenList_RemovePen (byval self as wxPenList ptr, byval pen as wxPen ptr)
declare function wxPenList_FindOrCreatePen (byval self as wxPenList ptr, byval colour as wxColour ptr, byval width as integer, byval style as integer) as wxPen ptr
declare function wxBrushList alias "wxBrushList_ctor" () as wxBrushList ptr
declare sub wxBrushList_AddPen (byval self as wxBrushList ptr, byval brush as wxBrush ptr)
declare sub wxBrushList_RemovePen (byval self as wxBrushList ptr, byval brush as wxBrush ptr)
declare function wxBrushList_FindOrCreateBrush (byval self as wxBrushList ptr, byval colour as wxColour ptr, byval style as integer) as wxBrush ptr
declare function wxFontList alias "wxFontList_ctor" () as wxFontList ptr
declare sub wxFontList_AddFont (byval self as wxFontList ptr, byval font as wxFont ptr)
declare sub wxFontList_RemoveFont (byval self as wxFontList ptr, byval font as wxFont ptr)
declare function wxFontList_FindOrCreateFont (byval self as wxFontList ptr, byval pointSize as integer, byval family as integer, byval style as integer, byval weight as integer, byval underline as integer, byval face as zstring ptr, byval encoding as wxFontEncoding) as wxFont ptr
declare function wxBitmapList alias "wxBitmapList_ctor" () as wxBitmapList ptr
declare sub wxBitmapList_AddBitmap (byval self as wxBitmapList ptr, byval bitmap as wxBitmap ptr)
declare sub wxBitmapList_RemoveBitmap (byval self as wxBitmapList ptr, byval bitmap as wxBitmap ptr)
declare function wxSTANDARD_CURSOR_Get () as wxCursor ptr
declare function wxHOURGLASS_CURSOR_Get () as wxCursor ptr
declare function wxCROSS_CURSOR_Get () as wxCursor ptr

#endif
