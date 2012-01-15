#Ifndef __bitmap_bi__
#Define __bitmap_bi__

#Include Once "common.bi"

Declare Sub wxBitmap_AddHandler WXCALL Alias "wxBitmap_AddHandler" (handler As wxBitmapHandler Ptr)
Declare Sub wxBitmap_CleanUpHandlers WXCALL Alias "wxBitmap_CleanUpHandlers" ()

' class wxBitmap
Declare Function wxBitmap_NullBitmap WXCALL Alias "wxBitmap_NullBitmap" () As wxBitmap Ptr
Declare Function wxBitmap_ctor WXCALL Alias "wxBitmap_ctor" () As wxBitmap Ptr
Declare Function wxBitmap_ctorByImage WXCALL Alias "wxBitmap_ctorByImage" (image As wxImage Ptr, depth As wxInt = -1) As wxBitmap Ptr
Declare Function wxBitmap_ctorByName WXCALL Alias "wxBitmap_ctorByName" (nam As wxString Ptr, typ As wxInt) As wxBitmap Ptr
Declare Function wxBitmap_ctorBySize WXCALL Alias "wxBitmap_ctorBySize" (w As wxInt, h As wxInt, depth As wxInt) As wxBitmap Ptr
Declare Function wxBitmap_ctorByBitmap WXCALL Alias "wxBitmap_ctorByBitmap" (bitmap As wxBitmap Ptr) As wxBitmap Ptr
Declare Function wxBitmap_ctorFromXpmData WXCALL Alias "wxBitmap_ctorFromXpmData" (xpm As ZString Ptr) As wxBitmap Ptr
Declare Function wxBitmap_ctorFromBits WXCALL Alias "wxBitmap_ctorFromBits" (pBits As Any Ptr, w As wxInt, h As wxInt) As wxBitmap Ptr
Declare Function wxBitmap_ConvertToImage WXCALL Alias "wxBitmap_ConvertToImage" (self As wxBitmap Ptr) As wxImage Ptr
Declare Function wxBitmap_GetHeight WXCALL Alias "wxBitmap_GetHeight" (self As wxBitmap Ptr) As wxInt
Declare Sub wxBitmap_SetHeight WXCALL Alias "wxBitmap_SetHeight" (self As wxBitmap Ptr, h As wxInt)
Declare Function wxBitmap_GetWidth WXCALL Alias "wxBitmap_GetWidth" (self As wxBitmap Ptr) As wxInt
Declare Sub wxBitmap_SetWidth WXCALL Alias "wxBitmap_SetWidth" (self As wxBitmap Ptr, w As wxInt)
Declare Function wxBitmap_LoadFile WXCALL Alias "wxBitmap_LoadFile" (self As wxBitmap Ptr, filename As wxString Ptr, typ As wxBitmapType) As wxBool
Declare Function wxBitmap_SaveFile WXCALL Alias "wxBitmap_SaveFile" (self As wxBitmap Ptr, filename As wxString Ptr, typ As wxBitmapType, pal As wxPalette Ptr) As wxBool
Declare Function wxBitmap_Ok WXCALL Alias "wxBitmap_Ok" (self As wxBitmap Ptr) As wxBool
Declare Function wxBitmap_GetDepth WXCALL Alias "wxBitmap_GetDepth" (self As wxBitmap Ptr) As wxInt
Declare Sub wxBitmap_SetDepth WXCALL Alias "wxBitmap_SetDepth" (self As wxBitmap Ptr, depth As wxInt)
Declare Function wxBitmap_GetSubBitmap WXCALL Alias "wxBitmap_GetSubBitmap" (self As wxBitmap Ptr, r As wxRect Ptr) As wxBitmap Ptr
Declare Function wxBitmap_GetMask WXCALL Alias "wxBitmap_GetMask" (self As wxBitmap Ptr) As wxMask Ptr
Declare Sub wxBitmap_SetMask WXCALL Alias "wxBitmap_SetMask" (self As wxBitmap Ptr, mask As wxMask Ptr)
Declare Function wxBitmap_GetPalette WXCALL Alias "wxBitmap_GetPalette" (self As wxBitmap Ptr) As wxPalette Ptr
Declare Function wxBitmap_GetColourMap WXCALL Alias "wxBitmap_GetColourMap" (self As wxBitmap Ptr) As wxPalette Ptr
Declare Function wxBitmap_CopyFromIcon WXCALL Alias "wxBitmap_CopyFromIcon" (self As wxBitmap Ptr,icon As wxIcon Ptr) As wxBool

' class wxMask
Declare Function wxMask_ctor WXCALL Alias "wxMask_ctor" () As wxMask Ptr
Declare Function wxMask_ctorByBitmapColour WXCALL Alias "wxMask_ctorByBitmapColour" (bitmap As wxBitmap Ptr, col As wxColour Ptr) As wxMask Ptr
Declare Function wxMask_ctorByBitmapIndex WXCALL Alias "wxMask_ctorByBitmapIndex" (bitmap As wxBitmap Ptr, paletteIndex As wxInt) As wxMask Ptr
Declare Function wxMask_ctorByBitmap WXCALL Alias "wxMask_ctorByBitmap" (bitmap As wxBitmap Ptr) As wxMask Ptr
Declare Function wxMask_CreateByBitmapColour WXCALL Alias "wxMask_CreateByBitmapColour" (self As wxMask Ptr, bitmap As wxBitmap Ptr, col As wxColour Ptr) As wxBool
Declare Function wxMask_CreateByBitmapIndex WXCALL Alias "wxMask_CreateByBitmapIndex" (self As wxMask Ptr, bitmap As wxBitmap Ptr, paletteIndex As wxInt) As wxBool
Declare Function wxMask_CreateByBitmap WXCALL Alias "wxMask_CreateByBitmap" (self As wxMask Ptr, bitmap As wxBitmap Ptr) As wxBool

#EndIf ' __bitmap_bi__

