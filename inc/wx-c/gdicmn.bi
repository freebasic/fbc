#Ifndef __gdicmn_bi__
#Define __gdicmn_bi__

#Include Once "common.bi"

Declare Function wxGDIObj_GetRedPen WXCALL Alias "wxGDIObj_GetRedPen" () As wxPen Ptr
Declare Function wxGDIObj_GetCyanPen WXCALL Alias "wxGDIObj_GetCyanPen" () As wxPen Ptr
Declare Function wxGDIObj_GetGreenPen WXCALL Alias "wxGDIObj_GetGreenPen" () As wxPen Ptr
Declare Function wxGDIObj_GetBlackPen WXCALL Alias "wxGDIObj_GetBlackPen" () As wxPen Ptr
Declare Function wxGDIObj_GetWhitePen WXCALL Alias "wxGDIObj_GetWhitePen" () As wxPen Ptr
Declare Function wxGDIObj_GetTransparentPen WXCALL Alias "wxGDIObj_GetTransparentPen" () As wxPen Ptr
Declare Function wxGDIObj_GetBlackDashedPen WXCALL Alias "wxGDIObj_GetBlackDashedPen" () As wxPen Ptr
Declare Function wxGDIObj_GetGreyPen WXCALL Alias "wxGDIObj_GetGreyPen" () As wxPen Ptr
Declare Function wxGDIObj_GetMediumGreyPen WXCALL Alias "wxGDIObj_GetMediumGreyPen" () As wxPen Ptr
Declare Function wxGDIObj_GetLightGreyPen WXCALL Alias "wxGDIObj_GetLightGreyPen" () As wxPen Ptr
Declare Function wxNullBitmap_Get WXCALL Alias "wxNullBitmap_Get" () As wxBitmap Ptr
Declare Function wxNullIcon_Get WXCALL Alias "wxNullIcon_Get" () As wxIcon Ptr
Declare Function wxNullCursor_Get WXCALL Alias "wxNullCursor_Get" () As wxCursor Ptr
Declare Function wxNullPen_Get WXCALL Alias "wxNullPen_Get" () As wxPen Ptr
Declare Function wxNullBrush_Get WXCALL Alias "wxNullBrush_Get" () As wxBrush Ptr
Declare Function wxNullPalette_Get WXCALL Alias "wxNullPalette_Get" () As wxPalette Ptr
Declare Function wxNullFont_Get WXCALL Alias "wxNullFont_Get" () As wxFont Ptr
Declare Function wxNullColour_Get WXCALL Alias "wxNullColour_Get" () As wxColour Ptr
Declare Function wxBLUE_BRUSH_Get WXCALL Alias "wxBLUE_BRUSH_Get" () As wxBrush Ptr
Declare Function wxGREEN_BRUSH_Get WXCALL Alias "wxGREEN_BRUSH_Get" () As wxBrush Ptr
Declare Function wxWHITE_BRUSH_Get WXCALL Alias "wxWHITE_BRUSH_Get" () As wxBrush Ptr
Declare Function wxBLACK_BRUSH_Get WXCALL Alias "wxBLACK_BRUSH_Get" () As wxBrush Ptr
Declare Function wxGREY_BRUSH_Get WXCALL Alias "wxGREY_BRUSH_Get" () As wxBrush Ptr
Declare Function wxMEDIUM_GREY_BRUSH_Get WXCALL Alias "wxMEDIUM_GREY_BRUSH_Get" () As wxBrush Ptr
Declare Function wxLIGHT_GREY_BRUSH_Get WXCALL Alias "wxLIGHT_GREY_BRUSH_Get" () As wxBrush Ptr
Declare Function wxTRANSPARENT_BRUSH_Get WXCALL Alias "wxTRANSPARENT_BRUSH_Get" () As wxBrush Ptr
Declare Function wxCYAN_BRUSH_Get WXCALL Alias "wxCYAN_BRUSH_Get" () As wxBrush Ptr
Declare Function wxRED_BRUSH_Get WXCALL Alias "wxRED_BRUSH_Get" () As wxBrush Ptr

' class wxColourDataBase
Declare Function wxColourDatabase_ctor WXCALL Alias "wxColourDatabase_ctor" () As wxColourDatabase Ptr
Declare Sub wxColourDataBase_dtor WXCALL Alias "wxColourDataBase_dtor" (self As wxColourDatabase Ptr)
Declare Function wxColourDatabase_Find WXCALL Alias "wxColourDatabase_Find" (self As wxColourDatabase Ptr, nam As wxString Ptr) As wxColour Ptr
Declare Function wxColourDatabase_FindName WXCALL Alias "wxColourDatabase_FindName" (self As wxColourDatabase Ptr, col As wxColour Ptr) As wxString Ptr
Declare Sub wxColourDatabase_AddColour WXCALL Alias "wxColourDatabase_AddColour" (self As wxColourDatabase Ptr, nam As wxString Ptr, col As wxColour Ptr)

' class wxPenList
Declare Function wxPenList_ctor WXCALL Alias "wxPenList_ctor" () As wxPenList Ptr
Declare Sub wxPenList_dtor WXCALL Alias "wxPenList_dtor" (self As wxPenList Ptr)
Declare Function wxPenList_ThePenList WXCALL Alias "wxPenList_ThePenList" () As wxPenList Ptr
Declare Function wxPenList_FindOrCreatePen WXCALL Alias "wxPenList_FindOrCreatePen" (self As wxPenList Ptr, col As wxColour Ptr, w As wxInt, style As wxInt) As wxPen Ptr

' class wxBrushList
Declare Function wxBrushList_ctor WXCALL Alias "wxBrushList_ctor" () As wxBrushList Ptr
Declare Sub wxBrushList_dtor WXCALL Alias "wxBrushList_dtor" (self As wxBrushList Ptr)
Declare Function wxBrushList_FindOrCreateBrush WXCALL Alias "wxBrushList_FindOrCreateBrush" (self As wxBrushList Ptr, col As wxColour Ptr, style As wxInt) As wxBrush Ptr
Declare Function wxBrushList_TheBrushList WXCALL Alias "wxBrushList_TheBrushList" () As wxBrushList Ptr

' class wxFontList
Declare Function wxFontList_ctor WXCALL Alias "wxFontList_ctor" () As wxFontList Ptr
Declare Sub wxFontList_dtor WXCALL Alias "wxFontList_dtor" (self As wxFontList Ptr)
Declare Function wxFontList_FindOrCreateFont WXCALL Alias "wxFontList_FindOrCreateFont" (self As wxFontList Ptr, _
                               pointSize As wxInt, _
                               family    As wxInt, _
                               style     As wxInt, _
                               weight    As wxInt, _
                               underline As wxBool, _
                               face      As wxString Ptr, _
                               enc       As wxFontEncoding) As wxFont Ptr
Declare Function wxFontList_TheFontList WXCALL Alias "wxFontList_TheFontList" () As wxFontList Ptr
Declare Function wxSTANDARD_CURSOR_Get WXCALL Alias "wxSTANDARD_CURSOR_Get" () As wxCursor Ptr
Declare Function wxHOURGLASS_CURSOR_Get WXCALL Alias "wxHOURGLASS_CURSOR_Get" () As wxCursor Ptr
Declare Function wxCROSS_CURSOR_Get WXCALL Alias "wxCROSS_CURSOR_Get" () As wxCursor Ptr

#EndIf ' __gdicmn_bi__

